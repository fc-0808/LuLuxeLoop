'use client';

import Link from 'next/link';

const categories = [
  {
    id: 'jewelry',
    label: 'Timeless Jewelry',
    image: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&h=1000&fit=crop&q=80',
    href: '/products?category=jewelry',
  },
  {
    id: 'bags',
    label: 'Signature Bags',
    image: 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=600&h=400&fit=crop&q=80',
    href: '/products?category=bags',
  },
  {
    id: 'shoes',
    label: 'Luxury Footwear',
    image: 'https://images.unsplash.com/photo-1603808033192-082d6919d3e1?w=600&h=400&fit=crop&q=80',
    href: '/products?category=shoes',
  },
  {
    id: 'tech',
    label: '3C & Tech',
    image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&h=400&fit=crop&q=80',
    href: '/products?category=tech',
  },
  {
    id: 'home',
    label: 'Home Products',
    image: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=600&h=400&fit=crop&q=80',
    href: '/products?category=home',
  },
];

export function BentoGrid() {
  return (
    <section className="py-mobile bg-white">
      <div className="container-luxury">
        <h2 className="font-elegant text-center mb-8 sm:mb-12 md:mb-16 text-luxury-800">
          Shop by Category
        </h2>
        
        <div className="bento-grid">
          {categories.map((category) => (
            <Link
              key={category.id}
              href={category.href}
              className={`bento-card bento-${category.id}`}
            >
              <div className="bento-image-wrapper">
                <img
                  src={category.image}
                  alt={category.label}
                  className="bento-image absolute inset-0 w-full h-full object-cover"
                  loading={category.id === 'jewelry' ? 'eager' : 'lazy'}
                />
                <div className="bento-overlay" />
              </div>
              <div className="bento-content">
                <h3 className="bento-title">{category.label}</h3>
                <span className="bento-cta">Shop Now</span>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
}
