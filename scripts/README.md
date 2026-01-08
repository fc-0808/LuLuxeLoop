# Database Seed Scripts

## seed_luxury_products.sql

This script populates your LeLuxeLoop database with luxury brand products.

### Contents:

- **12 Luxury Brands**: Gucci, Louis Vuitton, Dior, Prada, Chanel, Versace, Burberry, Cartier, Hermès, Balenciaga, Fendi, Saint Laurent
- **6 Product Categories**: Jewelry, Watches, Handbags, Sunglasses, Accessories, Shoes
- **50+ Products** with professional descriptions and pricing
- **100+ Product Images** using high-quality Unsplash images

### How to Run:

#### Option 1: Supabase Dashboard (Recommended)

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Click **New Query**
4. Copy and paste the contents of `seed_luxury_products.sql`
5. Click **Run** to execute

#### Option 2: Supabase CLI

```bash
supabase db push --db-url "your-database-url" < scripts/seed_luxury_products.sql
```

#### Option 3: psql

```bash
psql "your-database-connection-string" -f scripts/seed_luxury_products.sql
```

### Important Notes:

- Make sure you've already run the main schema (`supabase_luxury_glasses_schema.sql`) first
- The script uses `ON CONFLICT DO NOTHING` for brands to avoid duplicates
- Products use fixed UUIDs for easy reference and re-running
- All products are set to `status = 'active'` so they appear on the website immediately

### After Running:

Refresh your website homepage to see all the products displayed in the Yupoo-style grid layout.
