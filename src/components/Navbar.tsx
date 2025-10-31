'use client';

import Link from 'next/link';
import { useState } from 'react';
import { useAuth } from '@/hooks/useAuth';

export function Navbar() {
  const { user, isLoading, signOut } = useAuth();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isAccountMenuOpen, setIsAccountMenuOpen] = useState(false);

  const handleSignOut = async () => {
    setIsMenuOpen(false);
    setIsAccountMenuOpen(false);
    await signOut();
  };

  return (
    <nav className="sticky top-0 z-50 bg-white shadow-elegant">
      <div className="container-luxury">
        <div className="flex justify-between items-center h-14 sm:h-16">
          {/* Logo */}
          <Link href="/" className="font-elegant text-xl sm:text-2xl font-bold text-luxury-800 flex-shrink-0">
            LeLuxeLoop
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex gap-6 lg:gap-8 items-center">
            <Link href="/products" className="text-sm lg:text-base text-gray-700 hover:text-luxury-800 transition">
              Products
            </Link>
            <Link href="/collections" className="text-sm lg:text-base text-gray-700 hover:text-luxury-800 transition">
              Collections
            </Link>
            <Link href="/about" className="text-sm lg:text-base text-gray-700 hover:text-luxury-800 transition">
              About
            </Link>
            <Link href="/contact" className="text-sm lg:text-base text-gray-700 hover:text-luxury-800 transition">
              Contact
            </Link>
          </div>

          {/* Right Section */}
          <div className="flex items-center gap-2 sm:gap-4">
            {/* Cart - Always Visible */}
            <Link href="/cart" className="text-gray-700 hover:text-luxury-800 transition flex items-center gap-1 text-sm sm:text-base">
              <span>🛍️</span>
              <span className="hidden sm:inline">Cart</span>
            </Link>

            {/* Auth Section */}
            {isLoading ? (
              <div className="w-8 h-8 bg-gray-200 rounded-full animate-pulse" />
            ) : user ? (
              <div className="relative">
                <button
                  onClick={() => setIsAccountMenuOpen(!isAccountMenuOpen)}
                  className="flex items-center gap-1 sm:gap-2 text-gray-700 hover:text-luxury-800 transition px-2 py-1 rounded hover:bg-gray-50"
                >
                  <span>👤</span>
                  <span className="hidden sm:inline text-sm">Account</span>
                </button>

                {/* Account Dropdown Menu */}
                {isAccountMenuOpen && (
                  <div className="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-luxury py-2 z-50 text-sm">
                    <Link
                      href="/dashboard"
                      className="block px-4 py-2.5 text-gray-700 hover:bg-luxury-50 transition"
                      onClick={() => setIsAccountMenuOpen(false)}
                    >
                      Dashboard
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
                  <button className="hidden xs:inline px-3 sm:px-4 py-1.5 sm:py-2 text-gray-700 hover:text-luxury-800 font-medium transition text-sm sm:text-base">
                    Sign In
                  </button>
                </Link>
                <Link href="/signup">
                  <button className="btn btn-primary px-3 sm:px-4 py-1.5 sm:py-2 text-xs sm:text-sm">
                    Sign Up
                  </button>
                </Link>
              </div>
            )}

            {/* Mobile Menu Button */}
            <button
              onClick={() => setIsMenuOpen(!isMenuOpen)}
              className="md:hidden flex items-center justify-center w-10 h-10 rounded hover:bg-gray-100 transition"
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
          <div className="md:hidden border-t border-gray-200 bg-white">
            <div className="flex flex-col py-2">
              <Link
                href="/products"
                className="px-4 py-2.5 text-gray-700 hover:bg-luxury-50 transition text-sm"
                onClick={() => setIsMenuOpen(false)}
              >
                Products
              </Link>
              <Link
                href="/collections"
                className="px-4 py-2.5 text-gray-700 hover:bg-luxury-50 transition text-sm"
                onClick={() => setIsMenuOpen(false)}
              >
                Collections
              </Link>
              <Link
                href="/about"
                className="px-4 py-2.5 text-gray-700 hover:bg-luxury-50 transition text-sm"
                onClick={() => setIsMenuOpen(false)}
              >
                About
              </Link>
              <Link
                href="/contact"
                className="px-4 py-2.5 text-gray-700 hover:bg-luxury-50 transition text-sm"
                onClick={() => setIsMenuOpen(false)}
              >
                Contact
              </Link>
            </div>
          </div>
        )}
      </div>
    </nav>
  );
}
