"use client";
import React, { useState, useRef, useEffect } from 'react';

// Carrusel de galería mejorado (solo una vez, antes del export default)

import type { Motorcycle } from '@/lib/types';
import Image from 'next/image';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Calendar, Cog, Gauge, Scale, Wrench } from 'lucide-react';
import { Separator } from '@/components/ui/separator';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion';
import type { SVGProps } from "react";

const WhatsApp = (props: SVGProps<SVGSVGElement>) => <svg viewBox="0 0 256 259" width="1em" height="1em" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid" {...props}><path d="m67.663 221.823 4.185 2.093c17.44 10.463 36.971 15.346 56.503 15.346 61.385 0 111.609-50.224 111.609-111.609 0-29.297-11.859-57.897-32.785-78.824-20.927-20.927-48.83-32.785-78.824-32.785-61.385 0-111.61 50.224-110.912 112.307 0 20.926 6.278 41.156 16.741 58.594l2.79 4.186-11.16 41.156 41.853-10.464Z" fill="#00E676" /><path d="M219.033 37.668C195.316 13.254 162.531 0 129.048 0 57.898 0 .698 57.897 1.395 128.35c0 22.322 6.278 43.947 16.742 63.478L0 258.096l67.663-17.439c18.834 10.464 39.76 15.347 60.688 15.347 70.453 0 127.653-57.898 127.653-128.35 0-34.181-13.254-66.269-36.97-89.986ZM129.048 234.38c-18.834 0-37.668-4.882-53.712-14.648l-4.185-2.093-40.458 10.463 10.463-39.76-2.79-4.186C7.673 134.63 22.322 69.058 72.546 38.365c50.224-30.692 115.097-16.043 145.79 34.181 30.692 50.224 16.043 115.097-34.18 145.79-16.045 10.463-35.576 16.043-55.108 16.043Zm61.385-77.428-7.673-3.488s-11.16-4.883-18.136-8.371c-.698 0-1.395-.698-2.093-.698-2.093 0-3.488.698-4.883 1.396 0 0-.697.697-10.463 11.858-.698 1.395-2.093 2.093-3.488 2.093h-.698c-.697 0-2.092-.698-2.79-1.395l-3.488-1.395c-7.673-3.488-14.648-7.674-20.229-13.254-1.395-1.395-3.488-2.79-4.883-4.185-4.883-4.883-9.766-10.464-13.253-16.742l-.698-1.395c-.697-.698-.697-1.395-1.395-2.79 0-1.395 0-2.79.698-3.488 0 0 2.79-3.488 4.882-5.58 1.396-1.396 2.093-3.488 3.488-4.883 1.395-2.093 2.093-4.883 1.395-6.976-.697-3.488-9.068-22.322-11.16-26.507-1.396-2.093-2.79-2.79-4.883-3.488H83.01c-1.396 0-2.79.698-4.186.698l-.698.697c-1.395.698-2.79 2.093-4.185 2.79-1.395 1.396-2.093 2.79-3.488 4.186-4.883 6.278-7.673 13.951-7.673 21.624 0 5.58 1.395 11.161 3.488 16.044l.698 2.093c6.278 13.253 14.648 25.112 25.81 35.575l2.79 2.79c2.092 2.093 4.185 3.488 5.58 5.58 14.649 12.557 31.39 21.625 50.224 26.508 2.093.697 4.883.697 6.976 1.395h6.975c3.488 0 7.673-1.395 10.464-2.79 2.092-1.395 3.487-1.395 4.882-2.79l1.396-1.396c1.395-1.395 2.79-2.092 4.185-3.487 1.395-1.395 2.79-2.79 3.488-4.186 1.395-2.79 2.092-6.278 2.79-9.765v-4.883s-.698-.698-2.093-1.395Z" fill="#FFF" /></svg>;


