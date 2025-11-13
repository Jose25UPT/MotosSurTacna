"use client";

import { useState, useEffect, useRef } from 'react';
import React from 'react';
import Link from "next/link";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { getMotorcycles, getBrands, canonicalizeBrand } from "@/lib/data.service";
import FraudWarningDialog from '@/components/fraud-warning-dialog';
import type { Motorcycle, PromoImage } from '@/lib/types';
import MotorcycleCard from '@/components/motorcycle-card';
import { ArrowRight, Bike as MotorcycleIcon, Zap, Mountain, Building, Sparkles, AppWindow, GitCommitHorizontal, Search, Wrench, ShoppingBag, Tag } from 'lucide-react';
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel"
import Autoplay from "embla-carousel-autoplay"

type CategoryStyle = { name: string; href: string; images: string[]; desc: string; accent: 'primary' | 'blue' | 'violet' | 'orange' };

const categoryStyles: CategoryStyle[] = [
  {
    name: "Deportivas",
    href: "/catalog?estilo=deportivas",
    images: [
      "https://www.rezziomotocicletas.com.pe/assets/motos/galeria/6750c934c3a60-LITHIUM%20200%20ROJA%20ALTA%20CALIDAD.jpeg"
    ],
    desc: "Velocidad, aerodinámica y adrenalina pura en cada curva.",
    accent: 'violet',
  },
  {
    name: "Todoterreno",
    href: "/catalog?estilo=todoterreno",
    images: [
      "https://www.rezziomotocicletas.com.pe/assets/motos/galeria/675b38e3df0c7-PRIMEX%20250%20NARANJA%20ALTA%20CALIDAD.jpeg",
      "https://www.rezziomotocicletas.com.pe/assets/motos/especificaciones/primex-ALTA.png"
    ],
    desc: "Listas para la aventura: tierra, barro y cualquier terreno.",
    accent: 'orange',
  },
  {
    name: "Clásicas",
    href: "/catalog?estilo=clasicas",
    images: [
      "/assets/scrampler200radvance.png"
    ],
    desc: "Estética retro con el carácter atemporal del motociclismo.",
    accent: 'primary',
  },
  {
    name: "Pisteras",
    href: "/catalog?estilo=pisteras",
    images: [
      "/assets/aventus.png"
    ],
    desc: "Agilidad urbana y estilo para dominar el asfalto.",
    accent: 'blue',
  },
];

const services = [
  {
    name: "Mantenimiento",
    description: "Servicio técnico especializado para que tu moto esté siempre en las mejores condiciones.",
    icon: Wrench,
    href: "#",
    imageSrc: "https://topmotors.pe/wp-content/uploads/2024/12/mecanica_de_motos.jpg",
    imageHint: "motorcycle maintenance"
  },
  {
    name: "Venta de Motos",
    description: "El catálogo más completo de motos nuevas y seminuevas, con la mejor garantía.",
    icon: Tag,
    href: "/catalog",
    imageSrc: "/assets/primex.webp",
    imageHint: "motorcycle keys sale"
  },
  {
    name: "Accesorios",
    description: "Equipa tu moto y a ti mismo con los mejores accesorios del mercado.",
    icon: ShoppingBag,
    href: "/accesorios",
    imageSrc: "https://motos.honda.com.co/images/blogs/Accesorios-para-moto.jpg",
    imageHint: "motorcycle accessories"
  }
];

type BrandItem = { name: string; slug: string; logo: string; accent: 'primary' | 'blue' | 'violet' | 'orange' | 'emerald' };

