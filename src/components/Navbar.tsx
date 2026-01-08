'use client';

import Link from 'next/link';
import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { createClient } from '@/lib/supabase/client';

interface Category {
  id: string;
  name: string;
  slug: string;
}

export function Navbar() {
  const { user, isLoading, signOut } = useAuth();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isAccountMenuOpen, setIsAccountMenuOpen] = useState(false);
  const [isCategoriesOpen, setIsCategoriesOpen] = useState(false);
  const [categories, setCategories] = useState<Category[]>([]);

  useEffect(() => {
    fetchCategories();
  }, []);

  async function fetchCategories() {
    const supabase = createClient();
    if (!supabase) return;

    const { data } = await supabase
      .from('product_categories')
      .select('id, name, slug')
      .eq('is_active', true)
      .order('display_order');

    if (data) setCategories(data);
  }

  const handleSignOut = async () => {
    setIsMenuOpen(false);
    setIsAccountMenuOpen(false);
    await signOut();
  };

  return (
    <nav className="sticky top-0 z-50 bg-emerald-500 text-white">
      <div className="container-luxury">
        <div className="flex justify-between items-center h-14 sm:h-16">
          {/* Logo */}
          <Link href="/" className="text-xl sm:text-2xl font-bold flex-shrink-0">
            LeLuxeLoop
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex gap-1 items-center">
            <Link 
              href="/" 
              className="px-4 py-2 text-sm font-medium hover:bg-emerald-600 rounded transition"
            >
              Home
            </Link>
            <Link 
              href="/products" 
              className="px-4 py-2 text-sm font-medium hover:bg-emerald-600 rounded transition"
            >
              Album
            </Link>
            <Link 
              href="/contact" 
              className="px-4 py-2 text-sm font-medium hover:bg-emerald-600 rounded transition"
            >
              Contact
            </Link>
            
            {/* Categories Dropdown */}
            <div className="relative">
              <button
                onClick={() => setIsCategoriesOpen(!isCategoriesOpen)}
                onBlur={() => setTimeout(() => setIsCategoriesOpen(false), 150)}
                className="px-4 py-2 text-sm font-medium hover:bg-emerald-600 rounded transition flex items-center gap-1"
              >
                All Categories
                <svg className={`w-4 h-4 transition-transform ${isCategoriesOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              
              {isCategoriesOpen && (
                <div className="absolute top-full left-0 mt-1 w-48 bg-white rounded-lg shadow-lg py-2 z-50">
                  {categories.map((cat) => (
                    <Link
                      key={cat.id}
                      href={`/products?category=${cat.slug}`}
                      className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 transition"
                      onClick={() => setIsCategoriesOpen(false)}
                    >
                      {cat.name}
                    </Link>
                  ))}
                  {categories.length === 0 && (
                    <p className="px-4 py-2 text-sm text-gray-400">No categories</p>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* Right Section */}
          <div className="flex items-center gap-2 sm:gap-3">
            {/* Auth Section */}
            {isLoading ? (
              <div className="w-8 h-8 bg-emerald-400 rounded-full animate-pulse" />
            ) : user ? (
              <div className="relative">
                <button
                  onClick={() => setIsAccountMenuOpen(!isAccountMenuOpen)}
                  className="flex items-center gap-1 sm:gap-2 hover:bg-emerald-600 px-3 py-1.5 rounded transition"
                >
                  <span>👤</span>
                  <span className="hidden sm:inline text-sm">Account</span>
                </button>

                {isAccountMenuOpen && (
                  <div className="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg py-2 z-50 text-sm">
                    <Link
                      href="/dashboard"
                      className="block px-4 py-2.5 text-gray-700 hover:bg-gray-100 transition"
                      onClick={() => setIsAccountMenuOpen(false)}
                    >
                      Dashboard
                    </Link>
                    <Link
                      href="/admin"
                      className="block px-4 py-2.5 text-gray-700 hover:bg-gray-100 transition"
                      onClick={() => setIsAccountMenuOpen(false)}
                    >
                      Admin Panel
                    </Link>
                    <div className="border-t border-gray-200 my-2"></div>
                    <button
                      onClick={handleSignOut}
                      className="w-full text-left px-4 py-2.5 text-gray-700 hover:bg-red-50 hover:text-red-700 transition"
                    >
                      Sign Out
                    </button>
                  </div>
                )}
              </div>
            ) : (
              <div className="flex gap-1 sm:gap-2">
                <Link href="/login">
                  <button className="px-3 py-1.5 text-sm font-medium hover:bg-emerald-600 rounded transition">
                    Login
                  </button>
                </Link>
                <Link href="/signup">
                  <button className="px-3 py-1.5 text-sm font-medium bg-white text-emerald-600 rounded hover:bg-gray-100 transition">
                    Register
                  </button>
                </Link>
              </div>
            )}

            {/* Mobile Menu Button */}
            <button
              onClick={() => setIsMenuOpen(!isMenuOpen)}
              className="md:hidden flex items-center justify-center w-10 h-10 rounded hover:bg-emerald-600 transition"
              aria-label="Toggle menu"
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                {isMenuOpen ? (
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                ) : (
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                )}
              </svg>
            </button>
          </div>
        </div>

        {/* Mobile Navigation Menu */}
        {isMenuOpen && (
          <div className="md:hidden border-t border-emerald-400 bg-emerald-500">
            <div className="flex flex-col py-2">
              <Link
                href="/"
                className="px-4 py-2.5 hover:bg-emerald-600 transition text-sm"
                onClick={() => setIsMenuOpen(false)}
              >
                Home
              </Link>
              <Link
                href="/products"
                className="px-4 py-2.5 hover:bg-emerald-600 transition text-sm"
                onClick={() => setIsMenuOpen(false)}
              >
                Album
              </Link>
              <Link
                href="/contact"
                className="px-4 py-2.5 hover:bg-emerald-600 transition text-sm"
                onClick={() => setIsMenuOpen(false)}
              >
                Contact
              </Link>
              
              {/* Mobile Categories */}
              <div className="border-t border-emerald-400 mt-2 pt-2">
                <p className="px-4 py-2 text-xs text-emerald-200 uppercase tracking-wide">Categories</p>
                {categories.map((cat) => (
                  <Link
                    key={cat.id}
                    href={`/products?category=${cat.slug}`}
                    className="px-6 py-2 hover:bg-emerald-600 transition text-sm block"
                    onClick={() => setIsMenuOpen(false)}
                  >
                    {cat.name}
                  </Link>
                ))}
              </div>
            </div>
          </div>
        )}
      </div>
    </nav>
  );
}
