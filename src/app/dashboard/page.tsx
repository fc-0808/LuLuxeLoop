'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { useAuth } from '@/hooks/useAuth';

export default function DashboardPage() {
  const { user, isLoading, signOut } = useAuth();
  const router = useRouter();

  // Redirect to login if not authenticated
  useEffect(() => {
    if (!isLoading && !user) {
      router.push('/login');
    }
  }, [user, isLoading, router]);

  if (isLoading) {
    return (
      <main className="min-h-screen bg-gradient-to-br from-luxury-50 to-luxury-100">
        <div className="flex items-center justify-center h-screen">
          <div className="text-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-luxury-600 mx-auto mb-4"></div>
            <p className="text-gray-600">Loading...</p>
          </div>
        </div>
      </main>
    );
  }

  if (!user) {
    return null;
  }

  const handleSignOut = async () => {
    await signOut();
    router.push('/');
  };

  return (
    <main className="min-h-screen bg-gradient-to-br from-luxury-50 to-luxury-100 py-12 px-4">
      <div className="max-w-4xl mx-auto">
        {/* Navigation */}
        <div className="mb-8 flex items-center justify-between">
          <Link href="/" className="text-luxury-600 hover:text-luxury-800 font-medium">
            ← Back to Home
          </Link>
          <button
            onClick={handleSignOut}
            className="btn btn-secondary"
          >
            Sign Out
          </button>
        </div>

        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="font-elegant text-4xl font-bold text-luxury-800 mb-2">
            Welcome back!
          </h1>
          <p className="text-gray-600">Manage your account and orders</p>
        </div>

        {/* Profile Card */}
        <div className="bg-white rounded-lg shadow-elegant p-8 mb-8">
          <div className="border-b border-gray-200 pb-6 mb-6">
            <h2 className="text-2xl font-bold text-luxury-800 mb-4">Account Details</h2>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Email Address
                </label>
                <p className="text-lg text-gray-900">{user.email}</p>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Account Created
                </label>
                <p className="text-lg text-gray-900">
                  {new Date(user.created_at).toLocaleDateString('en-US', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric',
                  })}
                </p>
              </div>
              {user.user_metadata?.full_name && (
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Full Name
                  </label>
                  <p className="text-lg text-gray-900">{user.user_metadata.full_name}</p>
                </div>
              )}
            </div>
          </div>

          {/* Quick Links */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Link href="/cart">
              <button className="w-full px-6 py-3 border-2 border-luxury-500 text-luxury-700 rounded-lg hover:bg-luxury-50 transition font-medium">
                🛍️ View Cart
              </button>
            </Link>
            <Link href="/products">
              <button className="w-full px-6 py-3 border-2 border-luxury-500 text-luxury-700 rounded-lg hover:bg-luxury-50 transition font-medium">
                🔍 Continue Shopping
              </button>
            </Link>
          </div>
        </div>

        {/* Coming Soon Section */}
        <div className="bg-white rounded-lg shadow-elegant p-8">
          <h2 className="text-2xl font-bold text-luxury-800 mb-4">Coming Soon</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 text-gray-600">
            <div className="flex items-start space-x-3">
              <span className="text-2xl">📦</span>
              <div>
                <p className="font-medium text-gray-900">Order History</p>
                <p className="text-sm">View and track your orders</p>
              </div>
            </div>
            <div className="flex items-start space-x-3">
              <span className="text-2xl">❤️</span>
              <div>
                <p className="font-medium text-gray-900">Wishlist</p>
                <p className="text-sm">Save your favorite items</p>
              </div>
            </div>
            <div className="flex items-start space-x-3">
              <span className="text-2xl">🎁</span>
              <div>
                <p className="font-medium text-gray-900">Loyalty Rewards</p>
                <p className="text-sm">Earn points on purchases</p>
              </div>
            </div>
            <div className="flex items-start space-x-3">
              <span className="text-2xl">⚙️</span>
              <div>
                <p className="font-medium text-gray-900">Settings</p>
                <p className="text-sm">Manage your preferences</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
