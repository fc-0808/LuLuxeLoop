-- ============================================================================
-- LELUXELOOP: LUXURY PRODUCTS SEED DATA
-- Professional luxury brands with high-quality product images
-- ============================================================================
-- ============================================================================
-- 1. INSERT LUXURY BRANDS
-- ============================================================================
INSERT INTO brands (
        id,
        name,
        slug,
        description,
        founded_year,
        country,
        is_active
    )
VALUES (
        '11111111-1111-1111-1111-111111111101',
        'Gucci',
        'gucci',
        'Italian luxury fashion house founded in Florence',
        1921,
        'Italy',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111102',
        'Louis Vuitton',
        'louis-vuitton',
        'French fashion house and luxury goods company',
        1854,
        'France',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111103',
        'Dior',
        'dior',
        'French luxury goods company',
        1946,
        'France',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111104',
        'Prada',
        'prada',
        'Italian luxury fashion house',
        1913,
        'Italy',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111105',
        'Chanel',
        'chanel',
        'French luxury fashion house',
        1910,
        'France',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111106',
        'Versace',
        'versace',
        'Italian luxury fashion company',
        1978,
        'Italy',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111107',
        'Burberry',
        'burberry',
        'British luxury fashion house',
        1856,
        'United Kingdom',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111108',
        'Cartier',
        'cartier',
        'French luxury goods conglomerate',
        1847,
        'France',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111109',
        'Hermès',
        'hermes',
        'French luxury goods manufacturer',
        1837,
        'France',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111110',
        'Balenciaga',
        'balenciaga',
        'Spanish luxury fashion house',
        1919,
        'Spain',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111111',
        'Fendi',
        'fendi',
        'Italian luxury fashion house',
        1925,
        'Italy',
        true
    ),
    (
        '11111111-1111-1111-1111-111111111112',
        'Saint Laurent',
        'saint-laurent',
        'French luxury fashion house',
        1961,
        'France',
        true
    ) ON CONFLICT (slug) DO NOTHING;
-- ============================================================================
-- 2. UPDATE CATEGORIES FOR BROADER LUXURY PRODUCTS
-- ============================================================================
DELETE FROM product_categories
WHERE slug IN (
        'eyeglasses',
        'sunglasses',
        'reading-glasses',
        'blue-light',
        'sport-glasses'
    );
INSERT INTO product_categories (
        id,
        name,
        slug,
        description,
        display_order,
        is_active
    )
VALUES (
        '22222222-2222-2222-2222-222222222201',
        'Jewelry',
        'jewelry',
        'Luxury jewelry including rings, necklaces, bracelets, and earrings',
        1,
        true
    ),
    (
        '22222222-2222-2222-2222-222222222202',
        'Watches',
        'watches',
        'Premium luxury timepieces',
        2,
        true
    ),
    (
        '22222222-2222-2222-2222-222222222203',
        'Handbags',
        'handbags',
        'Designer handbags and purses',
        3,
        true
    ),
    (
        '22222222-2222-2222-2222-222222222204',
        'Sunglasses',
        'sunglasses',
        'Designer sunglasses with UV protection',
        4,
        true
    ),
    (
        '22222222-2222-2222-2222-222222222205',
        'Accessories',
        'accessories',
        'Luxury belts, scarves, and accessories',
        5,
        true
    ),
    (
        '22222222-2222-2222-2222-222222222206',
        'Shoes',
        'shoes',
        'Designer footwear',
        6,
        true
    ) ON CONFLICT (slug) DO
UPDATE
SET name = EXCLUDED.name,
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order;
-- ============================================================================
-- 3. GET REFERENCE IDS (using first available)
-- ============================================================================
-- We'll use fixed UUIDs for simplicity
-- ============================================================================
-- 4. INSERT LUXURY PRODUCTS - JEWELRY CATEGORY
-- ============================================================================
-- Louis Vuitton Jewelry
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333301',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'LV Volt Upside Down Bracelet',
    'lv-volt-upside-down-bracelet',
    'LV-J001',
    'The Volt Upside Down bracelet features the iconic LV initials in a bold, modern design. Crafted in 18k white gold with diamonds.',
    'Iconic LV initials bracelet in 18k white gold',
    4500.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'GEOMETRIC'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333302',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'LV Idylle Blossom Pendant',
    'lv-idylle-blossom-pendant',
    'LV-J002',
    'The Idylle Blossom pendant showcases the Monogram flower in 18k rose gold, adorned with brilliant-cut diamonds.',
    'Monogram flower pendant in rose gold with diamonds',
    3200.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333303',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'LV Essential V Bracelet',
    'lv-essential-v-bracelet',
    'LV-J003',
    'A sleek and modern bracelet featuring the signature V motif in polished gold-tone metal.',
    'Signature V motif bracelet',
    890.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'GEOMETRIC'
LIMIT 1;
-- Gucci Jewelry
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333304',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Gucci Link to Love Ring',
    'gucci-link-to-love-ring',
    'GC-J001',
    'The Link to Love ring in 18k yellow gold features the iconic Gucci motif with studded detail.',
    'Iconic Gucci studded ring in 18k gold',
    1100.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333305',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Gucci GG Running Necklace',
    'gucci-gg-running-necklace',
    'GC-J002',
    'Double G pendant necklace in 18k white gold with diamonds, featuring the iconic interlocking G motif.',
    'Double G diamond pendant necklace',
    2800.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'GEOMETRIC'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333306',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Gucci Flora Earrings',
    'gucci-flora-earrings',
    'GC-J003',
    'Delicate flora-inspired earrings in 18k rose gold with mother of pearl and diamonds.',
    'Flora earrings with mother of pearl',
    1950.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'OVAL'
