#!/bin/bash

# Check if a project name was provided
if [ -z "$1" ]; then
    echo "Please provide a project name"
    echo "Usage: ./setup.sh <project-name>"
    exit 1
fi

PROJECT_NAME=$1

# Create Next.js app with specified configuration
echo "Creating Next.js app: $PROJECT_NAME"
NEXT_TELEMETRY_DISABLED=1 pnpm create next-app@latest $PROJECT_NAME \
    --typescript \
    --eslint \
    --tailwind \
    --src-dir \
    --app \
    --no-turbo \
    --import-alias "@/*" \
    --use-pnpm \
    --no-experimental \
    -y

# Navigate into project directory
cd $PROJECT_NAME || exit 1

# Run shadcn init with defaults
echo "Initializing shadcn-ui..."
pnpm dlx shadcn@latest init -d

# Install all shadcn components
echo "Installing shadcn components..."
pnpm dlx shadcn@latest add \
    accordion \
    alert \
    alert-dialog \
    aspect-ratio \
    avatar \
    badge \
    breadcrumb \
    button \
    calendar \
    card \
    carousel \
    chart \
    checkbox \
    collapsible \
    command \
    context-menu \
    dialog \
    drawer \
    dropdown-menu \
    form \
    hover-card \
    input \
    input-otp \
    label \
    menubar \
    navigation-menu \
    pagination \
    popover \
    progress \
    radio-group \
    resizable \
    scroll-area \
    select \
    separator \
    sheet \
    sidebar \
    skeleton \
    slider \
    sonner \
    switch \
    table \
    tabs \
    textarea \
    toast \
    toggle \
    toggle-group \
    tooltip \
    --yes

# Install next-themes and its peer dependencies
echo "Installing next-themes and required peer dependencies..."
pnpm install next-themes date-fns@^3.0.0

# Create theme provider file
echo "Creating theme provider..."
mkdir -p src/app
cat > src/app/theme-provider.tsx << 'EOL'
"use client"

import * as React from "react"
import { ThemeProvider as NextThemesProvider } from "next-themes"
import { type ThemeProviderProps } from "next-themes/dist/types"

export function ThemeProvider({ children, ...props }: ThemeProviderProps) {
  return <NextThemesProvider {...props}>{children}</NextThemesProvider>
}
EOL

# Create theme toggle component
echo "Creating theme toggle..."
cat > src/app/theme-toggle.tsx << 'EOL'
"use client"

import * as React from "react"
import { Moon, Sun } from "lucide-react"
import { useTheme } from "next-themes"
import { Button } from "@/components/ui/button"

export function ThemeToggle() {
  const { theme, setTheme } = useTheme()

  return (
    <Button
      variant="outline"
      size="icon"
      onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
    >
      <Sun className="h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0" />
      <Moon className="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100" />
      <span className="sr-only">Toggle theme</span>
    </Button>
  )
}
EOL

# Create Nav component with dynamic project name
echo "Creating Nav component..."
mkdir -p src/components
cat > src/components/nav.tsx << EOL
"use client"

import { ThemeToggle } from "@/app/theme-toggle"

export function Nav() {
  return (
    <div className="border-b">
      <div className="flex h-16 items-center px-4 container mx-auto justify-between">
        <div className="font-bold text-2xl">
          $PROJECT_NAME
        </div>
        <ThemeToggle />
      </div>
    </div>
  )
}
EOL

# Update layout.tsx to include ThemeProvider and Nav
echo "Creating layout.tsx..."
cat > src/app/layout.tsx << EOL
import type { Metadata } from "next"
import { Bitter } from "next/font/google"
import "./globals.css"
import { ThemeProvider } from "@/app/theme-provider"
import { Nav } from "@/components/nav"

const bitter = Bitter({ subsets: ["latin"] })

export const metadata: Metadata = {
  title: "$PROJECT_NAME",
  description: "Created with Next.js",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={bitter.className}>
        <ThemeProvider
          attribute="class"
          defaultTheme="light"
          enableSystem={false}
          disableTransitionOnChange
        >
          <Nav />
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}
EOL

# Update page.tsx with Button only
echo "Creating page.tsx..."
cat > src/app/page.tsx << 'EOL'
"use client"

import { Button } from "@/components/ui/button"

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-4">
      <Button className="bg-yellow-500 hover:bg-yellow-600">Hello</Button>
    </main>
  )
}
EOL

# Update tailwind.config.ts to use Bitter font
echo "Updating tailwind config..."
cat > tailwind.config.ts << 'EOL'
import type { Config } from "tailwindcss"
const { fontFamily } = require("tailwindcss/defaultTheme")

const config = {
  darkMode: ["class"],
  content: [
    './pages/**/*.{ts,tsx}',
    './components/**/*.{ts,tsx}',
    './app/**/*.{ts,tsx}',
    './src/**/*.{ts,tsx}',
  ],
  prefix: "",
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      fontFamily: {
        sans: ["var(--font-bitter)", ...fontFamily.sans],
      },
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
} satisfies Config

export default config
EOL

# Success message
echo "✨ Setup complete for $PROJECT_NAME!"
echo "To get started:"
echo "cd $PROJECT_NAME"
echo "pnpm dev"
