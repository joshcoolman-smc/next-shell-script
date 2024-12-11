# Next.js Project Setup Script

This shell script automates the setup of a Next.js project with a comprehensive set of modern features and UI components.

## Features

- ✨ Next.js 14 with App Router
- 🔷 TypeScript support
- 🎨 TailwindCSS for styling
- 📦 shadcn/ui component library (all components pre-installed)
- 🌓 Dark mode support with next-themes
- 📁 Organized src directory structure
- 🔍 ESLint configuration
- 📝 Custom Nav component with theme toggle
- 🔤 Bitter font from Google Fonts

## Prerequisites

- [pnpm](https://pnpm.io/) package manager installed on your system

## Usage

1. Make the script executable:
```bash
chmod +x setup.sh
```

2. Run the script with your project name:
```bash
./setup.sh my-project-name
```

3. Once setup is complete, navigate to your project and start the development server:
```bash
cd my-project-name
pnpm dev
```

## What's Included

The script automatically sets up:

### UI Components
All shadcn/ui components are pre-installed, including:
- Accordion
- Alert & Alert Dialog
- Avatar
- Button
- Calendar
- Card
- Carousel
- Form components
- Modal/Dialog
- Navigation components
- And many more!

### Theme Support
- Light/Dark mode toggle
- Custom theme provider setup
- Persistent theme selection

### Project Structure
- Organized src directory
- Pre-configured layout with navigation
- TypeScript and ESLint setup
- TailwindCSS configuration with animations

## Customization

After setup, you can:
- Modify the theme in `src/app/theme-provider.tsx`
- Customize the navigation in `src/components/nav.tsx`
- Update the layout in `src/app/layout.tsx`
- Add or remove components as needed

## Note

The script uses the following configurations:
- TypeScript for type safety
- ESLint for code quality
- TailwindCSS for styling
- App Router architecture
- src directory structure
- Custom import aliases