LIMIT 1;
-- Cartier Jewelry
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333307',
    '11111111-1111-1111-1111-111111111108',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Cartier Love Bracelet',
    'cartier-love-bracelet',
    'CT-J001',
    'The iconic Love bracelet in 18k yellow gold, featuring the signature screw motifs.',
    'Iconic Love bracelet in 18k gold',
    6900.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'OVAL'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333308',
    '11111111-1111-1111-1111-111111111108',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Cartier Juste un Clou Ring',
    'cartier-juste-un-clou-ring',
    'CT-J002',
    'The Juste un Clou ring reimagines the nail as a symbol of bold elegance in 18k rose gold.',
    'Nail-inspired ring in rose gold',
    3100.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'GEOMETRIC'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333309',
    '11111111-1111-1111-1111-111111111108',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Cartier Trinity Necklace',
    'cartier-trinity-necklace',
    'CT-J003',
    'The Trinity necklace features three interlocking rings in white, yellow, and rose gold.',
    'Three-gold interlocking rings necklace',
    2450.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
-- Dior Jewelry
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333310',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Dior Rose des Vents Bracelet',
    'dior-rose-des-vents-bracelet',
    'DR-J001',
    'Rose des Vents bracelet in 18k yellow gold with mother-of-pearl and diamond.',
    'Compass rose bracelet with mother-of-pearl',
    3400.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333311',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Dior Clair D Lune Earrings',
    'dior-clair-d-lune-earrings',
    'DR-J002',
    'Clair D Lune earrings featuring the CD signature in gold-finish metal with white crystals.',
    'CD signature crystal earrings',
    590.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333312',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222201',
    fm.id,
    fs.id,
    'Dior Petit CD Ring',
    'dior-petit-cd-ring',
    'DR-J003',
    'Petit CD ring in gold-finish metal adorned with white resin pearls and crystals.',
    'CD ring with pearls and crystals',
    450.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
-- ============================================================================
-- 5. INSERT LUXURY PRODUCTS - WATCHES CATEGORY
-- ============================================================================
-- Cartier Watches
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333401',
    '11111111-1111-1111-1111-111111111108',
    '22222222-2222-2222-2222-222222222202',
    fm.id,
    fs.id,
    'Cartier Tank Française Watch',
    'cartier-tank-francaise-watch',
    'CT-W001',
    'Tank Française watch in steel with a silver dial, featuring the iconic rectangular case.',
    'Iconic Tank watch in steel',
    7200.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_SS'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333402',
    '11111111-1111-1111-1111-111111111108',
    '22222222-2222-2222-2222-222222222202',
    fm.id,
    fs.id,
    'Cartier Santos de Cartier',
    'cartier-santos-de-cartier',
    'CT-W002',
    'Santos de Cartier watch in 18k yellow gold and steel, medium model with blue dial.',
    'Santos watch in gold and steel',
    12500.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'SQUARE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333403',
    '11111111-1111-1111-1111-111111111108',
    '22222222-2222-2222-2222-222222222202',
    fm.id,
    fs.id,
    'Cartier Ballon Bleu Watch',
    'cartier-ballon-bleu-watch',
    'CT-W003',
    'Ballon Bleu de Cartier watch in 18k rose gold, 36mm, with silvered dial.',
    'Ballon Bleu in rose gold',
    18900.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
-- Gucci Watches
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333404',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222202',
    fm.id,
    fs.id,
    'Gucci G-Timeless Watch',
    'gucci-g-timeless-watch',
    'GC-W001',
    'G-Timeless watch with bee motif dial, 38mm steel case with leather strap.',
    'G-Timeless with signature bee',
    1350.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_SS'
    AND fs.code = 'ROUND'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333405',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222202',
    fm.id,
    fs.id,
    'Gucci Grip Watch',
    'gucci-grip-watch',
    'GC-W002',
    'Grip watch in gold-tone PVD case with interlocking G pattern dial.',
    'Grip watch with GG pattern',
    1650.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'SQUARE'
LIMIT 1;
-- Dior Watches
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333406',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222202',
    fm.id,
    fs.id,
    'Dior Grand Bal Watch',
    'dior-grand-bal-watch',
    'DR-W001',
    'Grand Bal automatic watch in steel with mother-of-pearl dial and diamond bezel.',
    'Grand Bal with diamond bezel',
    28500.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_SS'
    AND fs.code = 'ROUND'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333407',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222202',
    fm.id,
    fs.id,
    'Dior La D de Dior Watch',
    'dior-la-d-de-dior-watch',
    'DR-W002',
    'La D de Dior watch in 18k rose gold with pink opal dial, 25mm.',
    'La D de Dior in rose gold',
    15800.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'ROUND'
