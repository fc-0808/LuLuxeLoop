-- ============================================================================
-- LELUXELOOP: LUXURY GLASSES E-COMMERCE DATABASE SCHEMA
-- Minimal, Production-Ready Design
-- Database Version: 1.0
-- ============================================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- ============================================================================
-- 1. BRANDS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS brands (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    founded_year INTEGER,
    country VARCHAR(100),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_brands_slug ON brands(slug);
CREATE INDEX IF NOT EXISTS idx_brands_is_active ON brands(is_active);
-- ============================================================================
-- 2. PRODUCT CATEGORIES
-- ============================================================================
CREATE TABLE IF NOT EXISTS product_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_product_categories_slug ON product_categories(slug);
-- ============================================================================
-- 3. FRAME MATERIALS (Reference Table)
-- ============================================================================
CREATE TABLE IF NOT EXISTS frame_materials (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    durability_rating INTEGER CHECK (
        durability_rating >= 1
        AND durability_rating <= 5
    ),
    price_multiplier DECIMAL(3, 2) DEFAULT 1.0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ============================================================================
-- 4. LENS TYPES (Reference Table)
-- ============================================================================
CREATE TABLE IF NOT EXISTS lens_types (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    uv_protection_level VARCHAR(50),
    price_multiplier DECIMAL(3, 2) DEFAULT 1.0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ============================================================================
-- 5. FRAME SHAPES (Reference Table)
-- ============================================================================
CREATE TABLE IF NOT EXISTS frame_shapes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ============================================================================
-- 6. PRODUCTS (Core Product Table)
-- ============================================================================
CREATE TABLE IF NOT EXISTS products (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    brand_id UUID NOT NULL REFERENCES brands(id) ON DELETE RESTRICT,
    category_id UUID NOT NULL REFERENCES product_categories(id) ON DELETE RESTRICT,
    frame_material_id UUID NOT NULL REFERENCES frame_materials(id),
    frame_shape_id UUID NOT NULL REFERENCES frame_shapes(id),
    default_lens_type_id UUID REFERENCES lens_types(id),
    -- Product identification
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    sku VARCHAR(100) NOT NULL UNIQUE,
    -- Description & details
    description TEXT NOT NULL,
    short_description VARCHAR(500),
    -- Specifications
    bridge_width_mm DECIMAL(4, 1),
    temple_length_mm DECIMAL(4, 1),
    lens_width_mm DECIMAL(4, 1),
    frame_size_category VARCHAR(50),
    weight_grams DECIMAL(5, 2),
    -- Pricing
    base_price DECIMAL(12, 2) NOT NULL,
    original_price DECIMAL(12, 2),
    cost_price DECIMAL(12, 2),
    -- Status
    status VARCHAR(50) DEFAULT 'draft',
    is_featured BOOLEAN DEFAULT false,
    is_bestseller BOOLEAN DEFAULT false,
    is_new BOOLEAN DEFAULT true,
    is_limited_edition BOOLEAN DEFAULT false,
    -- SEO
    meta_title VARCHAR(255),
    meta_description VARCHAR(500),
    -- Ratings
    average_rating DECIMAL(3, 2) DEFAULT 0,
    total_reviews INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(brand_id, sku)
);
CREATE INDEX IF NOT EXISTS idx_products_brand_id ON products(brand_id);
CREATE INDEX IF NOT EXISTS idx_products_category_id ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_slug ON products(slug);
CREATE INDEX IF NOT EXISTS idx_products_sku ON products(sku);
CREATE INDEX IF NOT EXISTS idx_products_status ON products(status);
CREATE INDEX IF NOT EXISTS idx_products_is_featured ON products(is_featured);
-- ============================================================================
-- 7. PRODUCT VARIANTS (SKU + Color + Inventory)
-- ============================================================================
CREATE TABLE IF NOT EXISTS product_variants (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    -- Color information (minimal)
    color_name VARCHAR(100) NOT NULL,
    color_hex VARCHAR(7),
    -- SKU & barcode
    sku_variant VARCHAR(50) NOT NULL,
    barcode VARCHAR(50),
    -- Pricing
    price DECIMAL(12, 2) NOT NULL,
    cost_price DECIMAL(12, 2),
    -- Inventory
    quantity_in_stock INTEGER DEFAULT 0,
    quantity_reserved INTEGER DEFAULT 0,
    reorder_level INTEGER DEFAULT 5,
    -- Status
    is_active BOOLEAN DEFAULT true,
    is_available BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, color_name)
);
CREATE INDEX IF NOT EXISTS idx_product_variants_product_id ON product_variants(product_id);
CREATE INDEX IF NOT EXISTS idx_product_variants_is_available ON product_variants(is_available);
-- ============================================================================
-- 8. PRODUCT IMAGES (Stores URLs/paths to images in Supabase Storage)
-- ============================================================================
CREATE TABLE IF NOT EXISTS product_images (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,
    -- Image storage path/URL (stored in Supabase Storage, not as binary in DB)
    image_url TEXT NOT NULL,
    -- Image metadata
    alt_text VARCHAR(255),
    display_order INTEGER DEFAULT 0,
    is_primary BOOLEAN DEFAULT false,
    -- Image file info (for reference, not storage)
    file_name VARCHAR(255),
    file_size_bytes INTEGER,
    mime_type VARCHAR(50),
    -- 'image/png', 'image/webp', 'image/avif', etc.
    width_px INTEGER,
    height_px INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_product_images_product_id ON product_images(product_id);
CREATE INDEX IF NOT EXISTS idx_product_images_variant_id ON product_images(variant_id);
CREATE INDEX IF NOT EXISTS idx_product_images_is_primary ON product_images(is_primary);
CREATE INDEX IF NOT EXISTS idx_product_images_display_order ON product_images(display_order);
-- Ensure only one primary image per product
CREATE UNIQUE INDEX IF NOT EXISTS idx_product_images_unique_primary ON product_images(product_id)
WHERE is_primary = true;
-- ============================================================================
-- SEED DATA
-- ============================================================================
-- Insert frame materials
INSERT INTO frame_materials (
        name,
        code,
        description,
        durability_rating,
        price_multiplier
    )
VALUES (
        'Acetate',
        'ACETATE',
        'Hypoallergenic, lightweight plastic material',
        4,
        1.0
    ),
    (
        'Titanium',
        'TITANIUM',
        'Ultra-lightweight, hypoallergenic, durable',
        5,
        2.5
    ),
    (
        'Metal (Stainless Steel)',
        'METAL_SS',
        'Classic, durable, corrosion-resistant',
        4,
        1.5
    ),
    (
        'Metal (Gold Plated)',
        'METAL_GOLD',
        'Luxurious gold-plated stainless steel',
        4,
        3.0
    ),
    (
        'Wood',
        'WOOD',
        'Eco-friendly, premium wood frames',
        3,
        2.0
    ),
    (
        'Combination (Mixed)',
        'COMBINATION',
        'Mixed material construction',
        4,
        1.8
    ),
    (
        'Plastic (Premium TR90)',
        'TR90',
        'Advanced polymer material, ultra-light',
        4,
        1.2
    ) ON CONFLICT (code) DO NOTHING;
-- Insert lens types
INSERT INTO lens_types (
        name,
        code,
        description,
        uv_protection_level,
        price_multiplier
    )
VALUES (
        'Single Vision',
        'SINGLE_VISION',
        'Standard single vision lenses',
        'UVA/UVB',
        1.0
    ),
    (
        'Bifocal',
        'BIFOCAL',
        'Two prescriptions in one lens',
        'UVA/UVB',
        1.3
    ),
    (
        'Progressive (No-line)',
        'PROGRESSIVE',
        'Smooth transition between prescriptions',
        'UVA/UVB',
        1.8
    ),
    (
        'Polarized',
        'POLARIZED',
        'Reduces glare, ideal for sunglasses',
        'UVA/UVB 100%',
        2.0
    ),
    (
        'Blue Light Filter',
        'BLUE_LIGHT',
        'Anti-blue light, protects eyes from screens',
        'UVA/UVB',
        1.5
    ),
    (
        'Photochromic (Transition)',
        'PHOTOCHROMIC',
        'Adaptive lenses that darken in sunlight',
        'UVA/UVB',
        1.6
    ),
    (
        'Mirrored',
        'MIRRORED',
        'Reflective coating, fashionable sunglasses',
        'UVA/UVB 100%',
        1.7
    ),
    (
        'Premium Anti-Reflective',
        'AR_PREMIUM',
        'Multi-coated, reduces reflections',
        'UVA/UVB',
        1.5
    ),
    (
        'Gradient',
        'GRADIENT',
        'Gradual color fade, stylish sunglasses',
        'UVA/UVB 100%',
        1.6
    ) ON CONFLICT (code) DO NOTHING;
-- Insert frame shapes
INSERT INTO frame_shapes (name, code, description)
VALUES ('Round', 'ROUND', 'Classic round frame shape'),
    ('Oval', 'OVAL', 'Soft oval frame shape'),
    (
        'Rectangle',
        'RECTANGLE',
        'Straight rectangular frames'
    ),
    ('Square', 'SQUARE', 'Bold square frame shape'),
    (
        'Wayfarer',
        'WAYFARER',
        'Iconic trapezoidal shape'
    ),
    (
        'Cat Eye',
        'CAT_EYE',
        'Upturned corners, retro style'
    ),
    (
        'Aviator',
        'AVIATOR',
        'Classic teardrop-shaped aviator'
    ),
    (
        'Shield',
        'SHIELD',
        'Large protective shield shape'
    ),
    (
        'Browline',
        'BROWLINE',
        'Brow-defined frame style'
    ),
    (
        'Geometric',
        'GEOMETRIC',
        'Modern geometric design'
    ) ON CONFLICT (code) DO NOTHING;
-- Insert product categories
INSERT INTO product_categories (name, slug, description, display_order)
VALUES (
        'Luxury Eyeglasses',
        'eyeglasses',
        'Premium prescription and non-prescription eyeglasses',
        1
    ),
    (
        'Luxury Sunglasses',
        'sunglasses',
        'Designer sunglasses with UV protection',
        2
    ),
    (
        'Reading Glasses',
        'reading-glasses',
        'Prescription and non-prescription reading glasses',
        3
    ),
    (
        'Blue Light Glasses',
        'blue-light',
        'Anti-blue light computer glasses',
        4
    ),
    (
        'Sport Glasses',
        'sport-glasses',
        'Performance luxury sports eyewear',
        5
    ) ON CONFLICT (slug) DO NOTHING;
-- ============================================================================
-- ROW LEVEL SECURITY
-- ============================================================================
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE frame_materials ENABLE ROW LEVEL SECURITY;
ALTER TABLE lens_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE frame_shapes ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_variants ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_images ENABLE ROW LEVEL SECURITY;
-- Allow public read access to reference tables and active products
CREATE POLICY "public_read_brands" ON brands FOR
SELECT USING (is_active = true);
CREATE POLICY "public_read_categories" ON product_categories FOR
SELECT USING (is_active = true);
CREATE POLICY "public_read_materials" ON frame_materials FOR
SELECT USING (is_active = true);
CREATE POLICY "public_read_lens_types" ON lens_types FOR
SELECT USING (is_active = true);
CREATE POLICY "public_read_shapes" ON frame_shapes FOR
SELECT USING (is_active = true);
CREATE POLICY "public_read_active_products" ON products FOR
SELECT USING (status = 'active');
CREATE POLICY "public_read_available_variants" ON product_variants FOR
SELECT USING (is_available = true);
CREATE POLICY "public_read_product_images" ON product_images FOR
SELECT USING (
        EXISTS (
            SELECT 1
            FROM products
            WHERE products.id = product_images.product_id
                AND products.status = 'active'
        )
    );