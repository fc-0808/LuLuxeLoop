'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { createClient } from '@/lib/supabase/client';

interface ProductImage {
  id: string;
  image_url: string;
  is_primary: boolean;
  display_order: number;
}

interface Product {
  id: string;
  name: string;
  sku: string;
  base_price: number;
  status: string;
  category_id: string;
  brand_id: string;
  product_images: ProductImage[];
  brands?: { name: string; slug: string };
  product_categories?: { name: string; slug: string };
}

interface Category {
  id: string;
  name: string;
  slug: string;
  products: Product[];
}

export default function Home() {
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    fetchProducts();
  }, []);

  async function fetchProducts() {
    const supabase = createClient();
    if (!supabase) {
      setLoading(false);
      return;
    }

    try {
      // Fetch categories
      const { data: categoriesData } = await supabase
        .from('product_categories')
        .select('id, name, slug')
        .eq('is_active', true)
        .order('display_order');

      // Fetch products with images
      const { data: productsData } = await supabase
        .from('products')
        .select(`
          id, name, sku, base_price, status, category_id, brand_id,
          product_images (id, image_url, is_primary, display_order),
          brands (name, slug),
          product_categories (name, slug)
        `)
        .eq('status', 'active')
        .order('created_at', { ascending: false });

      if (categoriesData && productsData) {
        const categoriesWithProducts = categoriesData.map((cat: { id: string; name: string; slug: string }) => ({
          ...cat,
          products: productsData.filter((p: any) => p.category_id === cat.id) as Product[]
        })).filter((cat: Category) => cat.products.length > 0);

        setCategories(categoriesWithProducts);
      }
    } catch (error) {
      console.error('Error fetching products:', error);
    } finally {
      setLoading(false);
    }
  }

  const getPrimaryImage = (images: ProductImage[]) => {
    if (!images || images.length === 0) return null;
    const primary = images.find(img => img.is_primary);
    return primary || images[0];
  };

  const getThumbnails = (images: ProductImage[]) => {
    if (!images || images.length <= 1) return [];
    return images.slice(0, 4);
  };

  const filteredCategories = categories.map(cat => ({
    ...cat,
    products: cat.products.filter(p => 
      searchQuery === '' || 
      p.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      p.sku.toLowerCase().includes(searchQuery.toLowerCase())
    )
  })).filter(cat => cat.products.length > 0);

  return (
    <main className="min-h-screen bg-white">
      {/* Search Bar */}
      <div className="sticky top-14 sm:top-16 z-30 bg-white border-b border-gray-200 py-3">
        <div className="container-luxury">
          <div className="flex items-center justify-between gap-4">
            <div className="flex-1 max-w-md ml-auto">
              <div className="relative">
                <input
                  type="text"
                  placeholder="Search for albums/pictures"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  className="w-full pl-4 pr-20 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:border-emerald-500"
                />
                <button className="absolute right-0 top-0 h-full px-4 bg-emerald-500 text-white rounded-r-md hover:bg-emerald-600 transition text-sm font-medium">
                  Search
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Products Content */}
      <div className="container-luxury py-6">
        {loading ? (
          <div className="flex items-center justify-center py-20">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-emerald-500"></div>
          </div>
        ) : filteredCategories.length === 0 ? (
          <div className="text-center py-20">
            <p className="text-gray-500 text-lg">No products found</p>
            <p className="text-gray-400 text-sm mt-2">Add products from the admin panel</p>
          </div>
        ) : (
          filteredCategories.map((category) => (
            <section key={category.id} className="mb-10">
              {/* Category Header */}
              <div className="flex items-center gap-2 mb-4 pb-2 border-b border-gray-200">
                <div className="w-1 h-5 bg-emerald-500 rounded"></div>
                <h2 className="text-lg font-medium text-gray-800">{category.name}</h2>
                <span className="text-sm text-gray-400">({category.products.length})</span>
              </div>

              {/* Products Grid - Dense Layout */}
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8 gap-3">
                {category.products.map((product) => {
                  const primaryImage = getPrimaryImage(product.product_images);
                  const thumbnails = getThumbnails(product.product_images);
                  const imageCount = product.product_images?.length || 0;

                  return (
                    <Link
                      key={product.id}
                      href={`/products/${product.id}`}
                      className="group block"
                    >
                      <div className="bg-white border border-gray-200 rounded overflow-hidden hover:shadow-md transition-shadow">
                        {/* Main Image */}
                        <div className="relative aspect-square bg-gray-100">
                          {primaryImage ? (
                            <Image
                              src={primaryImage.image_url}
                              alt={product.name}
                              fill
                              className="object-cover group-hover:scale-105 transition-transform duration-300"
                              sizes="(max-width: 640px) 50vw, (max-width: 768px) 33vw, (max-width: 1024px) 25vw, 12.5vw"
                            />
                          ) : (
                            <div className="w-full h-full flex items-center justify-center text-gray-400">
                              <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                              </svg>
                            </div>
                          )}
                          
                          {/* Image Count Badge */}
                          {imageCount > 1 && (
                            <div className="absolute bottom-1 right-1 bg-black/60 text-white text-xs px-1.5 py-0.5 rounded">
                              {imageCount}
                            </div>
                          )}
                        </div>

                        {/* Thumbnails Row */}
                        {thumbnails.length > 1 && (
                          <div className="flex gap-0.5 p-1 bg-gray-50">
                            {thumbnails.map((thumb, idx) => (
                              <div key={thumb.id} className="relative w-6 h-6 flex-shrink-0">
                                <Image
                                  src={thumb.image_url}
                                  alt={`${product.name} ${idx + 1}`}
                                  fill
                                  className="object-cover rounded-sm"
                                  sizes="24px"
                                />
                              </div>
                            ))}
                            {imageCount > 4 && (
                              <div className="w-6 h-6 flex-shrink-0 bg-gray-200 rounded-sm flex items-center justify-center text-xs text-gray-500">
                                +{imageCount - 4}
                              </div>
                            )}
                          </div>
                        )}

                        {/* Product Info */}
                        <div className="p-2">
                          <p className="text-xs text-gray-600 truncate" title={product.name}>
                            {product.sku}
                          </p>
                        </div>
                      </div>
                    </Link>
                  );
                })}

                {/* More Items Link */}
                {category.products.length >= 8 && (
                  <Link
                    href={`/products?category=${category.slug}`}
                    className="flex items-center justify-center bg-gray-50 border border-gray-200 rounded aspect-square hover:bg-gray-100 transition"
                  >
                    <div className="text-center">
                      <p className="text-sm text-gray-600">More</p>
                      <p className="text-xs text-emerald-600">{category.products.length} items</p>
                    </div>
                  </Link>
                )}
              </div>
            </section>
          ))
        )}
      </div>

      {/* Simple Footer */}
      <footer className="bg-gray-50 border-t border-gray-200 py-6 mt-10">
        <div className="container-luxury text-center text-sm text-gray-500">
          <p>&copy; {new Date().getFullYear()} LeLuxeLoop. All rights reserved.</p>
        </div>
      </footer>
    </main>
  );
}
