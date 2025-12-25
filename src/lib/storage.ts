/**
 * Supabase Storage Utilities for Product Images
 * 
 * HOW IT WORKS:
 * 1. Images (PNG, AVIF, WebP) are uploaded to Supabase Storage (object storage)
 * 2. Storage returns a public URL for the image
 * 3. We store that URL in the product_images table (NOT the binary file)
 * 
 * This is the standard approach - never store binary image data in database tables!
 */

import { createClient } from '@/lib/supabase/client';

const BUCKET_NAME = 'product-images';
const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
const ALLOWED_MIME_TYPES = ['image/png', 'image/jpeg', 'image/webp', 'image/avif'];

export interface ImageUploadResult {
  url: string;
  path: string;
  error?: string;
}

/**
 * Upload a product image to Supabase Storage
 * @param file - The image file (File object from input)
 * @param productId - UUID of the product
 * @param variantId - Optional variant ID if image is variant-specific
 * @returns Public URL of the uploaded image
 */
export async function uploadProductImage(
  file: File,
  productId: string,
  variantId?: string
): Promise<ImageUploadResult> {
  const supabase = createClient();

  // Validate file
  if (!ALLOWED_MIME_TYPES.includes(file.type)) {
    return {
      url: '',
      path: '',
      error: `Invalid file type. Allowed: ${ALLOWED_MIME_TYPES.join(', ')}`,
    };
  }

  if (file.size > MAX_FILE_SIZE) {
    return {
      url: '',
      path: '',
      error: `File too large. Maximum size: ${MAX_FILE_SIZE / 1024 / 1024}MB`,
    };
  }

  // Generate unique file path
  const fileExt = file.name.split('.').pop();
  const fileName = `${productId}/${Date.now()}-${Math.random().toString(36).substring(7)}.${fileExt}`;
  const filePath = variantId ? `${productId}/variants/${variantId}/${fileName}` : fileName;

  try {
    // Upload to Supabase Storage
    const { data, error } = await supabase.storage
      .from(BUCKET_NAME)
      .upload(filePath, file, {
        cacheControl: '3600',
        upsert: false,
      });

    if (error) {
      return {
        url: '',
        path: '',
        error: error.message,
      };
    }

    // Get public URL
    const { data: urlData } = supabase.storage
      .from(BUCKET_NAME)
      .getPublicUrl(filePath);

    return {
      url: urlData.publicUrl,
      path: filePath,
    };
  } catch (error) {
    return {
      url: '',
      path: '',
      error: error instanceof Error ? error.message : 'Upload failed',
    };
  }
}

/**
 * Delete a product image from Supabase Storage
 */
export async function deleteProductImage(imagePath: string): Promise<{ error?: string }> {
  const supabase = createClient();

  const { error } = await supabase.storage
    .from(BUCKET_NAME)
    .remove([imagePath]);

  if (error) {
    return { error: error.message };
  }

  return {};
}

/**
 * Get public URL for an image path
 */
export function getImageUrl(imagePath: string): string {
  const supabase = createClient();
  const { data } = supabase.storage
    .from(BUCKET_NAME)
    .getPublicUrl(imagePath);
  return data.publicUrl;
}