export default function MotorcycleDetailClient({ motorcycle }: { motorcycle: Motorcycle }) {
  // Estado para el lightbox de la galería
  const [lightboxOpen, setLightboxOpen] = useState(false);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);

  // Datos destacados (puedes adaptar a tus props reales)
  const destacados = [
    { label: 'Capacidad de tanque', value: '17 L' },
    { label: 'Cilindrada', value: '249.9 cc' },
    { label: 'Velocidades', value: '6' },
    { label: 'Potencia', value: '18.7 HP / 8000 RPM' },
    { label: 'Torque', value: '18 Nm @6000 rpm' },
  ];
  const whatsappNumber = "51983504654"; 
  const message = encodeURIComponent(`Hola, estoy interesado en la motocicleta ${motorcycle.brand} ${motorcycle.model} (${motorcycle.year}). ¿Podrían darme más información?`);
  const whatsappUrl = `https://wa.me/${whatsappNumber}?text=${message}`;

  const keySpecs = [
    { icon: Cog, label: 'Motor', value: motorcycle.engine },
    { icon: Calendar, label: 'Año', value: motorcycle.year },
    { icon: Gauge, label: 'Potencia', value: motorcycle.specifications?.['motor y sistema eléctrico']?.Potencia || 'N/A' },
    { icon: Wrench, label: 'Torque', value: motorcycle.specifications?.['motor y sistema eléctrico']?.Torque || 'N/A' },
    { icon: Scale, label: 'Peso', value: motorcycle.specifications?.dimensiones?.Peso || 'N/A' },
  ];
  
  // Refuerzo: normalizar siempre a array de strings
  let galleryArr: string[] = [];
  if (Array.isArray(motorcycle.gallery)) {
    galleryArr = motorcycle.gallery.map(x => (x ? String(x) : ""));
  } else if (typeof motorcycle.gallery === 'string' && motorcycle.gallery) {
    try {
      const parsed = JSON.parse(motorcycle.gallery);
      if (Array.isArray(parsed)) {
        galleryArr = parsed.map(x => (x ? String(x) : ""));
      } else if (parsed) {
        galleryArr = [String(parsed)];
      }
    } catch {
      galleryArr = [motorcycle.gallery];
    }
  }
  // Si sigue vacío, usar imagen principal
  if (!galleryArr.length && motorcycle.imageUrl) {
    galleryArr = [motorcycle.imageUrl];
  }
  
  // Procesar URLs de galería usando la misma lógica que data.service.ts
  const processGalleryUrl = (url: string) => {
    if (!url || url.trim() === '' || url === 'N/A' || url === 'null') return '';
    
    // Si ya es una URL completa (http/https), usarla tal como está
    if (url.startsWith('http://') || url.startsWith('https://')) {
      try {
        new URL(url);
        return url;
      } catch {
        return '';
      }
    } else if (url.startsWith('/uploads/')) {
      // Si es una ruta relativa local, construir URL completa
      return `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000'}${url}`;
    }
    
    return '';
  };
  
  const galleryImages = galleryArr.map(processGalleryUrl).filter(url => url !== '');

  // Funciones para el lightbox
  const openLightbox = (index: number) => {
    setCurrentImageIndex(index);
    setLightboxOpen(true);
  };

  const closeLightbox = () => {
    setLightboxOpen(false);
  };

  const nextImage = () => {
    setCurrentImageIndex((prev) => (prev + 1) % galleryImages.length);
  };

  const prevImage = () => {
    setCurrentImageIndex((prev) => (prev - 1 + galleryImages.length) % galleryImages.length);
  };

  // Manejar teclas del teclado para navegación
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (!lightboxOpen) return;
      
      switch (e.key) {
        case 'Escape':
          closeLightbox();
          break;
        case 'ArrowLeft':
          prevImage();
          break;
        case 'ArrowRight':
          nextImage();
          break;
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [lightboxOpen, galleryImages.length]);

  function displaySpecValue(val: any) {
  if (val === null || val === undefined || val === '' || val === 'null' || val === 'N/A') return null;
    return String(val);
  }

  return (
    <div className="bg-background">
      {/* Sección principal: imagen de fondo y datos clave superpuestos */}
      <section className="relative w-full min-h-[60vh] flex items-center justify-end overflow-hidden">
        {/* Imagen de fondo */}
        {motorcycle.imageUrl && motorcycle.imageUrl.trim() ? (
          <Image
            src={motorcycle.imageUrl}
            alt={`${motorcycle.brand} ${motorcycle.model}`}
            fill
            className="object-cover w-full h-full brightness-[0.45]"
            data-ai-hint={`${motorcycle.brand} ${motorcycle.model}`}
            unoptimized
            priority
            onError={(e) => {
              console.error(`Error loading detail image for ${motorcycle.brand} ${motorcycle.model}:`, motorcycle.imageUrl);
              // Ocultar la imagen si falla al cargar
              const target = e.target as HTMLImageElement;
              target.style.display = 'none';
            }}
          />
        ) : (
          <div className="absolute inset-0 bg-gradient-to-br from-gray-700 to-gray-900" />
        )}
        {/* Overlay oscuro */}
        <div className="absolute inset-0 bg-gradient-to-b from-black/70 via-black/40 to-black/80" />
        {/* Contenido alineado a la derecha, todo en blanco */}
        <div className="relative z-10 w-full max-w-5xl px-4 py-16 flex flex-col items-end">
          <div className="w-full max-w-2xl flex flex-col items-end text-right gap-6">
            <Badge variant="secondary" className="w-fit mb-2 text-lg tracking-widest uppercase shadow-lg bg-white/80 text-black font-bold">{motorcycle.brand}</Badge>
            <h1 className="text-6xl md:text-7xl font-extrabold tracking-tight mb-2 text-white drop-shadow-lg font-sans animate-fade-in-up">{motorcycle.model}</h1>
            <p className="text-2xl text-white mb-2 font-semibold drop-shadow-lg animate-fade-in-up">Año {motorcycle.year}</p>
            <p className="text-2xl text-white mb-4 font-medium drop-shadow-lg animate-fade-in-up font-sans">{motorcycle.description}</p>
            <div className="mb-4 flex flex-col items-end gap-2 animate-fade-in-up">
              <p className="text-base text-white">Precio referencial</p>
              <div className="flex items-baseline gap-4">
                <p className="text-5xl md:text-6xl font-extrabold text-primary drop-shadow-lg">S/ {motorcycle.price_soles}</p>
                <p className="text-2xl font-semibold text-white">{motorcycle.price_soles}</p>
              </div>
            </div>
            {/* Botón flotante de WhatsApp */}
            <a
              href={whatsappUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="fixed right-6 bottom-6 z-50 flex items-center gap-2 px-5 py-3 rounded-full bg-green-500 hover:bg-green-600 text-white font-bold shadow-lg transition-all text-lg md:text-xl animate-bounce"
              style={{ boxShadow: '0 4px 24px 0 rgba(0,0,0,0.18)' }}
            >
              <WhatsApp className="w-7 h-7" />
              WhatsApp
            </a>
          </div>
        </div>
      </section>

      {/* Sección: Datos destacados */}
      <section className="w-full bg-white/60 backdrop-blur-xl py-12 border-t border-b border-gray-200 animate-fade-in-up">
        <div className="max-w-6xl mx-auto px-4 flex flex-col items-center">
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-8 w-full">
            <div className="flex flex-col items-center bg-white/70 backdrop-blur-lg rounded-2xl p-8 shadow-2xl min-h-[140px] border border-yellow-200 hover:border-yellow-400 transition-all group animate-fade-in-up">
              <span className="mb-2 animate-spin-slow group-hover:scale-110 transition-transform">
                <Cog className="w-8 h-8 text-yellow-600" />
              </span>
              <span className="text-lg font-semibold text-yellow-700 mb-2">Motor</span>
              <span className="text-2xl font-extrabold text-black drop-shadow">{motorcycle.engine || 'N/A'}</span>
            </div>
            <div className="flex flex-col items-center bg-white/70 backdrop-blur-lg rounded-2xl p-8 shadow-2xl min-h-[140px] border border-yellow-200 hover:border-yellow-400 transition-all group animate-fade-in-up">
              <span className="mb-2 animate-pulse group-hover:scale-110 transition-transform">
                <Gauge className="w-8 h-8 text-yellow-600" />
              </span>
              <span className="text-lg font-semibold text-yellow-700 mb-2">Potencia</span>
              <span className="text-2xl font-extrabold text-black drop-shadow">{motorcycle.specifications?.['motor y sistema eléctrico']?.Potencia || 'N/A'}</span>
            </div>
            <div className="flex flex-col items-center bg-white/70 backdrop-blur-lg rounded-2xl p-8 shadow-2xl min-h-[140px] border border-yellow-200 hover:border-yellow-400 transition-all group animate-fade-in-up">
              <span className="mb-2 animate-bounce group-hover:scale-110 transition-transform">
                <Wrench className="w-8 h-8 text-yellow-600" />
              </span>
              <span className="text-lg font-semibold text-yellow-700 mb-2">Cilindrada</span>
              <span className="text-2xl font-extrabold text-black drop-shadow">{motorcycle.specifications?.['motor y sistema eléctrico']?.Cilindrada || 'N/A'}</span>
            </div>
            <div className="flex flex-col items-center bg-white/70 backdrop-blur-lg rounded-2xl p-8 shadow-2xl min-h-[140px] border border-yellow-200 hover:border-yellow-400 transition-all group animate-fade-in-up">
              <span className="mb-2 animate-wiggle group-hover:scale-110 transition-transform">
                <Scale className="w-8 h-8 text-yellow-600" />
              </span>
              <span className="text-lg font-semibold text-yellow-700 mb-2">Peso</span>
              <span className="text-2xl font-extrabold text-black drop-shadow">{motorcycle.specifications?.dimensiones?.Peso || 'N/A'}</span>
            </div>
          </div>
        </div>
      </section>


      {/* Sección: Especificaciones técnicas (Tabla corporativa) */}
      <section className="w-full bg-white py-16 border-t border-gray-200">
        <div className="max-w-4xl mx-auto px-4">
          <h2 className="text-4xl font-bold mb-10 text-black text-center tracking-wider font-sans">Especificaciones Técnicas</h2>
          {/* Motor y sistema eléctrico */}
          {motorcycle.specifications?.['motor y sistema eléctrico'] && (
            <div className="mb-10">
              <h3 className="text-2xl font-bold mb-4 text-black font-sans tracking-wide">Motor y Sistema Eléctrico</h3>
              <div className="overflow-x-auto rounded-2xl shadow-xl border border-gray-200">
                <table className="min-w-full bg-white rounded-2xl">
                  <thead className="bg-gray-100">
                    <tr>
                      <th className="py-3 px-6 text-left text-lg font-bold text-black rounded-tl-2xl font-sans tracking-wide">Especificación</th>
                      <th className="py-3 px-6 text-left text-lg font-bold text-black rounded-tr-2xl font-sans tracking-wide">Valor</th>
                    </tr>
                  </thead>
                  <tbody>
                    {Object.entries(motorcycle.specifications['motor y sistema eléctrico'])
                      .filter(([_, value]) => displaySpecValue(value) !== null)
                      .map(([key, value], idx) => (
                        <tr key={key} className={idx % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                          <td className="py-3 px-6 text-base text-black font-bold border-b border-gray-100 font-sans tracking-wide">{key}</td>
                          <td className="py-3 px-6 text-lg text-black font-bold border-b border-gray-100 font-sans tracking-wide">{displaySpecValue(value)}</td>
                        </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
          {/* Dimensiones */}
          {motorcycle.specifications?.dimensiones && (
            <div className="mb-10">
              <h3 className="text-2xl font-bold mb-4 text-black font-sans tracking-wide">Dimensiones</h3>
              <div className="overflow-x-auto rounded-2xl shadow-xl border border-gray-200">
                <table className="min-w-full bg-white rounded-2xl">
                  <thead className="bg-gray-100">
                    <tr>
                      <th className="py-3 px-6 text-left text-lg font-bold text-black rounded-tl-2xl font-sans tracking-wide">Especificación</th>
                      <th className="py-3 px-6 text-left text-lg font-bold text-black rounded-tr-2xl font-sans tracking-wide">Valor</th>
                    </tr>
                  </thead>
                  <tbody>
                    {Object.entries(motorcycle.specifications.dimensiones)
                      .filter(([_, value]) => displaySpecValue(value) !== null)
                      .map(([key, value], idx) => (
                        <tr key={key} className={idx % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                          <td className="py-3 px-6 text-base text-black font-bold border-b border-gray-100 font-sans tracking-wide">{key}</td>
                          <td className="py-3 px-6 text-lg text-black font-bold border-b border-gray-100 font-sans tracking-wide">{displaySpecValue(value)}</td>
                        </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
          {/* Otros */}
          {motorcycle.specifications?.otros && (
            <div className="mb-10">
              <h3 className="text-2xl font-bold mb-4 text-black font-sans tracking-wide">Otros</h3>
              <div className="overflow-x-auto rounded-2xl shadow-xl border border-gray-200">
                <table className="min-w-full bg-white rounded-2xl">
                  <thead className="bg-gray-100">
                    <tr>
                      <th className="py-3 px-6 text-left text-lg font-bold text-black rounded-tl-2xl font-sans tracking-wide">Especificación</th>
                      <th className="py-3 px-6 text-left text-lg font-bold text-black rounded-tr-2xl font-sans tracking-wide">Valor</th>
                    </tr>
                  </thead>
                  <tbody>
                    {Object.entries(motorcycle.specifications.otros)
                      .filter(([_, value]) => displaySpecValue(value) !== null)
                      .map(([key, value], idx) => (
                        <tr key={key} className={idx % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                          <td className="py-3 px-6 text-base text-black font-bold border-b border-gray-100 font-sans tracking-wide">{key}</td>
                          <td className="py-3 px-6 text-lg text-black font-bold border-b border-gray-100 font-sans tracking-wide">{displaySpecValue(value)}</td>
                        </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
      </section>


      {/* Sección: Galería de imágenes mejorada */}
      <section className="py-12 md:py-20">
        <div className="container mx-auto px-4">
          <div className="max-w-4xl mx-auto">
            <h2 className="text-4xl md:text-5xl font-extrabold mb-10 text-center text-black">Galería de Imágenes</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
              {galleryImages.map((img, idx) => (
                <div 
                  key={idx} 
                  className="rounded-xl overflow-hidden border bg-white relative aspect-video cursor-pointer hover:scale-105 transition-transform duration-300 shadow-lg hover:shadow-xl"
                  onClick={() => openLightbox(idx)}
                >
                  <Image
                    src={img}
                    alt={`Imagen ${idx + 1} de ${motorcycle.brand} ${motorcycle.model}`}
                    fill
                    className="object-cover"
                    loading={idx === 0 ? 'eager' : 'lazy'}
                    unoptimized
                    onError={(e) => {
                      console.error(`Error loading gallery image ${idx + 1}:`, img);
                      // Ocultar la imagen si falla al cargar
                      const target = e.target as HTMLImageElement;
                      target.style.display = 'none';
                    }}
                  />
                  {/* Overlay para indicar que es clicable */}
                  <div className="absolute inset-0 bg-black/0 hover:bg-black/10 transition-colors duration-300 flex items-center justify-center">
                    <div className="opacity-0 hover:opacity-100 transition-opacity duration-300">
                      <svg className="w-12 h-12 text-white drop-shadow-lg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0zM10 7v3m0 0v3m0-3h3m-3 0H7" />
                      </svg>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

  {/* Sección asimétrica profesional: Moto y datos técnicos */}
  {/* (Movida justo antes de Especificaciones Técnicas) */}





      {/* Sección: Sobre la marca de la moto */}
  <section className="py-12 md:py-20 bg-white/80 backdrop-blur-xl animate-fade-in-up">
    <div className="container mx-auto px-4 max-w-3xl flex flex-col items-center">
      {/* Logo de la marca si existe */}
      {motorcycle.brand && (
        <div className="mb-4 flex items-center gap-4">
          <img
            src={`/logos/${motorcycle.brand.toLowerCase()}.svg`}
            alt={motorcycle.brand}
            className="h-16 w-auto object-contain drop-shadow-lg"
            onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }}
          />
          <h2 className="text-3xl md:text-4xl font-bold text-black text-center drop-shadow-lg">Sobre {motorcycle.brand}</h2>
        </div>
      )}
      <p className="text-lg md:text-xl text-black text-center animate-fade-in-up">
        {motorcycle.brand === 'Honda' && 'Honda es una de las marcas más reconocidas a nivel mundial por su innovación, calidad y durabilidad en motocicletas.'}
        {motorcycle.brand === 'Yamaha' && 'Yamaha destaca por su tecnología avanzada y su presencia en competencias internacionales.'}
        {motorcycle.brand === 'Suzuki' && 'Suzuki es sinónimo de rendimiento y confiabilidad en el mundo de las motos.'}
        {motorcycle.brand !== 'Honda' && motorcycle.brand !== 'Yamaha' && motorcycle.brand !== 'Suzuki' && `La marca ${motorcycle.brand} es reconocida por su calidad y presencia en el mercado.`}
      </p>
    </div>
  </section>

      {/* Lightbox Modal */}
      {lightboxOpen && (
        <div 
          className="fixed inset-0 z-50 bg-black/90 flex items-center justify-center p-4"
          onClick={closeLightbox}
        >
          <div className="relative max-w-7xl max-h-[90vh] w-full h-full flex items-center justify-center">
            {/* Botón cerrar */}
            <button
              onClick={closeLightbox}
              className="absolute top-4 right-4 z-10 bg-black/50 hover:bg-black/70 text-white rounded-full p-2 transition-colors"
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
            
            {/* Botón anterior */}
            {galleryImages.length > 1 && (
              <button
                onClick={(e) => { e.stopPropagation(); prevImage(); }}
                className="absolute left-4 top-1/2 -translate-y-1/2 z-10 bg-black/50 hover:bg-black/70 text-white rounded-full p-3 transition-colors"
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
              </button>
            )}
            
            {/* Botón siguiente */}
            {galleryImages.length > 1 && (
              <button
                onClick={(e) => { e.stopPropagation(); nextImage(); }}
                className="absolute right-4 top-1/2 -translate-y-1/2 z-10 bg-black/50 hover:bg-black/70 text-white rounded-full p-3 transition-colors"
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                </svg>
                </button>
            )}
            
            {/* Imagen principal */}
            <div 
              className="relative w-full h-full max-w-5xl max-h-[80vh]"
              onClick={(e) => e.stopPropagation()}
            >
              <Image
                src={galleryImages[currentImageIndex]}
                alt={`Imagen ${currentImageIndex + 1} de ${motorcycle.brand} ${motorcycle.model}`}
                fill
                className="object-contain"
                unoptimized
                priority
              />
            </div>
            
            {/* Contador de imágenes */}
            {galleryImages.length > 1 && (
              <div className="absolute bottom-4 left-1/2 -translate-x-1/2 bg-black/50 text-white px-4 py-2 rounded-full">
                {currentImageIndex + 1} / {galleryImages.length}
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}