LIMIT 1;
-- ============================================================================
-- 6. INSERT LUXURY PRODUCTS - HANDBAGS CATEGORY
-- ============================================================================
-- Louis Vuitton Handbags
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333501',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'LV Neverfull MM Monogram',
    'lv-neverfull-mm-monogram',
    'LV-B001',
    'The iconic Neverfull MM in Monogram canvas with natural cowhide trim. Spacious interior with removable pouch.',
    'Iconic Neverfull in Monogram canvas',
    1960.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333502',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'LV Speedy Bandoulière 25',
    'lv-speedy-bandouliere-25',
    'LV-B002',
    'Speedy Bandoulière 25 in Monogram canvas with adjustable strap. Classic barrel shape.',
    'Classic Speedy with strap',
    1770.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'OVAL'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333503',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'LV Pochette Métis',
    'lv-pochette-metis',
    'LV-B003',
    'Pochette Métis in Monogram canvas with S-lock closure. Versatile crossbody style.',
    'Pochette Métis crossbody',
    2570.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'SQUARE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333504',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'LV Alma BB Epi Leather',
    'lv-alma-bb-epi-leather',
    'LV-B004',
    'Alma BB in Epi leather with gold-tone hardware. Compact and elegant.',
    'Alma BB in Epi leather',
    1890.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'OVAL'
LIMIT 1;
-- Gucci Handbags
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333505',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Gucci Dionysus GG Supreme',
    'gucci-dionysus-gg-supreme',
    'GC-B001',
    'Dionysus shoulder bag in GG Supreme canvas with tiger head closure.',
    'Dionysus with tiger head closure',
    2890.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333506',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Gucci GG Marmont Small',
    'gucci-gg-marmont-small',
    'GC-B002',
    'GG Marmont small matelassé shoulder bag in black leather with Double G hardware.',
    'Marmont matelassé shoulder bag',
    2350.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333507',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Gucci Jackie 1961 Small',
    'gucci-jackie-1961-small',
    'GC-B003',
    'Jackie 1961 small shoulder bag in GG Supreme canvas with piston closure.',
    'Jackie 1961 hobo bag',
    2100.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'OVAL'
LIMIT 1;
-- Dior Handbags
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333508',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Lady Dior Medium',
    'lady-dior-medium',
    'DR-B001',
    'Lady Dior medium bag in black Cannage lambskin with gold-tone hardware and DIOR charms.',
    'Iconic Lady Dior in Cannage',
    5200.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'SQUARE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333509',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Dior Saddle Bag',
    'dior-saddle-bag',
    'DR-B002',
    'Saddle bag in blue Oblique jacquard with antique gold-tone hardware.',
    'Iconic Saddle in Oblique',
    3800.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'GEOMETRIC'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333510',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Dior Book Tote Medium',
    'dior-book-tote-medium',
    'DR-B003',
    'Book Tote medium in blue Dior Oblique embroidery. Spacious and iconic.',
    'Book Tote in Oblique embroidery',
    3350.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- Chanel Handbags
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333511',
    '11111111-1111-1111-1111-111111111105',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Chanel Classic Flap Medium',
    'chanel-classic-flap-medium',
    'CH-B001',
    'Classic Flap bag in black quilted lambskin with gold-tone hardware and chain strap.',
    'Iconic Classic Flap in lambskin',
    8800.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333512',
    '11111111-1111-1111-1111-111111111105',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Chanel Boy Bag Medium',
    'chanel-boy-bag-medium',
    'CH-B002',
    'Boy Chanel handbag in black quilted calfskin with ruthenium-finish hardware.',
    'Boy bag in quilted calfskin',
    5900.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- Hermès Handbags
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333513',
    '11111111-1111-1111-1111-111111111109',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Hermès Birkin 30',
    'hermes-birkin-30',
    'HM-B001',
    'Birkin 30 in Togo leather with palladium hardware. The ultimate luxury handbag.',
    'Iconic Birkin in Togo leather',
    12500.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333514',
    '11111111-1111-1111-1111-111111111109',
    '22222222-2222-2222-2222-222222222203',
    fm.id,
    fs.id,
    'Hermès Kelly 28',
    'hermes-kelly-28',
    'HM-B002',
    'Kelly 28 Retourne in Epsom leather with gold hardware. Timeless elegance.',
    'Kelly in Epsom leather',
    11200.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- ============================================================================
-- 7. INSERT LUXURY PRODUCTS - SUNGLASSES CATEGORY
-- ============================================================================
-- Gucci Sunglasses
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333601',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Gucci GG0956S Sunglasses',
    'gucci-gg0956s-sunglasses',
    'GC-S001',
    'Oversized square sunglasses in black acetate with interlocking G logo on temples.',
    'Oversized square with GG logo',
    450.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'SQUARE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333602',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Gucci GG1169S Aviator',
    'gucci-gg1169s-aviator',
    'GC-S002',
    'Aviator sunglasses in gold metal with green lenses and Web stripe detail.',
    'Aviator with Web stripe',
    520.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'AVIATOR'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333603',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Gucci GG0516S Cat Eye',
    'gucci-gg0516s-cat-eye',
    'GC-S003',
    'Cat eye sunglasses in havana acetate with crystal embellishments.',
    'Cat eye with crystals',
    680.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'CAT_EYE'
