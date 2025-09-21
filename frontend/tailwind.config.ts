import type {Config} from 'tailwindcss';

export default {
  darkMode: ['class'],
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        body: ['Roboto', 'sans-serif'],
        headline: ['Bebas Neue', 'sans-serif'],
        code: ['monospace'],
      },
      colors: {
        background: '#FFFFFF', // Fondo principal blanco
        foreground: '#000000', // Texto y detalles oscuros
        primary: {
          DEFAULT: '#FFD700', // Amarillo racing (acento principal)
          foreground: '#000000',
        },
        card: {
          DEFAULT: '#FFFFFF',
          foreground: '#000000',
        },
        accent: {
          DEFAULT: '#FFD700',
          foreground: '#000000',
        },
        border: '#FFD700',
        input: '#FFD700',
        ring: '#FFD700',
        sidebar: {
          DEFAULT: '#FFFFFF',
          foreground: '#000000',
          primary: '#FFD700',
          'primary-foreground': '#000000',
          accent: '#FFD700',
          'accent-foreground': '#000000',
          border: '#FFD700',
          ring: '#FFD700',
        },
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
      },
      keyframes: {
        'accordion-down': {
          from: {
            height: '0',
          },
          to: {
            height: 'var(--radix-accordion-content-height)',
          },
        },
        'accordion-up': {
          from: {
            height: 'var(--radix-accordion-content-height)',
          },
          to: {
            height: '0',
          },
        },
        'fade-in-down': {
          '0%': { opacity: '0', transform: 'translateY(-20px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        'fade-in-up': {
          '0%': { opacity: '0', transform: 'translateY(20px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
      animation: {
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
        'fade-in-down': 'fade-in-down 0.5s ease-out 0.2s forwards',
        'fade-in-up': 'fade-in-up 0.5s ease-out 0.4s forwards',
      },
    },
  },
  plugins: [require('tailwindcss-animate')],
} satisfies Config;
