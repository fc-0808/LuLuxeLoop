# Image Upload Workflow

## Step-by-Step Guide

### ✅ Step 1: Run Database Migration

First, you need to create the `product_images` table in your database:

1. Go to Supabase Dashboard → **SQL Editor**
2. Copy and run the `product_images` table creation from `supabase_luxury_glasses_schema.sql` (lines 156-182)
3. Or run the entire schema file if you haven't already

**Quick SQL to run:**

```sql
-- Create product_images table
CREATE TABLE IF NOT EXISTS product_images (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    alt_text VARCHAR(255),
    display_order INTEGER DEFAULT 0,
    is_primary BOOLEAN DEFAULT false,
    file_name VARCHAR(255),
    file_size_bytes INTEGER,
    mime_type VARCHAR(50),
    width_px INTEGER,
    height_px INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_product_images_product_id ON product_images(product_id);
CREATE INDEX IF NOT EXISTS idx_product_images_variant_id ON product_images(variant_id);
CREATE INDEX IF NOT EXISTS idx_product_images_is_primary ON product_images(is_primary);
CREATE INDEX IF NOT EXISTS idx_product_images_display_order ON product_images(display_order);

-- Ensure only one primary image per product
CREATE UNIQUE INDEX IF NOT EXISTS idx_product_images_unique_primary
    ON product_images(product_id)
    WHERE is_primary = true;

-- Enable RLS
ALTER TABLE product_images ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "public_read_product_images" ON product_images FOR
SELECT USING (
    EXISTS (
        SELECT 1 FROM products
        WHERE products.id = product_images.product_id
        AND products.status = 'active'
    )
);
```

### ✅ Step 2: Create Products First

**IMPORTANT:** You need products in your database before uploading images!

Images must be linked to a `product_id`. You have two options:

#### Option A: Create Products via SQL (Quick)

```sql
-- First, create a brand (if you don't have one)
INSERT INTO brands (name, slug, description)
VALUES ('Ray-Ban', 'ray-ban', 'Premium eyewear brand')
ON CONFLICT (slug) DO NOTHING;

-- Get category ID (assuming you have categories from seed data)
-- Get frame material and shape IDs (from seed data)

-- Create a product
INSERT INTO products (
    brand_id,
    category_id,
    frame_material_id,
    frame_shape_id,
    name,
    slug,
    sku,
    description,
    base_price,
    status
)
SELECT
    (SELECT id FROM brands WHERE slug = 'ray-ban' LIMIT 1),
    (SELECT id FROM product_categories WHERE slug = 'sunglasses' LIMIT 1),
    (SELECT id FROM frame_materials WHERE code = 'ACETATE' LIMIT 1),
    (SELECT id FROM frame_shapes WHERE code = 'AVIATOR' LIMIT 1),
    'Classic Aviator Sunglasses',
    'classic-aviator-sunglasses',
    'RB-AVIATOR-001',
    'Classic aviator sunglasses with premium acetate frames',
    299.99,
    'active'
RETURNING id;
```

#### Option B: Use Application Code (Better)

Create products via your application, then upload images.

### ✅ Step 3: Upload Images

You have **two options** for uploading:

#### Option A: Manual Upload via Supabase Dashboard (Quick Testing)

1. Go to **Storage** → **product-images** bucket
2. Click **Upload files** or drag & drop
3. Upload your PNG/WebP/AVIF files
4. **After upload**, you need to manually insert records into `product_images` table:

```sql
-- Get the public URL from Supabase Storage
-- Format: https://[project].supabase.co/storage/v1/object/public/product-images/[filename]

-- Insert image record
INSERT INTO product_images (
    product_id,
    image_url,
    alt_text,
    is_primary,
    display_order,
    file_name,
    mime_type
)
VALUES (
    'YOUR_PRODUCT_ID_HERE',  -- Replace with actual product UUID
    'https://[project].supabase.co/storage/v1/object/public/product-images/your-image.webp',
    'Product image description',
    true,  -- Set as primary image
    0,     -- Display order
    'your-image.webp',
    'image/webp'
);
```

#### Option B: Use Application Code (Recommended)

Use the admin upload page I'll create for you - it handles everything automatically!

## Recommended File Formats

- **WebP** - Best compression, modern browsers ✅ (Recommended)
- **AVIF** - Even better compression, newer browsers ✅
- **PNG** - Good for transparency, larger files
- **JPEG** - Good for photos, no transparency

## File Size Recommendations

- **Maximum:** 5MB per image
- **Recommended:** Under 1MB for web performance
- **Optimize before upload:** Use tools like Squoosh, TinyPNG, or ImageOptim

## Next Steps

1. ✅ Run database migration
2. ✅ Create products in database
3. ✅ Upload images (manual or via app)
4. ✅ Test image display in your application
