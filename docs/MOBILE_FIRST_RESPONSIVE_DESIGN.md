# Mobile-First Responsive Design Guide

## 📱 Project Overview

LeLuxeLoop is built with a **mobile-first responsive design approach**. This means all base styles are designed for mobile devices (320px+), and progressive enhancements are added for larger screens using Tailwind CSS breakpoints.

---

## 🎯 Core Principles

### 1. **Mobile-First Strategy**

- **Start Small**: Base styles target mobile devices (320px - 639px)
- **Enhance Progressively**: Use breakpoints to add complexity for larger screens
- **Touch-Friendly**: Minimum 44x44px touch targets on all interactive elements
- **Performance**: Faster load times with simpler mobile layouts

### 2. **Accessibility First**

- Semantic HTML structure
- WCAG 2.1 AA compliance
- Keyboard navigation support
- Screen reader optimized
- Respects `prefers-reduced-motion` media query

---

## 📐 Tailwind Breakpoints

| Breakpoint      | Size          | Usage                            |
| --------------- | ------------- | -------------------------------- |
| **None** (base) | 320px - 639px | Mobile devices                   |
| **sm**          | 640px+        | Small tablets (landscape phones) |
| **md**          | 768px+        | Tablets                          |
| **lg**          | 1024px+       | Desktops                         |
| **xl**          | 1280px+       | Large desktops                   |

### Usage Pattern

```jsx
{
	/* Base (mobile): Block layout */
}
{
	/* sm: Two columns */
}
{
	/* md: Three columns */
}
;<div className='grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3'>{/* Items */}</div>
```

---

## 📏 Responsive Typography

All heading sizes scale progressively across breakpoints:

### Heading Scaling Strategy

```css
/* Mobile First */
h1 {
	font-size: 1.875rem; /* 30px */
}

@media (min-width: 768px) {
	h1 {
		font-size: 2.25rem; /* 36px */
	}
}

@media (min-width: 1024px) {
	h1 {
		font-size: 3rem; /* 48px */
	}
}
```

### Heading Scale Reference

| Tag    | Mobile   | Tablet   | Desktop  |
| ------ | -------- | -------- | -------- |
| **h1** | 1.875rem | 2.25rem  | 3rem     |
| **h2** | 1.5rem   | 1.875rem | 2.25rem  |
| **h3** | 1.25rem  | 1.5rem   | 1.875rem |
| **h4** | 1.125rem | 1.25rem  | 1.5rem   |

### Paragraph Typography

```jsx
{
	/* Responsive paragraph sizing */
}
;<p className='text-base sm:text-lg md:text-xl lg:text-2xl'>Responsive text that scales with screen size</p>
```

---

## 🎨 Responsive Spacing

Use the `.py-mobile`, `.px-mobile`, and `.gap-mobile` utility classes for consistent responsive spacing:

```jsx
{
	/* Section Padding */
}
;<section className='py-mobile'>{/* Mobile: py-8, sm: py-12, md: py-16, lg: py-20 */}</section>

{
	/* Horizontal Padding */
}
;<div className='px-mobile'>{/* Mobile: px-4, sm: px-6, lg: px-8 */}</div>

{
	/* Gap in Grids */
}
;<div className='grid gap-mobile'>{/* Mobile: gap-4, sm: gap-6, md: gap-8, lg: gap-12 */}</div>
```

### Spacing Scale

| Property       | Mobile | Small | Medium | Large  |
| -------------- | ------ | ----- | ------ | ------ |
| **py-mobile**  | py-8   | py-12 | py-16  | py-20  |
| **px-mobile**  | px-4   | px-6  | -      | px-8   |
| **gap-mobile** | gap-4  | gap-6 | gap-8  | gap-12 |

---

## 🔘 Button Sizing

Buttons are touch-friendly with minimum 44x44px touch targets:

```jsx
{
	/* Mobile-first button sizing */
}
;<button className='btn btn-primary px-4 sm:px-6 py-2.5 sm:py-3'>
	{/* Mobile: 44px height, sm: 48px height */}
	Button Text
</button>
```

**Button Properties**:

- Mobile: `44px` minimum height (WCAG compliant)
- Padding adjusts: `px-4 py-2.5` → `sm:px-6 sm:py-3`
- Font size: `text-sm sm:text-base`