LIMIT 1;
-- Dior Sunglasses
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333604',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'DiorSignature S1U',
    'diorsignature-s1u',
    'DR-S001',
    'Signature butterfly sunglasses in black acetate with CD logo on temples.',
    'Signature butterfly style',
    490.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'CAT_EYE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333605',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'DiorBlackSuit S4U',
    'diorblacksuit-s4u',
    'DR-S002',
    'Square sunglasses in black acetate with Dior Oblique pattern on temples.',
    'Square with Oblique pattern',
    550.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'SQUARE'
LIMIT 1;
-- Prada Sunglasses
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333606',
    '11111111-1111-1111-1111-111111111104',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Prada PR 17WS',
    'prada-pr-17ws',
    'PR-S001',
    'Geometric sunglasses in black acetate with gold-tone Prada logo.',
    'Geometric with Prada logo',
    420.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'GEOMETRIC'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333607',
    '11111111-1111-1111-1111-111111111104',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Prada PR 14YS',
    'prada-pr-14ys',
    'PR-S002',
    'Round sunglasses in tortoise acetate with metal bridge detail.',
    'Round tortoise with metal bridge',
    380.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'ROUND'
LIMIT 1;
-- Versace Sunglasses
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333608',
    '11111111-1111-1111-1111-111111111106',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Versace VE4409 Medusa',
    'versace-ve4409-medusa',
    'VS-S001',
    'Square sunglasses with gold Medusa head detail on temples.',
    'Square with Medusa detail',
    350.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'SQUARE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333609',
    '11111111-1111-1111-1111-111111111106',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Versace VE2243 Shield',
    'versace-ve2243-shield',
    'VS-S002',
    'Shield sunglasses in gold metal with Greca pattern and mirror lenses.',
    'Shield with Greca pattern',
    480.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'METAL_GOLD'
    AND fs.code = 'SHIELD'
LIMIT 1;
-- Burberry Sunglasses
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333610',
    '11111111-1111-1111-1111-111111111107',
    '22222222-2222-2222-2222-222222222204',
    fm.id,
    fs.id,
    'Burberry BE4291 Check',
    'burberry-be4291-check',
    'BB-S001',
    'Square sunglasses with signature Burberry check pattern on temples.',
    'Square with Burberry check',
    290.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'ACETATE'
    AND fs.code = 'SQUARE'
LIMIT 1;
-- ============================================================================
-- 8. INSERT LUXURY PRODUCTS - ACCESSORIES CATEGORY
-- ============================================================================
-- Gucci Accessories
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333701',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'Gucci GG Marmont Belt',
    'gucci-gg-marmont-belt',
    'GC-A001',
    'GG Marmont leather belt with Double G buckle in shiny gold-tone hardware.',
    'Marmont belt with Double G',
    490.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333702',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'Gucci GG Wool Scarf',
    'gucci-gg-wool-scarf',
    'GC-A002',
    'GG jacquard wool scarf in beige and ebony with fringe detail.',
    'GG jacquard wool scarf',
    450.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- Louis Vuitton Accessories
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333703',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'LV Initiales Belt 40mm',
    'lv-initiales-belt-40mm',
    'LV-A001',
    'LV Initiales 40mm reversible belt in Monogram canvas and black leather.',
    'Reversible Monogram belt',
    680.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333704',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'LV Monogram Shawl',
    'lv-monogram-shawl',
    'LV-A002',
    'Monogram shawl in silk and wool blend with jacquard weave.',
    'Monogram silk-wool shawl',
    595.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333705',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'LV Zippy Wallet Monogram',
    'lv-zippy-wallet-monogram',
    'LV-A003',
    'Zippy wallet in Monogram canvas with zip-around closure and multiple card slots.',
    'Zippy wallet in Monogram',
    870.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- Hermès Accessories
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333706',
    '11111111-1111-1111-1111-111111111109',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'Hermès H Belt Buckle',
    'hermes-h-belt-buckle',
    'HM-A001',
    'Reversible leather belt with iconic H buckle in palladium-plated metal.',
    'Reversible belt with H buckle',
    1100.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333707',
    '11111111-1111-1111-1111-111111111109',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'Hermès Carré 90 Silk Scarf',
    'hermes-carre-90-silk-scarf',
    'HM-A002',
    'Carré 90 silk twill scarf with hand-rolled edges. Iconic Hermès print.',
    'Carré 90 silk scarf',
    495.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'SQUARE'
LIMIT 1;
-- Dior Accessories
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333708',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'Dior Saddle Belt',
    'dior-saddle-belt',
    'DR-A001',
    'Saddle belt in blue Dior Oblique jacquard with CD buckle.',
    'Saddle belt in Oblique',
    750.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333709',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222205',
    fm.id,
    fs.id,
    'Dior Mitzah Scarf',
    'dior-mitzah-scarf',
    'DR-A002',
    'Mitzah scarf in silk twill with Toile de Jouy print.',
    'Mitzah silk scarf',
    290.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- ============================================================================