const brandLogos: BrandItem[] = [
  { name: 'Advance', slug: 'advance', logo: '/assets/advance.png', accent: 'primary' },
  { name: 'B52', slug: 'b52', logo: '/assets/b52.png', accent: 'violet' },
  { name: 'Ultravip', slug: 'ultravip', logo: '/assets/ultravip.jpg', accent: 'blue' },
  { name: 'Duconda', slug: 'duconda', logo: '/assets/duconda.webp', accent: 'orange' },
  { name: 'JCH', slug: 'jch', logo: '/assets/jch.png', accent: 'emerald' },
  { name: 'Rezzio', slug: 'rezzio', logo: '/assets/rezzio.png', accent: 'violet' },
  { name: 'Sonlink', slug: 'sonlink', logo: '/assets/sonlink.webp', accent: 'primary' },
  { name: 'Wanxin', slug: 'wanxin', logo: '/assets/wanxin.jpg', accent: 'blue' },
  { name: 'Zontes', slug: 'zontes', logo: '/assets/zontes.jpg', accent: 'blue' },
  { name: 'Nami', slug: 'nami', logo: '/assets/nami.webp', accent: 'primary' },
];

// Resolve logo path for a brand name using known static list or heuristics
function slugifyName(name: string) {
  return name
    .toLowerCase()
    .replace(/\s+/g, '')
    .replace(/[^a-z0-9\-]/g, '');
}

function resolveBrandLogo(name: string): string {
  // Try to find in the static list first (case-insensitive)
  const found = brandLogos.find(b => b.name.toLowerCase() === name.toLowerCase());
  if (found) return found.logo;

  // Common extensions to try (we won't check existence at runtime; next/image will fallback to onError)
  const slug = slugifyName(name);
  const exts = ['.png', '.jpg', '.webp', '.svg'];
  for (const e of exts) {
    const path = `/assets/${slug}${e}`;
    // Return the first candidate; if it doesn't exist it'll fallback to initials in the card
    return path;
  }
  return '/assets/2.svg';
}


