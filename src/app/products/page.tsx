'use client';

import { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { useCart } from '@/lib/store';

interface Product {
  id: string;
  name: string;
  price: number;
  original_price?: number;
  category: string;
  image: string;
  rating: number;
  isNew: boolean;
}

const MOCK_PRODUCTS: Product[] = [
  {
    id: '1',
    name: 'Platinum Chronograph',
    price: 2500,
    original_price: 2999,
    category: 'watches',
    image: 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400&h=500&fit=crop',
    rating: 4.8,
    isNew: true,
  },
  {
    id: '2',
    name: 'Diamond Solitaire Ring',
    price: 5200,
    category: 'jewelry',
    image: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400&h=500&fit=crop',
    rating: 5,
    isNew: false,
  },
  {
    id: '3',
    name: 'Silk Evening Gown',
    price: 1800,
    original_price: 2200,
    category: 'fashion',
    image: 'https://images.unsplash.com/photo-1595777707802-241d52e6ef7e?w=400&h=500&fit=crop',
    rating: 4.6,
    isNew: true,
  },
  {
    id: '4',
    name: 'Gold Bracelet',
    price: 3200,
    category: 'jewelry',
    image: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400&h=500&fit=crop',
    rating: 4.7,
    isNew: false,
  },
  {
    id: '5',
    name: 'Luxury Watch',
    price: 4500,
    category: 'watches',
    image: 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400&h=500&fit=crop',
    rating: 4.9,
    isNew: false,
  },
  {
    id: '6',
    name: 'Designer Blazer',
    price: 1400,
    original_price: 1600,
    category: 'fashion',
    image: 'https://images.unsplash.com/photo-1591047990154-a643bb166830?w=400&h=500&fit=crop',
    rating: 4.5,
    isNew: true,
  },
  {
    id: '7',
    name: 'Pearl Necklace',
    price: 2800,
    category: 'jewelry',
    image: 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=400&h=500&fit=crop',
    rating: 4.8,
    isNew: false,
  },
  {
    id: '8',
    name: 'Cashmere Coat',
    price: 2100,
    original_price: 2500,
    category: 'fashion',
    image: 'https://images.unsplash.com/photo-1539533057440-7814a9d4aae6?w=400&h=500&fit=crop',
    rating: 4.7,
    isNew: true,
  },
];

const CATEGORIES = ['all', 'watches', 'jewelry', 'fashion'];
const SORT_OPTIONS = ['featured', 'price-low', 'price-high', 'newest', 'rating'];

export default function ProductsPage() {
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [sortBy, setSortBy] = useState('featured');
  const [priceRange, setPriceRange] = useState([0, 10000]);
  const [isFilterOpen, setIsFilterOpen] = useState(false);
  const addToCart = useCart((state) => state.addItem);

  const filteredProducts = MOCK_PRODUCTS.filter((product) => {
    const categoryMatch = selectedCategory === 'all' || product.category === selectedCategory;
    const priceMatch = product.price >= priceRange[0] && product.price <= priceRange[1];
    return categoryMatch && priceMatch;
  }).sort((a, b) => {
    switch (sortBy) {
      case 'price-low':
        return a.price - b.price;
      case 'price-high':
        return b.price - a.price;
      case 'newest':
        return a.isNew ? -1 : 1;
      case 'rating':
        return b.rating - a.rating;
      default:
        return 0;
    }
  });

  return (
    <main className="min-h-screen bg-white">
      {/* Header */}
      <header className="sticky top-14 sm:top-16 z-30 bg-white border-b border-gray-200">
        <div className="container-luxury py-4 sm:py-6">
          <h1 className="font-elegant text-2xl sm:text-3xl md:text-4xl text-luxury-800 mb-1 sm:mb-2">
            Our Collection
          </h1>
          <p className="text-sm sm:text-base text-gray-600">
            {filteredProducts.length} premium products
          </p>
        </div>
      </header>

      <div className="container-luxury py-6 sm:py-12">
        {/* Mobile Filter Toggle */}
        <div className="flex md:hidden gap-3 mb-6">
          <button
            onClick={() => setIsFilterOpen(!isFilterOpen)}
            className="flex-1 px-4 py-2.5 bg-luxury-800 text-white rounded-lg font-medium transition hover:bg-luxury-900 flex items-center justify-center gap-2"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
            </svg>
            Filters
          </button>
          <select
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value)}
            className="flex-1 px-3 py-2.5 border border-gray-300 rounded-lg text-sm"
          >
            {SORT_OPTIONS.map((option) => (
              <option key={option} value={option}>
                {option.replace('-', ' ').toUpperCase()}
              </option>
            ))}
          </select>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 md:gap-8 lg:gap-12">
          {/* Sidebar Filters - Mobile Collapsible */}
          <aside className={`md:col-span-1 ${isFilterOpen ? 'block' : 'hidden'} md:block`}>
            <div className="sticky top-32 md:top-36 space-y-6 sm:space-y-8 bg-white md:bg-transparent p-4 md:p-0 rounded-lg md:rounded-none">
              {/* Close Button Mobile */}
              <button
                onClick={() => setIsFilterOpen(false)}
                className="md:hidden w-full text-center text-gray-600 hover:text-gray-900 mb-4"
              >
                ✕ Close
              </button>

              {/* Categories */}
              <div>
                <h3 className="font-elegant text-base sm:text-lg md:text-lg mb-3 sm:mb-4 text-luxury-800">
                  Categories
                </h3>
                <div className="space-y-2">
                  {CATEGORIES.map((cat) => (
                    <button
                      key={cat}
                      onClick={() => {
                        setSelectedCategory(cat);
                        setIsFilterOpen(false);
                      }}
                      className={`block w-full text-left px-3 sm:px-4 py-2 rounded transition text-sm sm:text-base ${
                        selectedCategory === cat
                          ? 'bg-luxury-800 text-white'
                          : 'text-gray-700 hover:bg-gray-100'
                      }`}
                    >
                      {cat.charAt(0).toUpperCase() + cat.slice(1)}
                    </button>
                  ))}
                </div>
              </div>

              {/* Price Range */}
              <div>
                <h3 className="font-elegant text-base sm:text-lg md:text-lg mb-3 sm:mb-4 text-luxury-800">
                  Price Range
                </h3>
                <div className="space-y-3 sm:space-y-4">
                  <div>
                    <label className="text-xs sm:text-sm text-gray-600">Min: ${priceRange[0]}</label>
                    <input
                      type="range"
                      min="0"
                      max="10000"
                      value={priceRange[0]}
                      onChange={(e) => setPriceRange([Number(e.target.value), priceRange[1]])}
                      className="w-full"
                    />
                  </div>
                  <div>
                    <label className="text-xs sm:text-sm text-gray-600">Max: ${priceRange[1]}</label>
                    <input
                      type="range"
                      min="0"
                      max="10000"
                      value={priceRange[1]}
                      onChange={(e) => setPriceRange([priceRange[0], Number(e.target.value)])}
                      className="w-full"
                    />
                  </div>
                </div>
              </div>

              {/* Sort - Desktop Only */}
              <div className="hidden md:block">
                <h3 className="font-elegant text-base sm:text-lg md:text-lg mb-3 sm:mb-4 text-luxury-800">
                  Sort By
                </h3>
                <select
                  value={sortBy}
                  onChange={(e) => setSortBy(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded text-sm"
                >
                  {SORT_OPTIONS.map((option) => (
                    <option key={option} value={option}>
                      {option.replace('-', ' ').toUpperCase()}
                    </option>
                  ))}
                </select>
              </div>
            </div>
          </aside>

          {/* Products Grid */}
          <div className="md:col-span-3">
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-mobile">
              {filteredProducts.map((product) => (
                <div key={product.id} className="product-card">
                  <div className="product-image-container relative">
                    <Image
                      src={product.image}
                      alt={product.name}
                      fill
                      className="product-image"
                    />
                    {product.isNew && (
                      <div className="absolute top-4 right-4">
                        <span className="badge badge-new">New</span>
                      </div>
                    )}
                    {product.original_price && (
                      <div className="absolute top-4 left-4">
                        <span className="badge badge-sale">Sale</span>
                      </div>
                    )}
                  </div>
                  <div className="p-3 sm:p-4">
                    <Link href={`/products/${product.id}`}>
                      <h3 className="font-elegant text-base sm:text-lg mb-2 text-luxury-800 hover:text-gold-600 transition">
                        {product.name}
                      </h3>
                    </Link>
                    <div className="flex items-center gap-1 mb-3 text-yellow-500">
                      <span>★</span>
                      <span className="text-xs sm:text-sm text-gray-600">{product.rating}</span>
                    </div>
                    <div className="flex items-center gap-2 mb-3 sm:mb-4">
                      <span className="font-bold text-base sm:text-lg text-luxury-800">
                        ${product.price.toFixed(2)}
                      </span>
                      {product.original_price && (
                        <span className="text-xs sm:text-sm text-gray-400 line-through">
                          ${product.original_price.toFixed(2)}
                        </span>
                      )}
                    </div>
                    <button
                      onClick={() => {
                        addToCart(product as any, 1);
                        alert('Added to cart!');
                      }}
                      className="btn btn-primary w-full py-2 sm:py-3 text-xs sm:text-sm"
                    >
                      Add to Cart
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