-- 9. INSERT LUXURY PRODUCTS - SHOES CATEGORY
-- ============================================================================
-- Gucci Shoes
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333801',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Gucci Ace Sneakers',
    'gucci-ace-sneakers',
    'GC-SH001',
    'Ace sneakers in white leather with embroidered bee detail and Web stripe.',
    'Ace sneakers with bee',
    790.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333802',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Gucci Horsebit Loafers',
    'gucci-horsebit-loafers',
    'GC-SH002',
    'Horsebit loafers in black leather with gold-tone hardware.',
    'Classic Horsebit loafers',
    920.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'OVAL'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333803',
    '11111111-1111-1111-1111-111111111101',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Gucci Rhyton Sneakers',
    'gucci-rhyton-sneakers',
    'GC-SH003',
    'Rhyton sneakers in ivory leather with vintage Gucci logo.',
    'Rhyton chunky sneakers',
    980.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- Louis Vuitton Shoes
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333804',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'LV Trainer Sneakers',
    'lv-trainer-sneakers',
    'LV-SH001',
    'LV Trainer sneakers in white calf leather with Monogram flowers.',
    'LV Trainer in white leather',
    1290.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333805',
    '11111111-1111-1111-1111-111111111102',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'LV Archlight Sneakers',
    'lv-archlight-sneakers',
    'LV-SH002',
    'Archlight sneakers with wave-shaped outsole and technical fabric upper.',
    'Archlight wave sneakers',
    1350.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'GEOMETRIC'
LIMIT 1;
-- Dior Shoes
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333806',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Dior B23 High-Top Sneakers',
    'dior-b23-high-top-sneakers',
    'DR-SH001',
    'B23 high-top sneakers in blue Dior Oblique canvas.',
    'B23 in Oblique canvas',
    1150.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333807',
    '11111111-1111-1111-1111-111111111103',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Dior-ID Sneakers',
    'dior-id-sneakers',
    'DR-SH002',
    'Dior-ID sneakers in white and French blue technical fabric.',
    'Dior-ID technical sneakers',
    1090.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- Balenciaga Shoes
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333808',
    '11111111-1111-1111-1111-111111111110',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Balenciaga Triple S Sneakers',
    'balenciaga-triple-s-sneakers',
    'BL-SH001',
    'Triple S sneakers in white with multi-layered sole and distressed effect.',
    'Triple S chunky sneakers',
    1050.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333809',
    '11111111-1111-1111-1111-111111111110',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Balenciaga Speed Trainer',
    'balenciaga-speed-trainer',
    'BL-SH002',
    'Speed trainer in black stretch knit with Balenciaga logo.',
    'Speed sock sneakers',
    895.00,
    'active',
    true,
    false
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'OVAL'
LIMIT 1;
-- Prada Shoes
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333810',
    '11111111-1111-1111-1111-111111111104',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Prada Monolith Loafers',
    'prada-monolith-loafers',
    'PR-SH001',
    'Monolith brushed leather loafers with chunky rubber sole.',
    'Monolith platform loafers',
    1250.00,
    'active',
    true,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
INSERT INTO products (
        id,
        brand_id,
        category_id,
        frame_material_id,
        frame_shape_id,
        name,
        slug,
        sku,
        description,
        short_description,
        base_price,
        status,
        is_featured,
        is_new
    )
SELECT '33333333-3333-3333-3333-333333333811',
    '11111111-1111-1111-1111-111111111104',
    '22222222-2222-2222-2222-222222222206',
    fm.id,
    fs.id,
    'Prada America Cup Sneakers',
    'prada-americas-cup-sneakers',
    'PR-SH002',
    'Americas Cup sneakers in white leather and technical fabric.',
    'Americas Cup sneakers',
    850.00,
    'active',
    false,
    true
FROM frame_materials fm,
    frame_shapes fs
WHERE fm.code = 'COMBINATION'
    AND fs.code = 'RECTANGLE'
LIMIT 1;
-- ============================================================================
-- 10. INSERT PRODUCT IMAGES
-- Using high-quality Unsplash images for luxury products
-- ============================================================================
-- JEWELRY IMAGES
-- LV Volt Bracelet
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333301',
        'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=800&h=800&fit=crop&q=80',
        'LV Volt Bracelet Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333301',
        'https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=800&h=800&fit=crop&q=80',
        'LV Volt Bracelet Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333301',
        'https://images.unsplash.com/photo-1602751584552-8ba73aad10e1?w=800&h=800&fit=crop&q=80',
        'LV Volt Bracelet Box',
        2,
        false
    );
-- LV Idylle Pendant
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333302',
        'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&h=800&fit=crop&q=80',
        'LV Idylle Pendant Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333302',
        'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&h=800&fit=crop&q=80',
        'LV Idylle Pendant Detail',
        1,
        false
    );
-- LV Essential V Bracelet
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333303',
        'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=800&h=800&fit=crop&q=80',
        'LV Essential V Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333303',
        'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=800&h=800&fit=crop&q=80',
        'LV Essential V Detail',
        1,
        false
    );
-- Gucci Link to Love Ring
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333304',
        'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800&h=800&fit=crop&q=80',
        'Gucci Ring Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333304',
        'https://images.unsplash.com/photo-1603561591411-07134e71a2a9?w=800&h=800&fit=crop&q=80',
        'Gucci Ring Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333304',
        'https://images.unsplash.com/photo-1602751584552-8ba73aad10e1?w=800&h=800&fit=crop&q=80',
        'Gucci Ring Box',
        2,
        false
    );