---

## 🗂️ Grid Layouts

### Product Grid Pattern

```jsx
{
	/* Mobile: 1 column, sm: 2 columns, lg: 3-4 columns */
}
;<div className='grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-mobile'>
	{products.map((product) => (
		<ProductCard key={product.id} product={product} />
	))}
</div>
```

### Page Layout Pattern

```jsx
{
	/* Mobile: Single column (full width), md: 3-4 column grid */
}
;<div className='grid grid-cols-1 md:grid-cols-4 gap-6 md:gap-8 lg:gap-12'>
	{/* Sidebar (col-span-1 on md+) */}
	<aside className='md:col-span-1'>...</aside>

	{/* Main content (col-span-3 on md+) */}
	<div className='md:col-span-3'>...</div>
</div>
```

---

## 📦 Component Responsive Patterns

### 1. Navigation Bar

```jsx
{
	/* Logo responsive sizing */
}
;<Link href='/' className='text-xl sm:text-2xl'>
	Logo
</Link>

{
	/* Desktop nav hidden on mobile */
}
;<div className='hidden md:flex gap-6 lg:gap-8'>{/* Nav links */}</div>

{
	/* Mobile menu button */
}
;<button className='md:hidden'>☰</button>
```

### 2. Hero Section

```jsx
{
	/* Mobile: min-h-screen, sm+: h-screen */
}
;<section className='relative w-full min-h-screen sm:h-screen'>
	<h1 className='font-elegant mb-4 sm:mb-6'>Heading</h1>

	{/* Mobile: vertical buttons, sm+: horizontal */}
	<div className='flex flex-col sm:flex-row gap-3 sm:gap-4'>
		<button>Action 1</button>
		<button>Action 2</button>
	</div>
</section>
```

### 3. Product Card

```jsx
{/* Fixed aspect ratio for consistency */}
<div className="product-image-container">
  {/* aspect-ratio: 400/500 on desktop, 1/1.25 on mobile */}
  <Image src={src} alt={alt} fill />
</div>

<div className="p-3 sm:p-4">
  <h3 className="text-base sm:text-lg">Product Name</h3>
  <p className="text-xs sm:text-sm">Description</p>
</div>
```

### 4. Cart/Order Summary

```jsx
{
	/* Mobile: stacked below, md+: sidebar */
}
;<div className='grid grid-cols-1 md:grid-cols-3 gap-6 md:gap-8'>
	{/* Cart items: full width mobile, 2/3 on md+ */}
	<div className='md:col-span-2'>Items</div>

	{/* Summary: full width mobile, sticky sidebar on md+ */}
	<div className='md:col-span-1'>
		<div className='sticky top-24 md:top-28'>Summary</div>
	</div>
</div>
```

### 5. Mobile-Only Filter Menu

```jsx
{
	/* Show filter toggle only on mobile */
}
;<div className='flex md:hidden gap-3 mb-6'>
	<button onClick={() => setFilterOpen(!filterOpen)}>Filters</button>
</div>

{
	/* Collapsible filter sidebar */
}
;<aside className={`${filterOpen ? 'block' : 'hidden'} md:block`}>{/* Filter content */}</aside>
```

---

## 📱 Image Optimization

### Responsive Images

```jsx
{
	/* Next.js Image with priority for LCP */
}
;<Image src='image.jpg?w=1200' alt='Description' fill priority className='object-cover' />

{
	/* Responsive image sizing */
}
;<Image src='image.jpg?w=800' alt='Description' width={800} height={600} className='w-full h-auto' />
```

**Best Practices**:

- Use Unsplash/CDN with query parameters: `?w=400&h=500&fit=crop`
- Always set `alt` text
- Use `fill` with container `relative` and proper aspect ratio
- Add `priority` to above-the-fold images

---

## 🎯 Touch-Friendly Design

### Minimum Touch Target Size

All interactive elements must be **at least 44x44px** (WCAG AA):

```jsx
{
	/* Touch-friendly button */
}
;<button className='w-10 h-10 min-h-[2.75rem] flex items-center justify-center'>Action</button>

{
	/* Touch-friendly link spacing */
}
;<nav className='flex gap-4'>
	{/* Each link has min 44px hit area */}
	<a href='#' className='px-4 py-2.5'>
		Link
	</a>
</nav>
```

