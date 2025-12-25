'use client';

import { useState, useEffect } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { createProductImage, getProductImages, removeProductImage } from '@/lib/products/images';
import type { ProductImage } from '@/lib/products/images';

export default function ProductImageUploadPage() {
  const params = useParams();
  const router = useRouter();
  const productId = params.id as string;

  const [uploading, setUploading] = useState(false);
  const [images, setImages] = useState<ProductImage[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  useEffect(() => {
    loadImages();
  }, [productId]);

  const loadImages = async () => {
    setLoading(true);
    const { data, error } = await getProductImages(productId);
    if (error) {
      setError(error);
    } else {
      setImages(data || []);
    }
    setLoading(false);
  };

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Validate file type
    const allowedTypes = ['image/png', 'image/jpeg', 'image/webp', 'image/avif'];
    if (!allowedTypes.includes(file.type)) {
      setError('Invalid file type. Allowed: PNG, JPEG, WebP, AVIF');
      return;
    }

    // Validate file size (5MB max)
    if (file.size > 5 * 1024 * 1024) {
      setError('File too large. Maximum size: 5MB');
      return;
    }

    setUploading(true);
    setError(null);
    setSuccess(null);

    const isPrimary = images.length === 0; // First image is primary

    const { error } = await createProductImage(file, productId, {
      altText: file.name,
      isPrimary,
      displayOrder: images.length,
    });

    if (error) {
      setError(`Upload failed: ${error}`);
    } else {
      setSuccess('Image uploaded successfully!');
      await loadImages(); // Reload images
      // Reset file input
      e.target.value = '';
    }

    setUploading(false);
  };

  const handleDelete = async (imageId: string) => {
    if (!confirm('Are you sure you want to delete this image?')) return;

    const { error } = await removeProductImage(imageId);
    if (error) {
      setError(`Delete failed: ${error}`);
    } else {
      setSuccess('Image deleted successfully!');
      await loadImages();
    }
  };

  if (loading) {
    return (
      <main className="min-h-screen bg-white p-8">
        <div className="max-w-4xl mx-auto">
          <div className="text-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-luxury-600 mx-auto mb-4"></div>
            <p className="text-gray-600">Loading images...</p>
          </div>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-white p-6 sm:p-8">
      <div className="max-w-4xl mx-auto">
        {/* Header */}
        <div className="mb-8">
          <button
            onClick={() => router.back()}
            className="text-luxury-600 hover:text-luxury-800 mb-4 text-sm sm:text-base"
          >
            ← Back
          </button>
          <h1 className="font-elegant text-2xl sm:text-3xl md:text-4xl text-luxury-800 mb-2">
            Upload Product Images
          </h1>
          <p className="text-gray-600 text-sm sm:text-base">
            Product ID: <code className="bg-gray-100 px-2 py-1 rounded text-xs">{productId}</code>
          </p>
        </div>

        {/* Messages */}
        {error && (
          <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm sm:text-base">
            {error}
          </div>
        )}
        {success && (
          <div className="mb-6 p-4 bg-green-50 border border-green-200 rounded-lg text-green-700 text-sm sm:text-base">
            {success}
          </div>
        )}

        {/* Upload Section */}
        <div className="bg-gray-50 rounded-lg p-6 sm:p-8 mb-8">
          <h2 className="font-elegant text-xl sm:text-2xl mb-4 text-luxury-800">Upload New Image</h2>
          
          <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center">
            <input
              type="file"
              accept="image/png,image/jpeg,image/webp,image/avif"
              onChange={handleFileUpload}
              disabled={uploading}
              className="hidden"
              id="image-upload"
            />
            <label
              htmlFor="image-upload"
              className={`cursor-pointer inline-block px-6 py-3 bg-luxury-800 text-white rounded-lg font-medium transition hover:bg-luxury-900 ${
                uploading ? 'opacity-50 cursor-not-allowed' : ''
              }`}
            >
              {uploading ? 'Uploading...' : 'Choose Image File'}
            </label>
            <p className="mt-4 text-sm text-gray-600">
              Supported formats: PNG, JPEG, WebP, AVIF (Max 5MB)
            </p>
          </div>
        </div>

        {/* Existing Images */}
        <div>
          <h2 className="font-elegant text-xl sm:text-2xl mb-4 text-luxury-800">
            Product Images ({images.length})
          </h2>

          {images.length === 0 ? (
            <div className="text-center py-12 bg-gray-50 rounded-lg">
              <p className="text-gray-600">No images uploaded yet.</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
              {images.map((image) => (
                <div
                  key={image.id}
                  className="border border-gray-200 rounded-lg overflow-hidden"
                >
                  <div className="relative aspect-square bg-gray-100">
                    <img
                      src={image.image_url}
                      alt={image.alt_text || 'Product image'}
                      className="w-full h-full object-cover"
                    />
                    {image.is_primary && (
                      <div className="absolute top-2 right-2 bg-luxury-800 text-white px-2 py-1 rounded text-xs font-medium">
                        Primary
                      </div>
                    )}
                  </div>
                  <div className="p-3 sm:p-4">
                    <p className="text-xs text-gray-600 mb-2 truncate">
                      {image.file_name || 'No filename'}
                    </p>
                    <div className="flex gap-2">
                      <button
                        onClick={() => handleDelete(image.id)}
                        className="flex-1 px-3 py-2 bg-red-600 text-white rounded text-xs sm:text-sm hover:bg-red-700 transition"
                      >
                        Delete
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </main>
  );
}