-- Gucci GG Running Necklace
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333305',
        'https://images.unsplash.com/photo-1599643477877-530eb83abc8e?w=800&h=800&fit=crop&q=80',
        'Gucci Necklace Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333305',
        'https://images.unsplash.com/photo-1611652022419-a9419f74343d?w=800&h=800&fit=crop&q=80',
        'Gucci Necklace Detail',
        1,
        false
    );
-- Gucci Flora Earrings
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333306',
        'https://images.unsplash.com/photo-1535632787350-4e68ef0ac584?w=800&h=800&fit=crop&q=80',
        'Gucci Earrings Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333306',
        'https://images.unsplash.com/photo-1630019852942-f89202989a59?w=800&h=800&fit=crop&q=80',
        'Gucci Earrings Detail',
        1,
        false
    );
-- Cartier Love Bracelet
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333307',
        'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=800&h=800&fit=crop&q=80',
        'Cartier Love Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333307',
        'https://images.unsplash.com/photo-1602751584552-8ba73aad10e1?w=800&h=800&fit=crop&q=80',
        'Cartier Love Box',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333307',
        'https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=800&h=800&fit=crop&q=80',
        'Cartier Love Detail',
        2,
        false
    );
-- Cartier Juste un Clou Ring
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333308',
        'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800&h=800&fit=crop&q=80',
        'Cartier Clou Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333308',
        'https://images.unsplash.com/photo-1603561591411-07134e71a2a9?w=800&h=800&fit=crop&q=80',
        'Cartier Clou Detail',
        1,
        false
    );
-- Cartier Trinity Necklace
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333309',
        'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&h=800&fit=crop&q=80',
        'Cartier Trinity Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333309',
        'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&h=800&fit=crop&q=80',
        'Cartier Trinity Detail',
        1,
        false
    );
-- Dior Rose des Vents Bracelet
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333310',
        'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=800&h=800&fit=crop&q=80',
        'Dior Bracelet Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333310',
        'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=800&h=800&fit=crop&q=80',
        'Dior Bracelet Detail',
        1,
        false
    );
-- Dior Clair D Lune Earrings
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333311',
        'https://images.unsplash.com/photo-1535632787350-4e68ef0ac584?w=800&h=800&fit=crop&q=80',
        'Dior Earrings Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333311',
        'https://images.unsplash.com/photo-1630019852942-f89202989a59?w=800&h=800&fit=crop&q=80',
        'Dior Earrings Detail',
        1,
        false
    );
-- Dior Petit CD Ring
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333312',
        'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800&h=800&fit=crop&q=80',
        'Dior Ring Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333312',
        'https://images.unsplash.com/photo-1603561591411-07134e71a2a9?w=800&h=800&fit=crop&q=80',
        'Dior Ring Detail',
        1,
        false
    );
-- WATCHES IMAGES
-- Cartier Tank Française
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333401',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800&h=800&fit=crop&q=80',
        'Cartier Tank Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333401',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800&h=800&fit=crop&q=80',
        'Cartier Tank Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333401',
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=800&h=800&fit=crop&q=80',
        'Cartier Tank Side',
        2,
        false
    );
-- Cartier Santos
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333402',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800&h=800&fit=crop&q=80',
        'Cartier Santos Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333402',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800&h=800&fit=crop&q=80',
        'Cartier Santos Detail',
        1,
        false
    );
-- Cartier Ballon Bleu
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333403',
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=800&h=800&fit=crop&q=80',
        'Cartier Ballon Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333403',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800&h=800&fit=crop&q=80',
        'Cartier Ballon Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333403',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800&h=800&fit=crop&q=80',
        'Cartier Ballon Side',
        2,
        false
    );
-- Gucci G-Timeless
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333404',
        'https://images.unsplash.com/photo-1539874754764-5a96559165b0?w=800&h=800&fit=crop&q=80',
        'Gucci Watch Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333404',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800&h=800&fit=crop&q=80',
        'Gucci Watch Detail',
        1,
        false
    );
-- Gucci Grip
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333405',
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=800&h=800&fit=crop&q=80',
        'Gucci Grip Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333405',
        'https://images.unsplash.com/photo-1539874754764-5a96559165b0?w=800&h=800&fit=crop&q=80',
        'Gucci Grip Detail',
        1,
        false
    );
-- Dior Grand Bal
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333406',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800&h=800&fit=crop&q=80',
        'Dior Grand Bal Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333406',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800&h=800&fit=crop&q=80',
        'Dior Grand Bal Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333406',
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=800&h=800&fit=crop&q=80',
        'Dior Grand Bal Side',
        2,
        false
    );
-- Dior La D de Dior
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333407',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800&h=800&fit=crop&q=80',
        'Dior La D Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333407',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800&h=800&fit=crop&q=80',
        'Dior La D Detail',
        1,
        false
    );
-- HANDBAGS IMAGES
-- LV Neverfull
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333501',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'LV Neverfull Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333501',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'LV Neverfull Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333501',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'LV Neverfull Side',
        2,
        false
    );
-- LV Speedy
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333502',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'LV Speedy Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333502',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'LV Speedy Detail',
        1,
        false
    );
-- LV Pochette Métis
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333503',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'LV Pochette Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333503',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'LV Pochette Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333503',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'LV Pochette Side',
        2,
        false
    );
-- LV Alma BB
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333504',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'LV Alma Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333504',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'LV Alma Detail',
        1,
        false
    );
