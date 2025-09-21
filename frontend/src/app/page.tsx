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

const categoryStyles = [
  {
    name: "Deportivas",
    href: "/catalog?estilo=deportivas",
    images: [
      "https://www.rezziomotocicletas.com.pe/assets/motos/galeria/6750c934c3a60-LITHIUM%20200%20ROJA%20ALTA%20CALIDAD.jpeg"
    ]
  },
  {
    name: "Todoterreno",
    href: "/catalog?estilo=todoterreno",
    images: [
      "https://www.rezziomotocicletas.com.pe/assets/motos/galeria/675b38e3df0c7-PRIMEX%20250%20NARANJA%20ALTA%20CALIDAD.jpeg",
      "https://www.rezziomotocicletas.com.pe/assets/motos/especificaciones/primex-ALTA.png"
    ]
  },
  {
    name: "Clásicas",
    href: "/catalog?estilo=clasicas",
    images: [
      "https://flux.somosmoto.pe/r/https://somosmoto.pe/images/models/gallery/jch-indian-250-2024-gallery-411fd5.jpg?height=522",
      "https://static.wixstatic.com/media/8bdcd6_41ffbe9998ea41948f92d03a4c285c16~mv2.jpg/v1/fill/w_938,h_601,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/8bdcd6_41ffbe9998ea41948f92d03a4c285c16~mv2.jpg"
    ]
  },
  {
    name: "Pisteras",
    href: "/catalog?estilo=pisteras",
    images: [
      "https://bm3motos.com/ArchivosBm3/imagenes/productos/3128/7b321e70ba84462c8bb208b2346d793e.png"
    ]
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
      const [allMotorcycles, brandData] = await Promise.all([
        getMotorcycles(),
        getBrands()
      ]);

      // Seleccionar 4 motos completamente aleatorias
      function getRandomItems(arr: Motorcycle[], n: number): Motorcycle[] {
        const result = [...arr];
        for (let i = result.length - 1; i > 0; i--) {
          const j = Math.floor(Math.random() * (i + 1));
          [result[i], result[j]] = [result[j], result[i]];
        }
        return result.slice(0, n);
      }
      const randomMotorcycles: Motorcycle[] = getRandomItems(allMotorcycles, 4);

      setFeaturedMotorcycles(randomMotorcycles); 
      setBrands(brandData);
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

      <section className="relative h-[calc(100vh-80px)] w-full flex items-center justify-center">
        {/* Imagen hero fija de Facebook */}
        <div className="absolute w-full h-full inset-0">
          <Image
            src="https://scontent.flim2-1.fna.fbcdn.net/v/t39.30808-6/487692578_1105013185003786_3339753605493780961_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGDhkZzu89jRh8ksEm0Iga3NP3YzVA_Z1I0_djNUD9nUn431xXj1I1CLYoootm-DxPLt5-v2cnDtLqZFYm9zKBL&_nc_ohc=dYT9j0doY0MQ7kNvwESrhyc&_nc_oc=AdmdQWZsFuBk4G5D5JRTSKs4ZTQCrpdy86u-1vpfOMwkvmb40j5dzHoVz4-qMQ1USHqQegVzlD7Or6zGqeUh5PYH&_nc_zt=23&_nc_ht=scontent.flim2-1.fna&_nc_gid=oKuQLe9l18OMjb90lbsirg&oh=00_AfW4uf5u5ygwieagrtGoMKS6NSrB61QiUit6gdUE_Oq7eA&oe=68A12FF4"
            alt="Hero Motossur principal"
            fill
            className="object-cover w-full h-full brightness-[0.4]"
            priority
          />
        </div>
        <div className="relative z-20 text-center text-white p-4">
            <h1 className="text-5xl md:text-7xl lg:text-8xl font-headline uppercase tracking-widest text-shadow-lg animate-fade-in-down">
                POTENCIA SIN LÍMITES
            </h1>
            <p className="mt-4 text-lg md:text-xl max-w-2xl mx-auto text-neutral-200 animate-fade-in-up">
                Descubre los modelos que dominarán la calle
            </p>
            <Button asChild size="lg" className="mt-8 text-lg animate-fade-in-up">
                <Link href="/catalog">
                    Ver Catálogo
                </Link>
            </Button>
        </div>
      </section>

  <section className="bg-background pb-8 md:pb-10 pt-16 md:pt-20">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold tracking-tight">Explora por Estilo</h2>
            <p className="mt-4 text-lg text-muted-foreground max-w-2xl mx-auto">
              Encuentra la moto que se adapta a tu forma de vida.
            </p>
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-5 md:grid-cols-5 lg:grid-cols-2 gap-x-12 gap-y-1 w-full px-14">
            {categoryStyles.map((category, idx) => (
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

function CategoryCard({ category }: { category: { name: string, href: string, images: string[] } }) {
  const [current, setCurrent] = React.useState(0);
  React.useEffect(() => {
    if (category.images.length < 2) return;
    const interval = setInterval(() => {
      setCurrent((prev) => (prev + 1) % category.images.length);
    }, 10000);
    return () => clearInterval(interval);
  }, [category.images.length]);
  return (
    <Link href={category.href} className="group block">
  <div className="relative overflow-hidden rounded-2xl aspect-[4/3] shadow-2xl h-full min-h-[220px] md:min-h-[300px] lg:min-h-[360px] xl:min-h-[400px] 2xl:min-h-[440px] transition-transform duration-300 group-hover:scale-105">
        <Image
          src={category.images[current]}
          alt={`Moto de estilo ${category.name}`}
          fill
          className="object-cover brightness-75"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex flex-col items-center justify-end p-10 text-center">
          <h3 className="font-headline text-4xl md:text-5xl lg:text-6xl font-bold uppercase tracking-wider text-white drop-shadow-xl">
            {category.name}
          </h3>
        </div>
      </div>
    </Link>
  );
}