### Spacing Between Elements

- **Buttons**: Minimum `gap-2 sm:gap-3` between buttons
- **List Items**: Minimum `py-2.5` or `py-3` vertical padding
- **Form Inputs**: `py-2.5 sm:py-3` with 16px font size (prevents iOS zoom)

---

## 🔍 Testing Responsive Design

### Breakpoint Testing Checklist

- [ ] **Mobile (320px)**: IPhone SE, older devices
- [ ] **Small Tablet (640px)**: Large phones in landscape
- [ ] **Tablet (768px)**: iPad, Galaxy Tab
- [ ] **Desktop (1024px)**: Standard laptop
- [ ] **Large Desktop (1280px+)**: Desktop monitors

### DevTools Testing

```
Chrome DevTools → Device Emulation → Select device preset
Or: Press Ctrl+Shift+M to toggle device mode
```

### Real Device Testing

Test on at least these devices:

- iPhone 12/13 mini (320px - 390px)
- iPhone 14 Plus (390px - 430px)
- iPad (768px - 820px)
- Desktop browser (1024px+)

---

## 🏃 Performance Considerations

### Mobile-First Performance Benefits

1. **Smaller CSS Payload**: Mobile styles are simpler
2. **Faster Initial Load**: Fewer styles to parse on mobile
3. **Progressive Enhancement**: Enhancements load as needed
4. **Better CWV**: Improved Core Web Vitals on mobile

### Optimization Tips

```jsx
{
	/* Use lazy loading for below-fold images */
}
;<Image src='image.jpg' alt='Description' loading='lazy' />

{
	/* Use responsive image sizes */
}
;<Image src='image.jpg?w=500' sizes='(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw' />
```

---

## 📋 Common Responsive Patterns

### Pattern 1: Sidebar Layout

```jsx
<div className='grid grid-cols-1 md:grid-cols-4 gap-6 md:gap-8'>
	<aside className='md:col-span-1'>{/* Sidebar on md+, full width on mobile */}</aside>
	<div className='md:col-span-3'>{/* Main content */}</div>
</div>
```

### Pattern 2: Card Grid

```jsx
<div className='grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-mobile'>
	{/* 1 column mobile, 2 columns tablet, 4 columns desktop */}
	{items.map((item) => (
		<Card key={item.id} item={item} />
	))}
</div>
```

### Pattern 3: Flex Stack

```jsx
<div className='flex flex-col sm:flex-row gap-4 sm:gap-6'>
	{/* Vertical stack on mobile, horizontal on sm+ */}
	<Item />
	<Item />
</div>
```

### Pattern 4: Collapsible Menu

```jsx
{
	/* Show toggle on mobile only */
}
;<button className='md:hidden' onClick={() => setOpen(!open)}>
	Menu
</button>

{
	/* Show menu inline on desktop */
}
;<nav className={`${open ? 'block' : 'hidden'} md:block`}>{/* Navigation items */}</nav>
```

---

## 🎓 Learning Resources

### Tailwind CSS Responsive Design

- [Tailwind Responsive Design Docs](https://tailwindcss.com/docs/responsive-design)

### Mobile-First Web Design

- [MDN: Responsive Design](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
- [Google: Mobile-First Indexing](https://developers.google.com/search/mobile-sites/mobile-first-indexing)

### Web Accessibility

- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM: Touch Target Sizing](https://webaim.org/articles/touchscreen/)

---

## ✅ Checklist for New Components

When creating new components, ensure:

- [ ] **Mobile-first styles** (no breakpoint modifier = mobile)
- [ ] **Progressive enhancement** (add breakpoints for larger screens)
- [ ] **Touch-friendly** (44x44px minimum tap targets)
- [ ] **Accessible** (semantic HTML, ARIA labels, keyboard nav)
- [ ] **Performant** (lazy load images, minimize CSS)
- [ ] **Tested** (check at least: 320px, 768px, 1024px)
- [ ] **Responsive typography** (scale headings across breakpoints)
- [ ] **Responsive spacing** (use `.py-mobile`, `.px-mobile`, `.gap-mobile`)

---

## 🔗 Related Documentation

- [Tailwind Configuration](../tailwind.config.js)
- [Global Styles](../src/styles/globals.css)
- [Component Library](../src/components)
- [Page Structure](../src/app)
