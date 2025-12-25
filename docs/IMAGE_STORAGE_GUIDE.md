# Product Image Storage Guide

## How Image Storage Works

**IMPORTANT: You DO NOT store binary image files (PNG, AVIF, WebP) directly in database tables!**

### The Correct Approach:

1. **Store images in Supabase Storage** (object storage, like AWS S3)

   - Images are stored as files in a storage bucket
   - Supports PNG, JPEG, WebP, AVIF formats
   - Files are served via CDN with public URLs

2. **Store URLs in the database** (`product_images` table)
   - Only store the URL/path to the image
   - Store metadata (alt text, dimensions, file size, etc.)
   - This keeps your database small and fast

### Architecture:

```
┌─────────────────┐
│  Image File     │  (PNG/AVIF/WebP)
│  (5MB binary)   │
└────────┬────────┘
         │ Upload
         ▼
┌─────────────────┐
│ Supabase Storage│  (Object Storage Bucket)
│ product-images/ │  → Returns: https://xxx.supabase.co/storage/v1/object/public/product-images/product-123/image.png
└────────┬────────┘
         │ Store URL
         ▼
┌─────────────────┐
│ product_images  │  (Database Table)
│   table         │  → Stores: image_url, alt_text, display_order, etc.
└─────────────────┘
```

## Database Schema

The `product_images` table stores:

- `image_url` - Full URL to image in Supabase Storage
- `alt_text` - Accessibility text
- `display_order` - Order for image gallery
- `is_primary` - Main product image
- `file_name`, `file_size_bytes`, `mime_type` - Metadata
- `width_px`, `height_px` - Dimensions

**It does NOT store the binary image data!**

## Setup Instructions

### 1. Create Supabase Storage Bucket

In your Supabase dashboard:

1. Go to **Storage** → **Buckets**
2. Click **New Bucket**
3. Name: `product-images`
4. Make it **Public** (for public product images)
5. Click **Create**

### 2. Set Storage Policies

Allow public read access:

```sql
-- Allow public to read images
CREATE POLICY "Public Access" ON storage.objects
FOR SELECT
USING (bucket_id = 'product-images');
```

### 3. Upload Images

Use the utility functions in `src/lib/storage.ts`:

```typescript
import { uploadProductImage } from '@/lib/storage'
import { createProductImage } from '@/lib/products/images'

// Upload and save to database
const file = event.target.files[0]
const result = await createProductImage(file, productId, {
	altText: 'Product image',
	isPrimary: true,
	displayOrder: 0,
})
```

## Example: Uploading Product Images

```typescript
'use client'

import { useState } from 'react'
import { createProductImage } from '@/lib/products/images'

export function ImageUploader({ productId }: { productId: string }) {
	const [uploading, setUploading] = useState(false)

	const handleUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
		const file = e.target.files?.[0]
		if (!file) return

		setUploading(true)

		const { data, error } = await createProductImage(file, productId, {
			altText: file.name,
			isPrimary: true,
		})

		if (error) {
			alert(`Upload failed: ${error}`)
		} else {
			alert('Image uploaded successfully!')
		}

		setUploading(false)
	}

	return <input type='file' accept='image/png,image/jpeg,image/webp,image/avif' onChange={handleUpload} disabled={uploading} />
}
```

## File Size Limits

- Maximum file size: **5MB** (configurable in `src/lib/storage.ts`)
- Recommended formats: WebP (best compression), AVIF (modern), PNG (transparency), JPEG (photos)

## Image URLs

After upload, images are accessible via:

```
https://[your-project].supabase.co/storage/v1/object/public/product-images/[product-id]/[filename]
```

These URLs are stored in the `product_images.image_url` column.

## Best Practices

1. **Always use Supabase Storage** - Never store binary data in database
2. **Optimize images before upload** - Compress and resize client-side
3. **Use WebP/AVIF** - Better compression than PNG/JPEG
4. **Set primary image** - Mark one image as `is_primary = true`
5. **Add alt text** - For accessibility and SEO
6. **Clean up on delete** - Remove from storage when deleting from database

## Troubleshooting

**Error: "Bucket not found"**

- Create the `product-images` bucket in Supabase dashboard

**Error: "Permission denied"**

- Check storage policies allow public read access

**Images not loading**

- Verify bucket is set to **Public**
- Check `image_url` in database is correct
- Verify Next.js image config allows Supabase domain
