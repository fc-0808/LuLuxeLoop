import type { Metadata } from 'next';
import '@/styles/globals.css';
import { Navbar } from '@/components/Navbar';

export const metadata: Metadata = {
  title: 'leluxeloop - Premium Luxury Products',
  description: 'Discover exclusive luxury products curated for the discerning customer.',
  keywords: ['luxury', 'premium', 'shopping', 'high-end', 'exclusive'],
  openGraph: {
    type: 'website',
    url: 'https://leluxeloop.com',
    title: 'leluxeloop - Premium Luxury Products',
    description: 'Discover exclusive luxury products curated for the discerning customer.',
    images: [
      {
        url: 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=1200&h=630&fit=crop',
        width: 1200,
        height: 630,
      },
    ],
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
      </head>
      <body className="font-modern antialiased bg-white text-gray-900">
        <Navbar />
        {children}
      </body>
    </html>
  );
}
