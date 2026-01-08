import type { Metadata } from 'next';
import '@/styles/globals.css';
import { Navbar } from '@/components/Navbar';

export const metadata: Metadata = {
  title: 'LeLuxeLoop - Premium Product Gallery',
  description: 'Browse our exclusive collection of premium products. High-quality images and detailed product information.',
  keywords: ['luxury', 'premium', 'gallery', 'products', 'collection'],
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
