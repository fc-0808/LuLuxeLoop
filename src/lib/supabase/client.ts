import { createBrowserClient } from '@supabase/ssr';

export function createClient() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;

  // During build time, return a mock client if env vars are missing
  if (!supabaseUrl || !supabaseKey) {
    if (typeof window === 'undefined') {
      // Server-side during build - return a mock
      return null as any;
    }
    throw new Error('Missing Supabase environment variables');
  }

  return createBrowserClient(supabaseUrl, supabaseKey);
}
