'use client';

import { useState, useEffect } from 'react';
import { useParams } from 'next/navigation';
import Image from 'next/image';
import Link from 'next/link';
import { createClient } from '@/lib/supabase/client';

interface ProductImage {
  id: string;
  image_url: string;
  is_primary: boolean;
  display_order: number;
  alt_text?: string;
}

interface Product {
  id: string;
  name: string;
  sku: string;
  description: string;
  short_description?: string;
  base_price: number;
  original_price?: number;
  status: string;
  is_featured: boolean;
  is_new: boolean;
  product_images: ProductImage[];
  brands?: { name: string; slug: string };
  product_categories?: { name: string; slug: string };
  frame_materials?: { name: string };
  frame_shapes?: { name: string };
}

export default function ProductDetailPage() {
  const params = useParams();
  const productId = params.id as string;

  const [product, setProduct] = useState<Product | null>(null);
  const [loading, setLoading] = useState(true);
  const [selectedImage, setSelectedImage] = useState<ProductImage | null>(null);
  const [lightboxOpen, setLightboxOpen] = useState(false);
  const [lightboxIndex, setLightboxIndex] = useState(0);

  useEffect(() => {
    if (productId) {
      fetchProduct();
    }
  }, [productId]);

  async function fetchProduct() {
    const supabase = createClient();
    if (!supabase) {
      setLoading(false);
      return;
    }

    try {
      const { data, error } = await supabase
        .from('products')
        .select(`
          *,
          product_images (id, image_url, is_primary, display_order, alt_text),
          brands (name, slug),
          product_categories (name, slug),
          frame_materials (name),
          frame_shapes (name)
        `)
        .eq('id', productId)
        .single();

      if (error) throw error;

      if (data) {
        // Sort images by display_order
        data.product_images = data.product_images?.sort((a: ProductImage, b: ProductImage) => 
          a.display_order - b.display_order
        ) || [];
        
        setProduct(data as Product);
        
        // Set initial selected image
        const primary = data.product_images.find((img: ProductImage) => img.is_primary);
        setSelectedImage(primary || data.product_images[0] || null);
      }
    } catch (error) {
      console.error('Error fetching product:', error);
    } finally {
      setLoading(false);
    }
  }

  const openLightbox = (index: number) => {
    setLightboxIndex(index);
    setLightboxOpen(true);
  };

  const closeLightbox = () => {
    setLightboxOpen(false);
  };

  const nextImage = () => {
    if (product?.product_images) {
      setLightboxIndex((prev) => 
        prev === product.product_images.length - 1 ? 0 : prev + 1
      );
    }
  };

  const prevImage = () => {
    if (product?.product_images) {
      setLightboxIndex((prev) => 
        prev === 0 ? product.product_images.length - 1 : prev - 1
      );
    }
  };

  if (loading) {
    return (
      <main className="min-h-screen bg-white">
        <div className="container-luxury py-20">
          <div className="flex items-center justify-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-emerald-500"></div>
          </div>
        </div>
      </main>
    );
  }

  if (!product) {
    return (
      <main className="min-h-screen bg-white">
        <div className="container-luxury py-20 text-center">
          <h1 className="text-2xl font-medium text-gray-800 mb-4">Product Not Found</h1>
          <Link href="/products" className="text-emerald-600 hover:underline">
            ← Back to Products
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-white">
      {/* Breadcrumb */}
      <div className="bg-gray-50 border-b border-gray-200 py-3">
        <div className="container-luxury">
          <div className="flex items-center gap-2 text-sm text-gray-500">
            <Link href="/" className="hover:text-emerald-600">Home</Link>
            <span>/</span>
            <Link href="/products" className="hover:text-emerald-600">Products</Link>
            {product.product_categories && (
              <>
                <span>/</span>
                <Link 
                  href={`/products?category=${(product.product_categories as any).slug}`}
                  className="hover:text-emerald-600"
                >
                  {(product.product_categories as any).name}
                </Link>
              </>
            )}
            <span>/</span>
            <span className="text-gray-800">{product.sku}</span>
          </div>
        </div>
      </div>

      <div className="container-luxury py-6">
        {/* Product Header */}
        <div className="flex items-center gap-2 mb-6 pb-2 border-b border-gray-200">
          <div className="w-1 h-5 bg-emerald-500 rounded"></div>
          <h1 className="text-lg font-medium text-gray-800">{product.name}</h1>
          <span className="text-sm text-gray-400">({product.product_images.length} photos)</span>
        </div>

        {/* Main Content */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* Images Section */}
          <div>
            {/* Main Image */}
            <div 
              className="relative aspect-square bg-gray-100 rounded-lg overflow-hidden cursor-pointer mb-4"
              onClick={() => selectedImage && openLightbox(
                product.product_images.findIndex(img => img.id === selectedImage.id)
              )}
            >
              {selectedImage ? (
                <Image
                  src={selectedImage.image_url}
                  alt={selectedImage.alt_text || product.name}
                  fill
                  className="object-contain"
                  sizes="(max-width: 1024px) 100vw, 50vw"
                  priority
                />
              ) : (
                <div className="w-full h-full flex items-center justify-center text-gray-400">
                  <svg className="w-16 h-16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                  </svg>
                </div>
              )}
              
              {/* Click to enlarge hint */}
              <div className="absolute bottom-3 right-3 bg-black/60 text-white text-xs px-2 py-1 rounded flex items-center gap-1">
                <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0zM10 7v3m0 0v3m0-3h3m-3 0H7" />
                </svg>
                Click to enlarge
              </div>
            </div>

            {/* Thumbnails Grid */}
            {product.product_images.length > 0 && (
              <div className="grid grid-cols-6 sm:grid-cols-8 gap-2">
                {product.product_images.map((image, index) => (
                  <button
                    key={image.id}
                    onClick={() => setSelectedImage(image)}
                    className={`relative aspect-square rounded overflow-hidden border-2 transition ${
                      selectedImage?.id === image.id 
                        ? 'border-emerald-500' 
                        : 'border-transparent hover:border-gray-300'
                    }`}
                  >
                    <Image
                      src={image.image_url}
                      alt={image.alt_text || `${product.name} ${index + 1}`}
                      fill
                      className="object-cover"
                      sizes="60px"
                    />
                  </button>
                ))}
              </div>
            )}
          </div>

          {/* Product Info */}
          <div>
            <div className="bg-gray-50 rounded-lg p-6">
              <h2 className="text-xl font-medium text-gray-800 mb-2">{product.name}</h2>
              <p className="text-sm text-gray-500 mb-4">SKU: {product.sku}</p>

              {product.brands && (
                <div className="mb-4">
                  <span className="text-sm text-gray-500">Brand: </span>
                  <span className="text-sm font-medium text-gray-800">
                    {(product.brands as any).name}
                  </span>
                </div>
              )}

              {product.product_categories && (
                <div className="mb-4">
                  <span className="text-sm text-gray-500">Category: </span>
                  <Link 
                    href={`/products?category=${(product.product_categories as any).slug}`}
                    className="text-sm font-medium text-emerald-600 hover:underline"
                  >
                    {(product.product_categories as any).name}
                  </Link>
                </div>
              )}

              {product.frame_materials && (
                <div className="mb-4">
                  <span className="text-sm text-gray-500">Material: </span>
                  <span className="text-sm font-medium text-gray-800">
                    {(product.frame_materials as any).name}
                  </span>
                </div>
              )}

              {product.frame_shapes && (
                <div className="mb-4">
                  <span className="text-sm text-gray-500">Shape: </span>
                  <span className="text-sm font-medium text-gray-800">
                    {(product.frame_shapes as any).name}
                  </span>
                </div>
              )}

              {product.description && (
                <div className="mt-6 pt-6 border-t border-gray-200">
                  <h3 className="text-sm font-medium text-gray-800 mb-2">Description</h3>
                  <p className="text-sm text-gray-600 whitespace-pre-wrap">{product.description}</p>
                </div>
              )}

              {/* Contact Button */}
              <div className="mt-6 pt-6 border-t border-gray-200">
                <Link
                  href="/contact"
                  className="block w-full text-center bg-emerald-500 text-white py-3 rounded-lg font-medium hover:bg-emerald-600 transition"
                >
                  Contact for Price
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Lightbox */}
      {lightboxOpen && product.product_images.length > 0 && (
        <div 
          className="fixed inset-0 z-50 bg-black/90 flex items-center justify-center"
          onClick={closeLightbox}
        >
          {/* Close Button */}
          <button
            onClick={closeLightbox}
            className="absolute top-4 right-4 text-white hover:text-gray-300 transition z-10"
          >
            <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>

          {/* Navigation Arrows */}
          {product.product_images.length > 1 && (
            <>
              <button
                onClick={(e) => { e.stopPropagation(); prevImage(); }}
                className="absolute left-4 text-white hover:text-gray-300 transition z-10"
              >
                <svg className="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
              </button>
              <button
                onClick={(e) => { e.stopPropagation(); nextImage(); }}
                className="absolute right-4 text-white hover:text-gray-300 transition z-10"
              >
                <svg className="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                </svg>
              </button>
            </>
          )}

          {/* Image */}
          <div 
            className="relative w-full h-full max-w-5xl max-h-[90vh] mx-4"
            onClick={(e) => e.stopPropagation()}
          >
            <Image
              src={product.product_images[lightboxIndex].image_url}
              alt={product.product_images[lightboxIndex].alt_text || product.name}
              fill
              className="object-contain"
              sizes="100vw"
            />
          </div>

          {/* Image Counter */}
          <div className="absolute bottom-4 left-1/2 -translate-x-1/2 text-white text-sm">
            {lightboxIndex + 1} / {product.product_images.length}
          </div>
        </div>
      )}

      {/* Simple Footer */}
      <footer className="bg-gray-50 border-t border-gray-200 py-6 mt-10">
        <div className="container-luxury text-center text-sm text-gray-500">
          <p>&copy; {new Date().getFullYear()} LeLuxeLoop. All rights reserved.</p>
        </div>
      </footer>
    </main>
  );
}
