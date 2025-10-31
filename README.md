# leluxeloop - Premium E-commerce Platform

A modern, luxury-focused e-commerce platform built with **Next.js 16**, **React 19**, **TypeScript**, **Tailwind CSS**, and **Supabase**.

## 🌟 Features

- ✨ Premium luxury product showcase
- 🛒 Shopping cart with persistent storage
- 🔐 Authentication with Supabase
- 💳 Stripe payment integration
- 📊 Product reviews and ratings
- 🎨 Elegant, modern UI with Tailwind CSS
- ⚡ Server-side rendering with App Router
- 🔄 Real-time database with Supabase
- 🚀 Production-ready architecture

## 🏗️ Project Structure

The project follows **industry-standard practices** with clean separation of concerns:

```
leluxeloop/
├── src/                          # All source code
│   ├── app/                      # Next.js 13+ App Router
│   │   ├── cart/                # Shopping cart
│   │   ├── products/            # Product pages
│   │   ├── layout.tsx           # Root layout
│   │   └── page.tsx             # Home page
│   ├── components/              # Reusable components
│   ├── lib/                     # Utilities & services
│   │   ├── supabase.ts          # Supabase client
│   │   └── store.ts             # Zustand store
│   ├── styles/                  # Global styles
│   ├── types/                   # TypeScript types
│   ├── hooks/                   # Custom hooks
│   └── constants/               # Constants
├── config/                       # Configuration files
├── docs/                         # Documentation
├── scripts/                      # Utility scripts
├── public/                       # Static assets
├── .env.example                  # Environment template
└── package.json                  # Dependencies
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ or later
- npm or yarn

### Installation

1. **Clone/Install Dependencies**
   ```bash
   npm install
   ```

2. **Set Up Environment Variables**
   ```bash
   cp .env.example .env.local
   ```
   Update `.env.local` with your values:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key
   ```

3. **Run Development Server**
   ```bash
   npm run dev
   ```

4. **Open in Browser**
   ```
   http://localhost:3000
   ```

## 📦 Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Next.js 16 |
| Runtime | React 19 |
| Language | TypeScript |
| Styling | Tailwind CSS |
| State | Zustand |
| Database | Supabase (PostgreSQL) |
| Authentication | Supabase Auth |
| Payments | Stripe |
| HTTP | Axios |

## 📚 Documentation

All documentation is organized in the `docs/` folder:

| File | Purpose |
|------|---------|
| `docs/INDEX.md` | **Start here** - Documentation index |
| `docs/QUICK_START.md` | 5-minute quick start |
| `docs/SETUP_GUIDE.md` | Complete setup guide |
| `docs/PROJECT_STRUCTURE.md` | Directory organization |
| `docs/DATABASE_SCHEMA.md` | Database structure |
| `docs/STRIPE_INTEGRATION.md` | Payment setup |
| `docs/REORGANIZATION_COMPLETE.md` | What was reorganized |

## 💻 Available Scripts

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm start        # Start production server
npm run lint     # Run ESLint
```

## 🗂️ Import Paths

Use path aliases for clean imports:

```typescript
// Components
import Button from '@/components/Button'

// Libraries
import { supabase } from '@/lib/supabase'
import { useCart } from '@/lib/store'

// Types
import { Product, User } from '@/types'

// Styles
import '@/styles/globals.css'
```

## 🔐 Environment Variables

Create `.env.local` based on `.env.example`:

```
# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key

# Stripe (optional)
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
```

## 📋 Features Breakdown

### Products
- Browse luxury products
- Filter and search
- View details and reviews
- Stock information

### Shopping Cart
- Add/remove items
- Update quantities
- Persistent storage
- Real-time totals

### Authentication
- Sign up and login
- Secure sessions
- User profiles

### Payments
- Stripe integration
- Order tracking
- Invoice management

## 🤝 Contributing

1. Create a new branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## 📝 License

This project is private and licensed under the leluxeloop Terms.

## 🎯 Next Steps

1. **Read the docs** - Start with `docs/INDEX.md`
2. **Set up environment** - Copy `.env.example` to `.env.local`
3. **Install dependencies** - Run `npm install`
4. **Start developing** - Run `npm run dev`

## 📧 Support

For questions or issues, please refer to the documentation in the `docs/` folder.

---

**Version:** 1.0.0  
**Built with:** Next.js 16 | React 19 | TypeScript | Tailwind CSS | Supabase