-- Gucci Dionysus
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333505',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'Gucci Dionysus Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333505',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Gucci Dionysus Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333505',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'Gucci Dionysus Side',
        2,
        false
    );
-- Gucci Marmont
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333506',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'Gucci Marmont Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333506',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'Gucci Marmont Detail',
        1,
        false
    );
-- Gucci Jackie
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333507',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Gucci Jackie Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333507',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'Gucci Jackie Detail',
        1,
        false
    );
-- Lady Dior
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333508',
        'https://images.unsplash.com/photo-1591561954557-26941169b49e?w=800&h=800&fit=crop&q=80',
        'Lady Dior Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333508',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Lady Dior Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333508',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'Lady Dior Side',
        2,
        false
    );
-- Dior Saddle
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333509',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Dior Saddle Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333509',
        'https://images.unsplash.com/photo-1591561954557-26941169b49e?w=800&h=800&fit=crop&q=80',
        'Dior Saddle Detail',
        1,
        false
    );
-- Dior Book Tote
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333510',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'Dior Book Tote Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333510',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Dior Book Tote Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333510',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'Dior Book Tote Side',
        2,
        false
    );
-- Chanel Classic Flap
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333511',
        'https://images.unsplash.com/photo-1591561954557-26941169b49e?w=800&h=800&fit=crop&q=80',
        'Chanel Flap Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333511',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Chanel Flap Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333511',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'Chanel Flap Side',
        2,
        false
    );
-- Chanel Boy
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333512',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Chanel Boy Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333512',
        'https://images.unsplash.com/photo-1591561954557-26941169b49e?w=800&h=800&fit=crop&q=80',
        'Chanel Boy Detail',
        1,
        false
    );
-- Hermès Birkin
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333513',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'Hermes Birkin Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333513',
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&h=800&fit=crop&q=80',
        'Hermes Birkin Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333513',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'Hermes Birkin Side',
        2,
        false
    );
-- Hermès Kelly
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333514',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&h=800&fit=crop&q=80',
        'Hermes Kelly Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333514',
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800&h=800&fit=crop&q=80',
        'Hermes Kelly Detail',
        1,
        false
    );
-- SUNGLASSES IMAGES
-- Gucci GG0956S
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333601',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Gucci Sunglasses Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333601',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&h=800&fit=crop&q=80',
        'Gucci Sunglasses Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333601',
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800&h=800&fit=crop&q=80',
        'Gucci Sunglasses Side',
        2,
        false
    );
-- Gucci Aviator
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333602',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&h=800&fit=crop&q=80',
        'Gucci Aviator Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333602',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Gucci Aviator Detail',
        1,
        false
    );
-- Gucci Cat Eye
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333603',
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800&h=800&fit=crop&q=80',
        'Gucci Cat Eye Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333603',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Gucci Cat Eye Detail',
        1,
        false
    );
-- Dior Signature
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333604',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Dior Signature Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333604',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&h=800&fit=crop&q=80',
        'Dior Signature Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333604',
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800&h=800&fit=crop&q=80',
        'Dior Signature Side',
        2,
        false
    );
-- Dior BlackSuit
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333605',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&h=800&fit=crop&q=80',
        'Dior BlackSuit Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333605',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Dior BlackSuit Detail',
        1,
        false
    );
-- Prada PR 17WS
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333606',
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800&h=800&fit=crop&q=80',
        'Prada Geometric Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333606',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Prada Geometric Detail',
        1,
        false
    );
-- Prada PR 14YS
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333607',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Prada Round Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333607',
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800&h=800&fit=crop&q=80',
        'Prada Round Detail',
        1,
        false
    );
-- Versace Medusa
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333608',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&h=800&fit=crop&q=80',
        'Versace Medusa Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333608',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Versace Medusa Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333608',
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800&h=800&fit=crop&q=80',
        'Versace Medusa Side',
        2,
        false
    );
-- Versace Shield
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333609',
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800&h=800&fit=crop&q=80',
        'Versace Shield Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333609',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&h=800&fit=crop&q=80',
        'Versace Shield Detail',
        1,
        false
    );
-- Burberry Check
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333610',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&h=800&fit=crop&q=80',
        'Burberry Check Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333610',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&h=800&fit=crop&q=80',
        'Burberry Check Detail',
        1,
        false
    );
-- ACCESSORIES IMAGES
-- Gucci Marmont Belt
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333701',
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&h=800&fit=crop&q=80',
        'Gucci Belt Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333701',
        'https://images.unsplash.com/photo-1624222247344-550fb60583dc?w=800&h=800&fit=crop&q=80',
        'Gucci Belt Detail',
        1,
        false
    );
-- Gucci Wool Scarf
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333702',
        'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=800&h=800&fit=crop&q=80',
        'Gucci Scarf Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333702',
        'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=800&h=800&fit=crop&q=80',
        'Gucci Scarf Detail',
        1,
        false
    );
-- LV Initiales Belt
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333703',
        'https://images.unsplash.com/photo-1624222247344-550fb60583dc?w=800&h=800&fit=crop&q=80',
        'LV Belt Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333703',
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&h=800&fit=crop&q=80',
        'LV Belt Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333703',
        'https://images.unsplash.com/photo-1585856331426-d7a22a8a9698?w=800&h=800&fit=crop&q=80',
        'LV Belt Box',
        2,
        false
    );
