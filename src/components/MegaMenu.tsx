'use client';

import Link from 'next/link';

const SmartphoneIcon = () => (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
  </svg>
);

const DiamondIcon = () => (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M12 3L2 9l10 13 10-13-10-6z" />
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M2 9h20M7 9l5 13 5-13" />
  </svg>
);

const HandbagIcon = () => (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
  </svg>
);

const HeelIcon = () => (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 20h16M4 20l2-8h2l1 3h6l3-11h2l-4 16" />
  </svg>
);

const HomeIcon = () => (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
  </svg>
);

const ChevronDownIcon = () => (
  <svg className="w-4 h-4 ml-1 transition-transform duration-200 group-hover/trigger:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
  </svg>
);

const menuCategories = [
  {
    title: '3C & Tech',
    icon: SmartphoneIcon,
    items: [
      { name: 'Phone Cases', href: '/products?category=phone-cases' },
      { name: 'Smart Accessories', href: '/products?category=smart-accessories' },
      { name: 'Audio', href: '/products?category=audio' },
      { name: 'Cables', href: '/products?category=cables' },
    ],
  },
  {
    title: 'Fine Jewelry',
    icon: DiamondIcon,
    items: [
      { name: 'Necklaces', href: '/products?category=necklaces' },
      { name: 'Rings', href: '/products?category=rings' },
      { name: 'Earrings', href: '/products?category=earrings' },
      { name: 'Bracelets', href: '/products?category=bracelets' },
    ],
  },
  {
    title: 'Luxury Bags',
    icon: HandbagIcon,
    items: [
      { name: 'Handbags', href: '/products?category=handbags' },
      { name: 'Clutches', href: '/products?category=clutches' },
      { name: 'Wallets', href: '/products?category=wallets' },
      { name: 'Backpacks', href: '/products?category=backpacks' },
    ],
  },
  {
    title: 'Designer Shoes',
    icon: HeelIcon,
    items: [
      { name: 'Heels', href: '/products?category=heels' },
      { name: 'Sneakers', href: '/products?category=sneakers' },
      { name: 'Boots', href: '/products?category=boots' },
      { name: 'Sandals', href: '/products?category=sandals' },
    ],
  },
  {
    title: 'Home & Living',
    icon: HomeIcon,
    items: [
      { name: 'Decor', href: '/products?category=decor' },
      { name: 'Kitchen', href: '/products?category=kitchen' },
      { name: 'Bedding', href: '/products?category=bedding' },
      { name: 'Organization', href: '/products?category=organization' },
    ],
  },
];

export function MegaMenu() {
  return (
    <div className="group/trigger">
      <Link 
        href="/products" 
        className="inline-flex items-center text-sm lg:text-base text-gray-700 hover:text-luxury-800 transition py-5"
      >
        Products
        <ChevronDownIcon />
      </Link>
      
      {/* Full-width Mega Menu Dropdown Container */}
      <div className="mega-menu-container">
        <div className="mega-menu-content">
          <div className="mega-menu-inner">
            <div className="mega-menu-grid">
              {menuCategories.map((category) => (
                <div key={category.title} className="mega-menu-column">
                  <Link 
                    href={`/products?category=${category.title.toLowerCase().replace(/\s+/g, '-')}`}
                    className="mega-menu-header"
                  >
                    <category.icon />
                    <span>{category.title}</span>
                  </Link>
                  <ul className="mega-menu-items">
                    {category.items.map((item) => (
                      <li key={item.name}>
                        <Link href={item.href} className="mega-menu-link">
                          {item.name}
                        </Link>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
