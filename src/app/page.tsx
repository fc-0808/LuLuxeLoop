'use client';

import Link from 'next/link';
import { BentoGrid } from '@/components/BentoGrid';

export default function Home() {
  return (
    <main>
      {/* Hero Section - Mobile First */}
      <section className="relative w-full min-h-screen sm:h-screen overflow-hidden bg-gradient-to-r from-luxury-900 to-luxury-700 flex items-center justify-center">
        <div className="absolute inset-0 z-0">
          <img
            src="https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1920&h=1080&fit=crop&q=80"
            alt="Luxury Designer Brands"
            className="absolute inset-0 w-full h-full object-cover opacity-30"
            loading="eager"
          />
        </div>
        
        <div className="container-luxury relative z-10 text-center text-white py-12 sm:py-0">
          <h1 className="font-elegant mb-4 sm:mb-6 font-bold">
            Luxury Redefined
          </h1>
          <p className="text-base sm:text-lg md:text-xl lg:text-2xl mb-6 sm:mb-8 text-gray-100 max-w-2xl mx-auto px-4 sm:px-0">
            Discover an exquisite collection of premium products curated for the discerning taste.
          </p>
          <div className="flex flex-col sm:flex-row gap-3 sm:gap-4 justify-center flex-wrap px-4 sm:px-0">
            <Link href="/products" className="btn btn-secondary">
              Explore Collection
            </Link>
            <Link href="/new-arrivals" className="btn btn-outline text-white border-white hover:bg-white/10">
              New Arrivals
            </Link>
          </div>
        </div>
      </section>

      {/* Categories Section - Bento Grid */}
      <BentoGrid />

      {/* Featured Products - Mobile First */}
      <section className="py-mobile bg-gray-50">
        <div className="container-luxury">
          <h2 className="font-elegant text-center mb-8 sm:mb-12 md:mb-16 text-luxury-800">
            Featured Selections
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-mobile">
            <div className="product-card">
              <div className="product-image-container">
                <img
                  src="https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=400&h=500&fit=crop&q=80"
                  alt="Gucci Dionysus Bag"
                  className="product-image"
                  loading="lazy"
                />
                <div className="absolute top-4 right-4">
                  <span className="badge badge-exclusive">New</span>
                </div>
              </div>
              <div className="p-3 sm:p-4">
                <h3 className="font-elegant text-base sm:text-lg mb-2 text-luxury-800">
                  Gucci Dionysus Bag
                </h3>
                <p className="text-gray-600 text-xs sm:text-sm mb-3 sm:mb-4">
                  Supreme canvas with tiger head closure.
                </p>
                <div className="flex items-center justify-between gap-2 mb-3 sm:mb-4">
                  <span className="font-bold text-base sm:text-lg text-luxury-800">
                    $2,890.00
                  </span>
                </div>
                <button className="btn btn-primary w-full py-2 sm:py-3 text-sm sm:text-base">
                  Add to Cart
                </button>
              </div>
            </div>
            <div className="product-card">
              <div className="product-image-container">
                <img
                  src="https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400&h=500&fit=crop&q=80"
                  alt="Rolex Datejust"
                  className="product-image"
                  loading="lazy"
                />
                <div className="absolute top-4 right-4">
                  <span className="badge badge-exclusive">New</span>
                </div>
              </div>
              <div className="p-3 sm:p-4">
                <h3 className="font-elegant text-base sm:text-lg mb-2 text-luxury-800">
                  Rolex Datejust 41
                </h3>
                <p className="text-gray-600 text-xs sm:text-sm mb-3 sm:mb-4">
                  Steel and yellow gold with champagne dial.
                </p>
                <div className="flex items-center justify-between gap-2 mb-3 sm:mb-4">
                  <span className="font-bold text-base sm:text-lg text-luxury-800">
                    $14,300.00
                  </span>
                </div>
                <button className="btn btn-primary w-full py-2 sm:py-3 text-sm sm:text-base">
                  Add to Cart
                </button>
              </div>
            </div>
            <div className="product-card">
              <div className="product-image-container">
                <img
                  src="https://images.unsplash.com/photo-1591561954557-26941169b49e?w=400&h=500&fit=crop&q=80"
                  alt="Dior Lady Dior Bag"
                  className="product-image"
                  loading="lazy"
                />
                <div className="absolute top-4 right-4">
                  <span className="badge badge-exclusive">New</span>
                </div>
              </div>
              <div className="p-3 sm:p-4">
                <h3 className="font-elegant text-base sm:text-lg mb-2 text-luxury-800">
                  Dior Lady Dior Bag
                </h3>
                <p className="text-gray-600 text-xs sm:text-sm mb-3 sm:mb-4">
                  Cannage lambskin with iconic charms.
                </p>
                <div className="flex items-center justify-between gap-2 mb-3 sm:mb-4">
                  <span className="font-bold text-base sm:text-lg text-luxury-800">
                    $5,200.00
                  </span>
                </div>
                <button className="btn btn-primary w-full py-2 sm:py-3 text-sm sm:text-base">
                  Add to Cart
                </button>
              </div>
            </div>
            <div className="product-card">
              <div className="product-image-container">
                <img
                  src="https://images.unsplash.com/photo-1566150905458-1bf1fc113f0d?w=400&h=500&fit=crop&q=80"
                  alt="Celine Triomphe Bag"
                  className="product-image"
                  loading="lazy"
                />
                <div className="absolute top-4 right-4">
                  <span className="badge badge-exclusive">New</span>
                </div>
              </div>
              <div className="p-3 sm:p-4">
                <h3 className="font-elegant text-base sm:text-lg mb-2 text-luxury-800">
                  Celine Triomphe Bag
                </h3>
                <p className="text-gray-600 text-xs sm:text-sm mb-3 sm:mb-4">
                  Smooth calfskin with gold hardware.
                </p>
                <div className="flex items-center justify-between gap-2 mb-3 sm:mb-4">
                  <span className="font-bold text-base sm:text-lg text-luxury-800">
                    $3,450.00
                  </span>
                </div>
                <button className="btn btn-primary w-full py-2 sm:py-3 text-sm sm:text-base">
                  Add to Cart
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Newsletter Section - Mobile First */}
      <section className="py-8 sm:py-12 md:py-16 lg:py-20 gradient-luxury">
        <div className="container-luxury">
          <div className="max-w-2xl mx-auto text-center text-white px-4 sm:px-0">
            <h2 className="font-elegant mb-3 sm:mb-4">
              Exclusive Offers
            </h2>
            <p className="text-sm sm:text-base md:text-lg mb-6 sm:mb-8 text-gray-100">
              Subscribe to our newsletter for early access to new collections and exclusive member discounts.
            </p>
            <form className="flex flex-col sm:flex-row gap-3 sm:gap-4">
              <input
                type="email"
                placeholder="Enter your email"
                className="flex-1 px-4 py-2.5 sm:py-3 rounded-lg text-gray-900 focus:outline-none focus:ring-2 focus:ring-gold-500 text-sm sm:text-base"
                required
              />
              <button type="submit" className="btn btn-secondary whitespace-nowrap text-sm sm:text-base">
                Subscribe
              </button>
            </form>
          </div>
        </div>
      </section>

      {/* Footer - Mobile First */}
      <footer className="bg-luxury-900 text-white">
        <div className="container-luxury py-8 sm:py-12 md:py-16">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 sm:gap-8 mb-6 sm:mb-8">
            <div>
              <h4 className="font-elegant text-lg sm:text-xl mb-3 sm:mb-4">LeLuxeLoop</h4>
              <p className="text-sm sm:text-base text-gray-400">
                Premium luxury products for the discerning customer.
              </p>
            </div>
            <div>
              <h5 className="font-semibold mb-3 sm:mb-4 text-base">Shop</h5>
              <ul className="space-y-2 text-sm sm:text-base text-gray-400">
                <li><Link href="/products" className="hover:text-gold-500 transition">Products</Link></li>
                <li><Link href="/collections" className="hover:text-gold-500 transition">Collections</Link></li>
                <li><Link href="/new-arrivals" className="hover:text-gold-500 transition">New Arrivals</Link></li>
              </ul>
            </div>
            <div>
              <h5 className="font-semibold mb-3 sm:mb-4 text-base">Support</h5>
              <ul className="space-y-2 text-sm sm:text-base text-gray-400">
                <li><Link href="/contact" className="hover:text-gold-500 transition">Contact Us</Link></li>
                <li><Link href="/shipping" className="hover:text-gold-500 transition">Shipping Info</Link></li>
                <li><Link href="/returns" className="hover:text-gold-500 transition">Returns</Link></li>
              </ul>
            </div>
            <div>
              <h5 className="font-semibold mb-3 sm:mb-4 text-base">Legal</h5>
              <ul className="space-y-2 text-sm sm:text-base text-gray-400">
                <li><Link href="/privacy" className="hover:text-gold-500 transition">Privacy Policy</Link></li>
                <li><Link href="/terms" className="hover:text-gold-500 transition">Terms & Conditions</Link></li>
              </ul>
            </div>
          </div>
          <div className="border-t border-gray-700 pt-6 sm:pt-8 text-center text-xs sm:text-sm text-gray-400">
            <p>&copy; 2024 LeLuxeLoop. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </main>
  );
}
