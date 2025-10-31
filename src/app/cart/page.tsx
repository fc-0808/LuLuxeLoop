'use client';

import Link from 'next/link';
import Image from 'next/image';
import { useCart } from '@/lib/store';

export default function CartPage() {
  const { items, removeItem, updateQuantity, getTotalPrice, clearCart } = useCart();

  if (items.length === 0) {
    return (
      <main className="min-h-screen bg-white">
        <div className="container-luxury py-12 sm:py-20 text-center">
          <h1 className="font-elegant text-2xl sm:text-3xl md:text-4xl mb-3 sm:mb-4 text-luxury-800">
            Your Cart is Empty
          </h1>
          <p className="text-sm sm:text-base text-gray-600 mb-6 sm:mb-8">
            Discover our collection of luxury products
          </p>
          <Link href="/products" className="btn btn-primary">
            Continue Shopping
          </Link>
        </div>
      </main>
    );
  }

  const total = getTotalPrice();
  const shipping = total > 1000 ? 0 : 50;
  const tax = (total + shipping) * 0.1;
  const grandTotal = total + shipping + tax;

  return (
    <main className="min-h-screen bg-white">
      <div className="container-luxury py-6 sm:py-12">
        <h1 className="font-elegant text-2xl sm:text-3xl md:text-4xl mb-6 sm:mb-12 text-luxury-800">
          Shopping Cart
        </h1>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 md:gap-8 lg:gap-12">
          {/* Cart Items */}
          <div className="md:col-span-2">
            <div className="space-y-4 sm:space-y-6">
              {items.map((item) => (
                <div key={item.id} className="flex flex-col sm:flex-row gap-4 sm:gap-6 pb-4 sm:pb-6 border-b border-gray-200">
                  <div className="relative w-full sm:w-32 h-40 sm:h-32 flex-shrink-0">
                    <Image
                      src={item.product?.images?.[0] || 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=150&h=150&fit=crop'}
                      alt={item.product?.name || 'Product'}
                      fill
                      className="object-cover rounded"
                    />
                  </div>

                  <div className="flex-1 flex flex-col justify-between">
                    <div>
                      <Link href={`/products/${item.product_id}`}>
                        <h3 className="font-elegant text-lg sm:text-xl text-luxury-800 hover:text-gold-600 transition mb-1 sm:mb-2">
                          {item.product?.name || 'Product'}
                        </h3>
                      </Link>
                      <p className="text-gray-600 text-xs sm:text-sm mb-3 sm:mb-4">
                        SKU: {item.product?.sku || 'N/A'}
                      </p>
                    </div>

                    <div className="flex flex-col sm:flex-row sm:items-center gap-3 sm:gap-4">
                      <div className="flex items-center border border-gray-300 rounded w-fit">
                        <button
                          onClick={() => updateQuantity(item.product_id, item.quantity - 1)}
                          className="px-2.5 sm:px-3 py-1.5 sm:py-2 hover:bg-gray-100 text-sm"
                        >
                          −
                        </button>
                        <span className="px-3 sm:px-4 py-1.5 sm:py-2 text-sm sm:text-base">{item.quantity}</span>
                        <button
                          onClick={() => updateQuantity(item.product_id, item.quantity + 1)}
                          className="px-2.5 sm:px-3 py-1.5 sm:py-2 hover:bg-gray-100 text-sm"
                        >
                          +
                        </button>
                      </div>
                      <span className="font-bold text-base sm:text-lg text-luxury-800">
                        ${((item.product?.price || 0) * item.quantity).toFixed(2)}
                      </span>
                      <button
                        onClick={() => removeItem(item.product_id)}
                        className="text-red-600 hover:text-red-800 text-xs sm:text-sm transition mt-2 sm:mt-0 sm:ml-auto text-left sm:text-right"
                      >
                        Remove
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>

            <button
              onClick={clearCart}
              className="mt-6 sm:mt-8 text-red-600 hover:text-red-800 transition text-sm sm:text-base"
            >
              Clear Cart
            </button>
          </div>

          {/* Order Summary - Sticky on Desktop */}
          <div className="md:col-span-1">
            <div className="bg-gray-50 rounded-lg p-4 sm:p-6 md:p-8 sticky top-24 md:top-28">
              <h2 className="font-elegant text-xl sm:text-2xl mb-4 sm:mb-6 text-luxury-800">
                Order Summary
              </h2>

              <div className="space-y-3 sm:space-y-4 mb-4 sm:mb-6">
                <div className="flex justify-between text-xs sm:text-sm text-gray-600">
                  <span>Subtotal:</span>
                  <span>${total.toFixed(2)}</span>
                </div>
                <div className="flex justify-between text-xs sm:text-sm text-gray-600">
                  <span>Shipping:</span>
                  <span>
                    {shipping === 0 ? (
                      <span className="text-green-600">Free</span>
                    ) : (
                      `$${shipping.toFixed(2)}`
                    )}
                  </span>
                </div>
                <div className="flex justify-between text-xs sm:text-sm text-gray-600">
                  <span>Tax (10%):</span>
                  <span>${tax.toFixed(2)}</span>
                </div>
              </div>

              <div className="border-t-2 border-gray-300 pt-3 sm:pt-4 mb-4 sm:mb-6">
                <div className="flex justify-between items-center">
                  <span className="font-elegant text-base sm:text-lg text-luxury-800">
                    Total:
                  </span>
                  <span className="font-bold text-xl sm:text-2xl text-luxury-800">
                    ${grandTotal.toFixed(2)}
                  </span>
                </div>
              </div>

              {total <= 1000 && (
                <div className="bg-blue-50 border border-blue-200 rounded p-3 mb-4 sm:mb-6">
                  <p className="text-xs sm:text-sm text-blue-700">
                    Free shipping on orders over $1,000
                  </p>
                </div>
              )}

              <div className="space-y-2 sm:space-y-3">
                <Link href="/checkout" className="btn btn-primary w-full mb-2 sm:mb-3 text-sm sm:text-base py-2.5 sm:py-3">
                  Proceed to Checkout
                </Link>

                <Link href="/products" className="btn btn-outline w-full text-sm sm:text-base py-2.5 sm:py-3">
                  Continue Shopping
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
