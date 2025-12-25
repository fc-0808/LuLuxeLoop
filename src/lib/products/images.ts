/**
 * Product Images Database Operations
 * 
 * This file handles database operations for product_images table.
 * The actual image files are stored in Supabase Storage (see storage.ts).
 * This table only stores URLs and metadata.
 */

import { createClient } from '@/lib/supabase/client';
import { uploadProductImage, deleteProductImage } from '@/lib/storage';

export interface ProductImage {
  id: string;
  product_id: string;
  variant_id?: string;
  image_url: string;
  alt_text?: string;
  display_order: number;
  is_primary: boolean;
  file_name?: string;
  file_size_bytes?: number;
  mime_type?: string;
  width_px?: number;
  height_px?: number;
  created_at: string;
  updated_at: string;
}

export interface CreateImageInput {
  product_id: string;
  variant_id?: string;
  image_url: string;
  alt_text?: string;
  display_order?: number;
  is_primary?: boolean;
  file_name?: string;
  file_size_bytes?: number;
  mime_type?: string;
  width_px?: number;
  height_px?: number;
}

/**
 * Upload image file and save metadata to database
 */
export async function createProductImage(
  file: File,
  productId: string,
  options?: {
    variantId?: string;
    altText?: string;
    isPrimary?: boolean;
    displayOrder?: number;
  }
): Promise<{ data: ProductImage | null; error: string | null }> {
  const supabase = createClient();

  // 1. Upload file to Supabase Storage
  const uploadResult = await uploadProductImage(
    file,
    productId,
    options?.variantId
  );

  if (uploadResult.error) {
    return { data: null, error: uploadResult.error };
  }

  // 2. Get image dimensions (optional, for metadata)
  const dimensions = await getImageDimensions(file);

  // 3. Save image metadata to database
  const imageData: CreateImageInput = {
    product_id: productId,
    variant_id: options?.variantId,
    image_url: uploadResult.url,
    alt_text: options?.altText || file.name,
    display_order: options?.displayOrder || 0,
    is_primary: options?.isPrimary || false,
    file_name: file.name,
    file_size_bytes: file.size,
    mime_type: file.type,
    width_px: dimensions.width,
    height_px: dimensions.height,
  };

  // If this is primary, unset other primary images
  if (imageData.is_primary) {
    await supabase
      .from('product_images')
      .update({ is_primary: false })
      .eq('product_id', productId);
  }

  const { data, error } = await supabase
    .from('product_images')
    .insert(imageData)
    .select()
    .single();

  if (error) {
    // If DB insert fails, delete uploaded file
    await deleteProductImage(uploadResult.path);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

/**
 * Get all images for a product
 */
export async function getProductImages(
  productId: string
): Promise<{ data: ProductImage[] | null; error: string | null }> {
  const supabase = createClient();

  const { data, error } = await supabase
    .from('product_images')
    .select('*')
    .eq('product_id', productId)
    .order('display_order', { ascending: true })
    .order('is_primary', { ascending: false });

  return { data, error: error?.message || null };
}

/**
 * Get primary image for a product
 */
export async function getPrimaryProductImage(
  productId: string
): Promise<{ data: ProductImage | null; error: string | null }> {
  const supabase = createClient();

  const { data, error } = await supabase
    .from('product_images')
    .select('*')
    .eq('product_id', productId)
    .eq('is_primary', true)
    .single();

  return { data, error: error?.message || null };
}

/**
 * Delete product image (removes from storage and database)
 */
export async function removeProductImage(
  imageId: string
): Promise<{ error: string | null }> {
  const supabase = createClient();

  // Get image to find storage path
  const { data: image, error: fetchError } = await supabase
    .from('product_images')
    .select('image_url')
    .eq('id', imageId)
    .single();

  if (fetchError) {
    return { error: fetchError.message };
  }

  // Extract path from URL
  const url = new URL(image.image_url);
  const pathParts = url.pathname.split('/');
  const storagePath = pathParts.slice(-2).join('/'); // Get last 2 parts

  // Delete from storage
  await deleteProductImage(storagePath);

  // Delete from database
  const { error } = await supabase
    .from('product_images')
    .delete()
    .eq('id', imageId);

  return { error: error?.message || null };
}

/**
 * Helper to get image dimensions
 */
async function getImageDimensions(file: File): Promise<{ width: number; height: number }> {
  return new Promise((resolve) => {
    const img = new Image();
    const url = URL.createObjectURL(file);
    img.onload = () => {
      URL.revokeObjectURL(url);
      resolve({ width: img.width, height: img.height });
    };
    img.onerror = () => {
      URL.revokeObjectURL(url);
      resolve({ width: 0, height: 0 });
    };
    img.src = url;
  });
}