-- LV Monogram Shawl
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333704',
        'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=800&h=800&fit=crop&q=80',
        'LV Shawl Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333704',
        'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=800&h=800&fit=crop&q=80',
        'LV Shawl Detail',
        1,
        false
    );
-- LV Zippy Wallet
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333705',
        'https://images.unsplash.com/photo-1627123424574-724758594e93?w=800&h=800&fit=crop&q=80',
        'LV Wallet Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333705',
        'https://images.unsplash.com/photo-1606503825008-909a67e63c3d?w=800&h=800&fit=crop&q=80',
        'LV Wallet Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333705',
        'https://images.unsplash.com/photo-1585856331426-d7a22a8a9698?w=800&h=800&fit=crop&q=80',
        'LV Wallet Box',
        2,
        false
    );
-- Hermès H Belt
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333706',
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&h=800&fit=crop&q=80',
        'Hermes Belt Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333706',
        'https://images.unsplash.com/photo-1624222247344-550fb60583dc?w=800&h=800&fit=crop&q=80',
        'Hermes Belt Detail',
        1,
        false
    );
-- Hermès Carré Scarf
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333707',
        'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=800&h=800&fit=crop&q=80',
        'Hermes Scarf Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333707',
        'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=800&h=800&fit=crop&q=80',
        'Hermes Scarf Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333707',
        'https://images.unsplash.com/photo-1585856331426-d7a22a8a9698?w=800&h=800&fit=crop&q=80',
        'Hermes Scarf Box',
        2,
        false
    );
-- Dior Saddle Belt
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333708',
        'https://images.unsplash.com/photo-1624222247344-550fb60583dc?w=800&h=800&fit=crop&q=80',
        'Dior Belt Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333708',
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&h=800&fit=crop&q=80',
        'Dior Belt Detail',
        1,
        false
    );
-- Dior Mitzah Scarf
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333709',
        'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=800&h=800&fit=crop&q=80',
        'Dior Scarf Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333709',
        'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=800&h=800&fit=crop&q=80',
        'Dior Scarf Detail',
        1,
        false
    );
-- SHOES IMAGES
-- Gucci Ace
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333801',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'Gucci Ace Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333801',
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=800&fit=crop&q=80',
        'Gucci Ace Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333801',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&h=800&fit=crop&q=80',
        'Gucci Ace Side',
        2,
        false
    );
-- Gucci Horsebit Loafers
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333802',
        'https://images.unsplash.com/photo-1614252369475-531eba835eb1?w=800&h=800&fit=crop&q=80',
        'Gucci Loafers Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333802',
        'https://images.unsplash.com/photo-1582897085656-c636d006a246?w=800&h=800&fit=crop&q=80',
        'Gucci Loafers Detail',
        1,
        false
    );
-- Gucci Rhyton
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333803',
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=800&fit=crop&q=80',
        'Gucci Rhyton Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333803',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'Gucci Rhyton Detail',
        1,
        false
    );
-- LV Trainer
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333804',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&h=800&fit=crop&q=80',
        'LV Trainer Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333804',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'LV Trainer Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333804',
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=800&fit=crop&q=80',
        'LV Trainer Side',
        2,
        false
    );
-- LV Archlight
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333805',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'LV Archlight Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333805',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&h=800&fit=crop&q=80',
        'LV Archlight Detail',
        1,
        false
    );
-- Dior B23
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333806',
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=800&fit=crop&q=80',
        'Dior B23 Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333806',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'Dior B23 Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333806',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&h=800&fit=crop&q=80',
        'Dior B23 Side',
        2,
        false
    );
-- Dior-ID
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333807',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&h=800&fit=crop&q=80',
        'Dior-ID Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333807',
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=800&fit=crop&q=80',
        'Dior-ID Detail',
        1,
        false
    );
-- Balenciaga Triple S
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333808',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'Balenciaga Triple S Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333808',
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=800&fit=crop&q=80',
        'Balenciaga Triple S Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333808',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&h=800&fit=crop&q=80',
        'Balenciaga Triple S Side',
        2,
        false
    );
-- Balenciaga Speed
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333809',
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=800&fit=crop&q=80',
        'Balenciaga Speed Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333809',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'Balenciaga Speed Detail',
        1,
        false
    );
-- Prada Monolith
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333810',
        'https://images.unsplash.com/photo-1614252369475-531eba835eb1?w=800&h=800&fit=crop&q=80',
        'Prada Monolith Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333810',
        'https://images.unsplash.com/photo-1582897085656-c636d006a246?w=800&h=800&fit=crop&q=80',
        'Prada Monolith Detail',
        1,
        false
    ),
    (
        '33333333-3333-3333-3333-333333333810',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'Prada Monolith Side',
        2,
        false
    );
-- Prada Americas Cup
INSERT INTO product_images (
        product_id,
        image_url,
        alt_text,
        display_order,
        is_primary
    )
VALUES (
        '33333333-3333-3333-3333-333333333811',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&h=800&fit=crop&q=80',
        'Prada Americas Cup Main',
        0,
        true
    ),
    (
        '33333333-3333-3333-3333-333333333811',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=800&fit=crop&q=80',
        'Prada Americas Cup Detail',
        1,
        false
    );
-- ============================================================================
-- END OF SEED DATA
-- Total: 12 Brands, 6 Categories, 50+ Products with 100+ Images
-- ============================================================================