export default function Home() {
  const [featuredMotorcycles, setFeaturedMotorcycles] = useState<Motorcycle[]>([]);
  const [brands, setBrands] = useState<string[]>([]);
  const [showWarning, setShowWarning] = useState(false);
  
  useEffect(() => {
    const fetchData = async () => {
      try {
        // Obtener primera página (20) para selección aleatoria
        const [{ items, has_more, total }, brandData] = await Promise.all([
          getMotorcycles(1, 20),
          getBrands()
        ]);
        let pool = items;
        // Si hubiera menos de 4 en primera página (edge case), traer segunda
        if (pool.length < 4 && has_more) {
          const page2 = await getMotorcycles(2, 20);
            // evitar duplicados
          const ids = new Set(pool.map(m => m.id));
          pool = [...pool, ...page2.items.filter(m => !ids.has(m.id))];
        }
        function getRandomItems(arr: Motorcycle[], n: number): Motorcycle[] {
          const result = [...arr];
          for (let i = result.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [result[i], result[j]] = [result[j], result[i]];
          }
          return result.slice(0, n);
        }
  const randomMotorcycles = getRandomItems(pool, 4);
  setFeaturedMotorcycles(randomMotorcycles);
  // Normalizar todas las marcas y añadir las nuevas si faltan
  const normalizedBackend = (brandData || []).map(b => canonicalizeBrand(b).name);
  const extraBrands = ['Zontes', 'Nami'];
  const mergedBrands = Array.from(new Set([...normalizedBackend, ...extraBrands]));
  console.log('🗂 Marcas (normalizadas+extras):', mergedBrands);
  setBrands(mergedBrands);
      } catch (e) {
        console.error('Error cargando destacados:', e);
      }
    };
    fetchData();

    const hasSeenWarning = sessionStorage.getItem('hasSeenFraudWarning');
    if (!hasSeenWarning) {
      setShowWarning(true);
      sessionStorage.setItem('hasSeenFraudWarning', 'true');
    }
  }, []);


  
  return (
    <>
      <FraudWarningDialog open={showWarning} onOpenChange={setShowWarning} />

      <section className="relative h-[calc(100vh-80px)] w-full flex items-center justify-center overflow-hidden">
        {/* Imagen hero local */}
        <div className="absolute w-full h-full inset-0">
          <img
            src="/assets/portada.jpg"
            alt="Hero Motossur principal"
            className="object-cover w-full h-full brightness-[0.3] scale-105"
          />
          {/* Overlay gradient mejorado */}
          <div className="absolute inset-0 bg-gradient-to-r from-black/60 via-transparent to-black/40"></div>
          <div className="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-black/30"></div>
        </div>
        
        {/* Contenido principal */}
        <div className="relative z-20 text-center text-white p-4 max-w-5xl mx-auto">
            <div className="mb-6">
              <span className="inline-block bg-primary/20 text-primary-foreground px-6 py-2 rounded-full text-sm font-medium border border-primary/30 backdrop-blur-sm">
                MOTOS SUR TACNA
              </span>
            </div>
            <h1 className="text-4xl md:text-6xl lg:text-7xl xl:text-8xl font-headline uppercase tracking-widest text-shadow-2xl animate-fade-in-down leading-tight">
                <span className="block text-yellow-400 drop-shadow-2xl">POTENCIA</span>
                <span className="block text-white drop-shadow-2xl">SIN LÍMITES</span>
            </h1>
            <p className="mt-6 text-lg md:text-xl lg:text-2xl max-w-3xl mx-auto text-neutral-100 animate-fade-in-up font-light leading-relaxed">
                Descubre los modelos que dominarán la calle con la mejor tecnología y diseño
            </p>
            <div className="mt-10 flex flex-col sm:flex-row gap-4 justify-center items-center">
              <Button asChild size="lg" className="text-lg px-8 py-4 animate-fade-in-up bg-primary hover:bg-primary/90 shadow-2xl">
                  <Link href="/catalog">
                      Ver Catálogo Completo
                      <ArrowRight className="ml-2 h-5 w-5" />
                  </Link>
              </Button>
              <Button
                asChild
                size="lg"
                variant="outline"
                className="text-lg px-8 py-4 animate-fade-in-up bg-black/40 hover:bg-black/60 text-white hover:text-white border-white/40 backdrop-blur-sm shadow-lg"
              >
                  <Link href="/tiendas">
                      Nuestras Tiendas
                  </Link>
              </Button>
            </div>
        </div>
        
        {/* Elementos decorativos */}
        <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce">
          <div className="w-6 h-10 border-2 border-white/50 rounded-full flex justify-center">
            <div className="w-1 h-3 bg-white/70 rounded-full mt-2 animate-pulse"></div>
          </div>
        </div>
      </section>

  <section className="bg-gradient-to-b from-background to-secondary/30 pb-12 md:pb-16 pt-20 md:pt-24">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="font-headline uppercase tracking-[0.2em] text-4xl md:text-6xl lg:text-7xl font-extrabold bg-gradient-to-r from-primary via-blue-600 to-purple-600 bg-clip-text text-transparent drop-shadow-2xl">
              Explora tu Estilo
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12 max-w-7xl mx-auto px-4">
            {categoryStyles.map((category) => (
              <CategoryCard key={category.name} category={category} />
            ))}
          </div>
        </div>
      </section>
      


  <section className="relative bg-gradient-to-b from-background via-secondary/5 to-secondary/10 py-16 md:py-24 overflow-hidden">
        {/* Decoración de fondo */}
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_20%,rgba(251,191,36,0.05),transparent_50%),radial-gradient(circle_at_70%_60%,rgba(59,130,246,0.05),transparent_50%)]" />
        
        <div className="container mx-auto px-4 relative z-10">
          {/* Header mejorado */}
          <div className="text-center mb-16">
            <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-gradient-to-br from-primary/20 to-primary/5 mb-6 ring-4 ring-primary/10">
              <Search className="h-8 w-8 text-primary" />
            </div>
            <h2 className="text-4xl md:text-5xl lg:text-6xl font-headline uppercase tracking-wider bg-gradient-to-r from-foreground via-foreground/90 to-foreground/80 bg-clip-text text-transparent mb-4">
              Busca tu Moto por Marca
            </h2>
            <div className="w-24 h-1 bg-gradient-to-r from-transparent via-primary to-transparent mx-auto mb-6" />
          </div>

          {/* Carrusel de marcas */}
          <div className="relative max-w-6xl mx-auto">
            <Carousel
              opts={{ align: "start", loop: true }}
              plugins={[Autoplay({ delay: 3800, stopOnInteraction: false, stopOnMouseEnter: true })]}
              className="w-full"
            >
              <CarouselContent>
                {(brands && brands.length ? brands.map((bName) => {
                  const raw = typeof bName === 'string' ? bName : (bName as any).brand || String(bName);
                  const { name } = canonicalizeBrand(raw);
                  const slug = slugifyName(name);
                  const logo = resolveBrandLogo(name);
                  if (!logo) {
                    console.log('⚠️ Logo no resuelto para', name);
                  }
                  return { name, slug, logo, accent: 'primary' } as BrandItem;
                }) : brandLogos).map((brand) => (
                  <CarouselItem key={brand.slug || brand.name} className="basis-1/2 sm:basis-1/3 lg:basis-1/4 xl:basis-1/5">
                    <BrandLogoCard brand={brand} variant={3} />
                  </CarouselItem>
                ))}
              </CarouselContent>
              <CarouselPrevious className="hidden sm:flex -left-6 md:-left-10" />
              <CarouselNext className="hidden sm:flex -right-6 md:-right-10" />
            </Carousel>
          </div>
        </div>
      </section>

      <section className="bg-background py-16 md:py-24">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold tracking-tight">Nuestros Servicios</h2>
            <p className="mt-4 text-lg text-muted-foreground max-w-2xl mx-auto">
              Todo lo que necesitas para tu pasión por las dos ruedas.
            </p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {services.map((service) => (
              <Link key={service.name} href={service.href} className="group">
                <div className="relative overflow-hidden rounded-lg shadow-lg h-64 flex flex-col justify-end text-white text-center transition-transform duration-300 group-hover:scale-105">
                  <Image 
                    src={service.imageSrc}
                    alt={service.name}
                    fill
                    className="object-cover brightness-50"
                    data-ai-hint={service.imageHint}
                  />
                  <div className="relative z-10 p-6 bg-gradient-to-t from-black/80 to-transparent">
                    <div className="bg-primary/20 p-4 rounded-full mb-4 inline-block border-2 border-primary/50">
                        <service.icon className="h-8 w-8 text-primary"/>
                    </div>
                    <h3 className="text-2xl font-headline tracking-wider">{service.name}</h3>
                    <p className="text-white/80 mt-2 text-sm">{service.description}</p>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {featuredMotorcycles.length > 0 && (
        <section className="bg-secondary/50 py-16 md:py-24">
          <div className="container mx-auto px-2 sm:px-4">
            <div className="text-center mb-12">
               <MotorcycleIcon className="mx-auto h-12 w-12 text-primary mb-4" />
               <h2 className="text-3xl md:text-4xl font-bold tracking-tight">Modelos Destacados</h2>
               <p className="mt-4 text-lg text-muted-foreground max-w-2xl mx-auto">
                Una selección de nuestras motos más populares. Encuentra la tuya.
               </p>
            </div>
            <div className="relative">
              <Carousel
                opts={{ align: "start", loop: true }}
                plugins={[Autoplay({ delay: 4200, stopOnInteraction: false, stopOnMouseEnter: true })]}
                className="w-full"
              >
                <CarouselContent>
                  {featuredMotorcycles.map((motorcycle) => (
                    <CarouselItem key={motorcycle.id} className="basis-[85%] sm:basis-1/2 lg:basis-1/3">
                      <MotorcycleCard motorcycle={motorcycle} largeWidth />
                    </CarouselItem>
                  ))}
                </CarouselContent>
                <CarouselPrevious className="hidden sm:flex -left-4 md:-left-10" />
                <CarouselNext className="hidden sm:flex -right-4 md:-right-10" />
              </Carousel>
            </div>
            <div className="text-center mt-12">
                <Button
                  asChild
                  size="lg"
                  className="relative overflow-hidden rounded-full px-8 py-4 text-base font-semibold text-black border-0 bg-gradient-to-r from-yellow-400 to-amber-500 hover:from-yellow-500 hover:to-amber-600 shadow-[0_8px_30px_rgba(251,191,36,0.35)] focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-yellow-500 focus-visible:ring-offset-secondary/50 transition-all duration-300"
                >
                  <Link href="/catalog" className="relative z-10 inline-flex items-center">
                    Ver todo el Catálogo
                    <ArrowRight className="ml-2"/>
                  </Link>
                </Button>
                {/* Efecto shine */}
                <style jsx>{`
                  .relative.overflow-hidden.rounded-full::before {
                    content: "";
                    position: absolute;
                    inset: -20%;
                    background: linear-gradient(120deg, transparent 0%, rgba(255,255,255,0.6) 40%, transparent 80%);
                    transform: translateX(-120%) skewX(-20deg);
                    transition: transform 0.7s ease;
                  }
                  .relative.overflow-hidden.rounded-full:hover::before {
                    transform: translateX(120%) skewX(-20deg);
                  }
                `}</style>
            </div>
          </div>
        </section>
      )}
    </>
  );
}

function CategoryCard({ category }: { category: CategoryStyle }) {
  const [current, setCurrent] = React.useState(0);
  React.useEffect(() => {
    if (category.images.length < 2) return;
    const interval = setInterval(() => {
      setCurrent((prev) => (prev + 1) % category.images.length);
    }, 10000);
    return () => clearInterval(interval);
  }, [category.images.length]);
  // Acentos de borde según categoría
  const borderClass = category.accent === 'primary'
    ? 'from-primary via-primary/70 to-primary/40'
    : category.accent === 'blue'
      ? 'from-blue-500 via-blue-400 to-blue-300'
      : category.accent === 'violet'
        ? 'from-fuchsia-500 via-violet-500 to-indigo-500'
        : 'from-orange-500 via-amber-500 to-yellow-400';
  
  return (
    <Link href={category.href} className="group block">
      {/* Borde con gradiente y brillo sutil */}
      <div className={`relative rounded-3xl p-[2px] bg-gradient-to-r ${borderClass} shadow-[0_10px_40px_-20px_rgba(0,0,0,0.6)] transition-transform duration-500 group-hover:scale-[1.02]`}>
        <div className="relative overflow-hidden rounded-[calc(1.5rem-2px)] aspect-[4/3] h-full min-h-[240px] md:min-h-[320px] lg:min-h-[380px] xl:min-h-[420px] 2xl:min-h-[460px] bg-black/70">
          {/* Fondo sólido de respaldo */}
          <div className="absolute inset-0 bg-gradient-to-br from-gray-900 via-gray-800 to-black" />

          {/* Imagen */}
          <Image
            src={category.images[current]}
            alt={`Moto de estilo ${category.name}`}
            fill
            className="object-cover brightness-[0.75] transition-all duration-700 group-hover:brightness-[0.9] group-hover:scale-110"
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
            onError={(e) => {
              const target = e.target as HTMLImageElement;
              target.style.display = 'none';
            }}
          />

          {/* Veladura y gradiente para texto */}
          <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent" />

          {/* Chip superior izquierdo */}
          <div className="absolute top-4 left-4 z-10">
            <span className="text-[11px] uppercase tracking-widest px-3 py-1 rounded-full bg-white/10 text-white/90 border border-white/15 backdrop-blur-md">Estilo</span>
          </div>

          {/* Contenido inferior */}
          <div className="absolute inset-0 flex flex-col items-center justify-end p-6 md:p-8 lg:p-10 text-center">
            <div className="transition-all duration-500 group-hover:translate-y-[-6px]">
              <h3 className="font-headline text-3xl md:text-4xl lg:text-5xl font-bold uppercase tracking-wider text-white drop-shadow-2xl leading-tight">
                {category.name}
              </h3>
              <p className="mt-3 text-white/80 text-sm md:text-base max-w-xl mx-auto leading-relaxed">
                {category.desc}
              </p>
              <div className="mt-5">
                <span className="inline-flex items-center gap-2 bg-white/90 text-gray-900 px-4 py-2 rounded-full text-sm font-semibold shadow-md hover:shadow-lg transition-shadow border border-white">
                  Explorar modelos
                  <ArrowRight className="w-4 h-4" />
                </span>
              </div>
            </div>
          </div>

          {/* Brillo animado en hover */}
          <div className="pointer-events-none absolute inset-0 opacity-0 group-hover:opacity-20 transition-opacity duration-500">
            <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent -skew-x-12 translate-x-[-100%] group-hover:translate-x-[200%] transition-transform [animation-duration:1200ms]" />
          </div>
        </div>
      </div>
    </Link>
  );
}

function BrandLogoCard({ brand, variant = 7 }: { brand: BrandItem; variant?: 1 | 2 | 3 | 4 | 5 | 6 | 7 }) {
  const initials = brand.name
    .split(' ')
    .map((w) => w[0])
    .join('')
    .slice(0, 3)
    .toUpperCase();

  const cardRef = useRef<HTMLDivElement | null>(null);
  const [imgOk, setImgOk] = useState(true);
  const [logoSrc, setLogoSrc] = useState(brand.logo);
  const imgRef = useRef<HTMLImageElement | null>(null);
  const [isLightLogo, setIsLightLogo] = useState(false);
  function handleImgError(e: React.SyntheticEvent<HTMLImageElement>) {
    const el = e.currentTarget;
    if (!el.src.includes('/assets/2.svg')) {
      el.src = '/assets/2.svg';
    }
    setImgOk(false);
  }
  const [isHovered, setIsHovered] = useState(false);

  // Detectar si el logo es demasiado claro (mayoritariamente blanco) para darle contorno / invertir.
  useEffect(() => {
    const img = imgRef.current;
    if (!img) return;
    if (!img.complete) {
      img.onload = () => {
        tryDetectLightness(img);
      };
      return;
    }
    tryDetectLightness(img);
  }, [logoSrc]);

  function tryDetectLightness(img: HTMLImageElement) {
    try {
      const canvas = document.createElement('canvas');
      canvas.width = img.naturalWidth;
      canvas.height = img.naturalHeight;
      const ctx = canvas.getContext('2d');
      if (!ctx) return;
      ctx.drawImage(img, 0, 0);
      const { data } = ctx.getImageData(0, 0, canvas.width, canvas.height);
      let lightPixels = 0;
      let total = 0;
      for (let i = 0; i < data.length; i += 4) {
        const r = data[i];
        const g = data[i + 1];
        const b = data[i + 2];
        const a = data[i + 3];
        if (a < 50) continue; // ignorar transparente
        total++;
        const lum = (0.299 * r + 0.587 * g + 0.114 * b);
        if (lum > 230) lightPixels++; // muy claro
      }
      if (total > 50) {
        const ratio = lightPixels / total;
        setIsLightLogo(ratio > 0.55); // si más del 55% es blanco muy claro
      }
    } catch {
      /* silencioso */
    }
  }

  return (
    <Link
      href={`/catalog?brand=${encodeURIComponent((brand as any).slug || brand.name)}`}
      className="group w-full focus:outline-none focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2 rounded-3xl transition-all duration-500"
      aria-label={`Ver modelos de ${brand.name}`}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
  {/* Marco exterior oscuro y discreto: violeta profundo → azul marino */}
  <div className="rounded-3xl p-[4px] bg-gradient-to-br from-[#4c1d95] to-[#1e3a8a] hover:from-[#5b21b6] hover:to-[#1e40af] transition-colors duration-300 shadow-sm">
    <div className="rounded-[calc(1.5rem-4px)] bg-white dark:bg-neutral-900 flex flex-col items-center gap-4 p-1">
        {/* Card minimalista (sin efectos): borde fino y fondo limpio */}
  <div className="relative w-32 h-44 md:w-36 md:h-52 lg:w-40 lg:h-56 flex items-center justify-center rounded-2xl overflow-hidden group bg-white dark:bg-neutral-900 shadow-sm transition-shadow duration-300 hover:shadow-lg">
          {/* Logo / fallback */}
          {imgOk ? (
            <Image
              src={brand.logo}
              alt={`${brand.name} logo`}
              width={200}
              height={200}
              className="relative z-10 object-contain max-w-[82%] max-h-[82%] transition-transform duration-500 group-hover:scale-105"
              onError={() => setImgOk(false) as any}
              unoptimized
            />
          ) : (
            <span className="relative z-10 text-xl font-semibold tracking-wide bg-gradient-to-br from-yellow-400 to-amber-500 bg-clip-text text-transparent">
              {initials}
            </span>
          )}
          {/* Sin capas extra ni animaciones */}
        </div>
          {/* Chips variantes 1-7 para evaluación */}
          <div className="w-full flex justify-center -mt-1">
            {variant === 1 && (
              <span className="inline-flex items-center gap-2 px-4 py-2 rounded-[12px] text-xs sm:text-sm font-semibold uppercase tracking-wider text-white bg-gradient-to-r from-fuchsia-600 to-blue-600 shadow-sm hover:shadow-md hover:brightness-110">
                {brand.name}
                <ArrowRight className="w-3.5 h-3.5 text-white/90" />
              </span>
            )}
            {variant === 2 && (
              <span className="inline-flex items-center gap-2 px-4 py-2 rounded-[12px] text-xs sm:text-sm font-semibold uppercase tracking-wider text-white/95 bg-gradient-to-r from-fuchsia-700/50 to-blue-700/50 backdrop-blur-md border border-white/15 shadow-sm hover:border-white/25">
                {brand.name}
                <ArrowRight className="w-3.5 h-3.5 text-white/90" />
              </span>
            )}
            {variant === 3 && (
              <span className="inline-flex items-center gap-2 px-4 py-2 rounded-[12px] text-xs sm:text-sm font-semibold uppercase tracking-wider text-white bg-[#1f2a44] border border-[#2a3552] shadow-sm hover:bg-[#233052]">
                {brand.name}
                <ArrowRight className="w-3.5 h-3.5 text-white/90" />
              </span>
            )}
            {variant === 4 && (
              <span className="relative inline-flex items-center gap-2 px-4 py-2 rounded-[12px] text-xs sm:text-sm font-semibold uppercase tracking-wider border border-neutral-300 bg-white/90 text-neutral-800">
                {brand.name}
                <ArrowRight className="w-3.5 h-3.5 text-neutral-600" />
                <span className="pointer-events-none absolute left-4 right-4 bottom-1 h-0.5 bg-gradient-to-r from-fuchsia-600 to-blue-600" />
              </span>
            )}
            {variant === 5 && (
              <span className="inline-flex items-center gap-2 px-5 py-2.5 rounded-[12px] text-xs sm:text-sm font-medium uppercase tracking-wider border border-neutral-300 bg-white/85 dark:bg-neutral-900/80 backdrop-blur-sm shadow-sm transition-all duration-300 transform group-hover:scale-[1.02] hover:border-neutral-400">
                <span className="text-foreground/80 group-hover:text-foreground transition-colors duration-300">{brand.name}</span>
                <ArrowRight className="w-4 h-4 text-neutral-500 group-hover:translate-x-0.5 transition-transform duration-300" />
              </span>
            )}
            {variant === 6 && (
              <span className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm font-medium border border-neutral-300/70 bg-white dark:bg-neutral-900 text-foreground/85 transition-all duration-300 hover:border-neutral-400">
                {brand.name}
                <ArrowRight className="w-4 h-4 text-neutral-500/80" />
              </span>
            )}
            {variant === 7 && (
              <span className="inline-flex items-center gap-2 px-4 py-2 rounded-[12px] text-xs sm:text-sm font-medium uppercase tracking-wider border border-neutral-300 text-neutral-700 bg-white/85 dark:bg-neutral-900/80 transition-all duration-300 hover:translate-x-[1px]">
                {brand.name}
                <ArrowRight className="w-3.5 h-3.5 text-neutral-600" />
              </span>
            )}
          </div>
        </div>
      </div>
      </Link>
  );
}
