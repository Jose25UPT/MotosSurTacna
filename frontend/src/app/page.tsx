"use client";

import { useState, useEffect, useRef } from 'react';
import React from 'react';
import Link from "next/link";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { getMotorcycles, getBrands } from "@/lib/data.service";
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
    imageSrc: "https://www.amv.es/blog/wp-content/uploads/2024/11/perdida-llaves-moto.jpeg",
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

const brandLogos = [
    { name: "Hero", logo: "https://w7.pngwing.com/pngs/75/368/png-transparent-hero-motocorp-honda-logo-motorcycle-business-motorcycle-angle-text-logo-thumbnail.png" },
    { name: "Lifan", logo: "https://1000marcas.net/wp-content/uploads/2020/10/Lifan-logo.png" },
    { name: "Ronco", logo: "https://flux.somosmoto.pe/r/https://somosmoto.pe/images/makes/logos/387fd44331d3a68a13c140375eb44227.png?width=294" },
    { name: "Sonlink", logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjedk18pfeIGYubnQzoLKSH6P3ehPHd8PwVg&s" },
    { name: "Ssenda", logo: "https://cdn.store.link/products/peruteammotors/fvawy7-ssenda.webp?versionId=ekexYYXbbM6X2cc.WXj_4nJEbMxFBDI3" },
    { name: "TVS", logo: "https://e7.pngegg.com/pngimages/13/541/png-clipart-car-tvs-motor-company-scooter-motorcycle-bajaj-auto-car-company-text-thumbnail.png" },
    { name: "Wanxin", logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9tr9RLlGruckJZBAayUFECxQsrZsHqsmMqw&s" }
];


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
        setBrands(brandData);
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
              <Button asChild size="lg" variant="outline" className="text-lg px-8 py-4 animate-fade-in-up border-white/30 text-white hover:bg-white/10 backdrop-blur-sm">
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
            <div className="inline-block mb-4">
              <Mountain className="mx-auto h-12 w-12 text-primary mb-4" />
            </div>
            <h2 className="text-4xl md:text-5xl lg:text-6xl font-bold tracking-tight bg-gradient-to-r from-primary via-blue-600 to-purple-600 bg-clip-text text-transparent">
              Explora por Estilo
            </h2>
            <p className="mt-6 text-lg md:text-xl text-muted-foreground max-w-3xl mx-auto leading-relaxed">
              Encuentra la moto que se adapta perfectamente a tu forma de vida y aventuras.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12 max-w-7xl mx-auto px-4">
            {categoryStyles.map((category) => (
              <CategoryCard key={category.name} category={category} />
            ))}
          </div>
        </div>
      </section>
      


  <section className="bg-secondary/10 pt-6 md:pt-8 pb-12 md:pb-12">
        <div className="container mx-auto px-2">
          <div className="text-center mb-10">
            <Search className="mx-auto h-12 w-12 text-primary mb-4" />
            <h2 className="text-3xl md:text-4xl font-bold tracking-tight">Busca tu Moto por Marca</h2>
            <p className="mt-4 text-lg text-muted-foreground max-w-2xl mx-auto">
              Las mejores marcas del mercado en un solo lugar.
            </p>
          </div>
          <div className="flex flex-wrap justify-center items-center gap-4">
            {brandLogos.map((brand) => (
              <Link key={brand.name} href={`/catalog?brand=${brand.name}`} className="group">
                <Card className="h-28 w-40 flex flex-col items-center justify-center p-2 transition-all duration-300 hover:border-primary hover:shadow-lg hover:-translate-y-1">
                   <div className="relative flex-grow w-full h-16">
                      <Image 
                        src={brand.logo}
                        alt={`${brand.name} logo`}
                        fill
                        sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
                        className="object-contain"
                      />
                   </div>
                   <p className="text-sm font-medium text-muted-foreground group-hover:text-foreground transition-colors mt-2">{brand.name}</p>
                </Card>
              </Link>
            ))}
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
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
              {featuredMotorcycles.map(motorcycle => (
                <MotorcycleCard key={motorcycle.id} motorcycle={motorcycle} largeWidth />
              ))}
            </div>
            <div className="text-center mt-12">
                <Button asChild size="lg" variant="outline">
                    <Link href="/catalog">
                        Ver todo el Catálogo
                        <ArrowRight className="ml-2"/>
                    </Link>
                </Button>
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
            <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent -skew-x-12 translate-x-[-100%] group-hover:translate-x-[200%] transition-transform duration-[1200ms]" />
          </div>
        </div>
      </div>
    </Link>
  );
}
