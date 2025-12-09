"use client";
import React, { useEffect, useRef, useState } from "react";
import Image from "next/image";
import type { Motorcycle } from "@/lib/types";
import { API_URL } from "@/lib/config";
import type { SVGProps } from "react";

// Utilidades
function clamp(n: number, min: number, max: number) {
  return Math.max(min, Math.min(n, max));
}

function processUrl(url?: string): string {
  if (!url) return "";
  if (url.startsWith("http://") || url.startsWith("https://")) return url;
  if (url.startsWith("/uploads/") || url.startsWith("/")) return `${API_URL}${url}`;
  return url;
}

// Icono WhatsApp
const WhatsApp = (props: SVGProps<SVGSVGElement>) => (
  <svg viewBox="0 0 256 259" width="1em" height="1em" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid" {...props}>
    <path d="m67.663 221.823 4.185 2.093c17.44 10.463 36.971 15.346 56.503 15.346 61.385 0 111.609-50.224 111.609-111.609 0-29.297-11.859-57.897-32.785-78.824-20.927-20.927-48.83-32.785-78.824-32.785-61.385 0-111.61 50.224-110.912 112.307 0 20.926 6.278 41.156 16.741 58.594l2.79 4.186-11.16 41.156 41.853-10.464Z" fill="#00E676" />
    <path d="M219.033 37.668C195.316 13.254 162.531 0 129.048 0 57.898 0 .698 57.897 1.395 128.35c0 22.322 6.278 43.947 16.742 63.478L0 258.096l67.663-17.439c18.834 10.464 39.76 15.347 60.688 15.347 70.453 0 127.653-57.898 127.653-128.35 0-34.181-13.254-66.269-36.97-89.986ZM129.048 234.38c-18.834 0-37.668-4.882-53.712-14.648l-4.185-2.093-40.458 10.463 10.463-39.76-2.79-4.186C7.673 134.63 22.322 69.058 72.546 38.365c50.224-30.692 115.097-16.043 145.79 34.181 30.692 50.224 16.043 115.097-34.18 145.79-16.045 10.463-35.576 16.043-55.108 16.043Zm61.385-77.428-7.673-3.488s-11.16-4.883-18.136-8.371c-.698 0-1.395-.698-2.093-.698-2.093 0-3.488.698-4.883 1.396 0 0-.697.697-10.463 11.858-.698 1.395-2.093 2.093-3.488 2.093h-.698c-.697 0-2.092-.698-2.79-1.395l-3.488-1.395c-7.673-3.488-14.648-7.674-20.229-13.254-1.395-1.395-3.488-2.79-4.883-4.185-4.883-4.883-9.766-10.464-13.253-16.742l-.698-1.395c-.697-.698-.697-1.395-1.395-2.79 0-1.395 0-2.79.698-3.488 0 0 2.79-3.488 4.882-5.58 1.396-1.396 2.093-3.488 3.488-4.883 1.395-2.093 2.093-4.883 1.395-6.976-.697-3.488-9.068-22.322-11.16-26.507-1.396-2.093-2.79-2.79-4.883-3.488H83.01c-1.396 0-2.79.698-4.186.698l-.698.697c-1.395.698-2.79 2.093-4.185 2.79-1.395 1.396-2.093 2.79-3.488 4.186-4.883 6.278-7.673 13.951-7.673 21.624 0 5.58 1.395 11.161 3.488 16.044l.698 2.093c6.278 13.253 14.648 25.112 25.81 35.575l2.79 2.79c2.092 2.093 4.185 3.488 5.58 5.58 14.649 12.557 31.39 21.625 50.224 26.508 2.093.697 4.883.697 6.976 1.395h6.975c3.488 0 7.673-1.395 10.464-2.79 2.092-1.395 3.487-1.395 4.882-2.79l1.396-1.396c1.395-1.395 2.79-2.092 4.185-3.487 1.395-1.395 2.79-2.79 3.488-4.186 1.395-2.79 2.092-6.278 2.79-9.765v-4.883s-.698-.698-2.093-1.395Z" fill="#FFF" />
  </svg>
);

export default function MotorcycleDetailClient({ motorcycle }: { motorcycle: Motorcycle }) {
  const scrollerRef = useRef<HTMLDivElement | null>(null);
  const motoRef = useRef<HTMLImageElement | null>(null);
  const [lightboxOpen, setLightboxOpen] = useState(false);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);

  useEffect(() => {
    const scroller = scrollerRef.current;
    const moto = motoRef.current;
    if (!scroller) return;

    const onScroll = () => {
      const scrollTop = scroller.scrollTop;
      const docHeight = scroller.scrollHeight - scroller.clientHeight;
      const scrollProgress = docHeight > 0 ? scrollTop / docHeight : 0;

      if (moto) {
        const scale = 1 + scrollProgress * 0.05;
        moto.style.transform = `scale(${scale})`;
      }

      const panels = scroller.querySelectorAll<HTMLElement>(".panel");
      const vh = window.innerHeight;
      panels.forEach((panel) => {
        const rect = panel.getBoundingClientRect();
        const centerDist = Math.abs(rect.top + rect.height / 2 - vh / 2);
        const localProgress = clamp(1 - centerDist / (vh / 2), 0, 1);
        const content = panel.querySelector<HTMLElement>(".content");
        if (content) {
          if (localProgress > 0.3) content.classList.add("active");
          else content.classList.remove("active");
        }
      });
    };

    const onMouseMove = (e: MouseEvent) => {
      if (!moto) return;
      const centerX = window.innerWidth / 2;
      const centerY = window.innerHeight / 2;
      const offsetX = (e.clientX - centerX) / 50;
      const offsetY = (e.clientY - centerY) / 50;
      moto.style.filter = `drop-shadow(${offsetX}px ${20 + offsetY}px 40px rgba(0,0,0,0.4))`;
    };

    scroller.addEventListener("scroll", onScroll, { passive: true });
    requestAnimationFrame(onScroll);
    document.addEventListener("mousemove", onMouseMove);

    return () => {
      scroller.removeEventListener("scroll", onScroll);
      document.removeEventListener("mousemove", onMouseMove);
    };
  }, []);

  // Procesar galería
  let galleryArr: string[] = [];
  if (Array.isArray(motorcycle.gallery)) {
    galleryArr = motorcycle.gallery.map(x => (x ? String(x) : ""));
  } else if (typeof motorcycle.gallery === 'string' && motorcycle.gallery) {
    try {
      const parsed = JSON.parse(motorcycle.gallery);
      if (Array.isArray(parsed)) galleryArr = parsed.map(x => (x ? String(x) : ""));
      else if (parsed) galleryArr = [String(parsed)];
    } catch { galleryArr = [motorcycle.gallery]; }
  }
  if (!galleryArr.length && motorcycle.imageUrl) galleryArr = [motorcycle.imageUrl];
  const galleryImages = galleryArr.map(processUrl).filter(url => url !== '');

  const motoImage = motorcycle.imageUrl ? processUrl(motorcycle.imageUrl) : "";
  const engineSpecs = motorcycle.specifications?.["motor y sistema eléctrico"] || {};
  const dimSpecs = motorcycle.specifications?.dimensiones || {};
  const otherSpecs = motorcycle.specifications?.otros || {};

  const whatsappNumber = "51983504654";
  const message = encodeURIComponent(`Hola, estoy interesado en la motocicleta ${motorcycle.brand} ${motorcycle.model} (${motorcycle.year}). ¿Podrían darme más información?`);
  const whatsappUrl = `https://wa.me/${whatsappNumber}?text=${message}`;

  const openLightbox = (idx: number) => { setCurrentImageIndex(idx); setLightboxOpen(true); };
  const closeLightbox = () => setLightboxOpen(false);
  const nextImage = () => setCurrentImageIndex((prev) => (prev + 1) % galleryImages.length);
  const prevImage = () => setCurrentImageIndex((prev) => (prev - 1 + galleryImages.length) % galleryImages.length);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
      if (!lightboxOpen) return;
      if (e.key === 'Escape') closeLightbox();
      if (e.key === 'ArrowLeft') prevImage();
      if (e.key === 'ArrowRight') nextImage();
    };
    document.addEventListener('keydown', handleKey);
    return () => document.removeEventListener('keydown', handleKey);
  }, [lightboxOpen, galleryImages.length]);

  return (
    <>
      {/* Imagen central fija */}
      <div className="hero">
        {motoImage && (
          <Image
            src={motoImage}
            alt={`${motorcycle.brand} ${motorcycle.model}`}
            width={520}
            height={520}
            className="moto"
            ref={motoRef as any}
            unoptimized
            priority
          />
        )}
      </div>

      {/* Contenedor de scroll con paneles */}
      <div className="scroll-container" ref={scrollerRef}>
        {/* Panel 1: Título */}
        <section className="panel" data-dir="top">
          <div className="content content-top">
            <h1 className="title-main">{motorcycle.brand?.toUpperCase()}</h1>
            <p className="subtitle-main">{motorcycle.model?.toUpperCase()}</p>
          </div>
        </section>

        {/* Panel 2: Nombre y precio */}
        <section className="panel" data-dir="center">
          <div className="content content-center">
            <h2 className="title-product">{motorcycle.brand?.toUpperCase()} {motorcycle.model?.toUpperCase()}</h2>
            <p className="price">S/ {motorcycle.price_soles}</p>
            <a href={whatsappUrl} target="_blank" rel="noopener noreferrer" className="btn-learn">
              <WhatsApp style={{ marginRight: 8, verticalAlign: "middle" }} />
              CONTACTAR
            </a>
          </div>
        </section>

        {/* Panel 3: ENGINE specs */}
        <section className="panel" data-dir="left">
          <div className="content content-left card-white">
            <h3 className="card-title">ENGINE</h3>
            <div className="specs-grid">
              {Object.entries(engineSpecs).slice(0, 14).map(([label, value]) => (
                <div className="spec-item" key={label}>
                  <span className="spec-label">{label.toUpperCase()}</span>
                  <span className="spec-value">{String(value)}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Panel 4: CHARACTERISTICS */}
        <section className="panel" data-dir="right">
          <div className="content content-right card-white">
            <h3 className="card-title">CHARACTERISTICS</h3>
            <div className="specs-grid">
              {Object.entries({ ...dimSpecs, ...otherSpecs }).slice(0, 14).map(([label, value]) => (
                <div className="spec-item" key={label}>
                  <span className="spec-label">{label.toUpperCase()}</span>
                  <span className="spec-value">{String(value)}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Panel 5: Nombre grande */}
        <section className="panel" data-dir="bottom">
          <div className="content content-bottom">
            <p className="label-small">{motorcycle.brand?.toUpperCase()}</p>
            <h1 className="title-large">{motorcycle.model?.toUpperCase()}</h1>
            <p className="label-small">• {motorcycle.style || motorcycle.model}</p>
          </div>
        </section>

        {/* Panel 6: Galería */}
        <section className="panel panel-gallery">
          <div className="content content-gallery active">
            <h3 className="card-title" style={{ textAlign: 'center', marginBottom: 24 }}>GALERÍA</h3>
            <div className="gallery-grid">
              {galleryImages.map((img, idx) => (
                <div key={idx} className="gallery-item" onClick={() => openLightbox(idx)}>
                  <Image src={img} alt={`Imagen ${idx + 1}`} fill className="gallery-img" unoptimized />
                </div>
              ))}
            </div>
          </div>
        </section>
      </div>

      {/* WhatsApp flotante */}
      <a href={whatsappUrl} target="_blank" rel="noopener noreferrer" className="whatsapp-float" aria-label="WhatsApp">
        <WhatsApp className="whatsapp-icon" />
      </a>

      {/* Lightbox */}
      {lightboxOpen && (
        <div className="lightbox" onClick={closeLightbox}>
          <button className="lb-close" onClick={closeLightbox}>×</button>
          {galleryImages.length > 1 && <button className="lb-prev" onClick={(e) => { e.stopPropagation(); prevImage(); }}>‹</button>}
          {galleryImages.length > 1 && <button className="lb-next" onClick={(e) => { e.stopPropagation(); nextImage(); }}>›</button>}
          <div className="lb-img-wrap" onClick={(e) => e.stopPropagation()}>
            <Image src={galleryImages[currentImageIndex]} alt="Galería" fill className="lb-img" unoptimized priority />
          </div>
          {galleryImages.length > 1 && <div className="lb-counter">{currentImageIndex + 1} / {galleryImages.length}</div>}
        </div>
      )}

      <style jsx>{`
        .hero {
          position: fixed;
          inset: 0;
          display: flex;
          align-items: center;
          justify-content: center;
          pointer-events: none;
          z-index: 5;
        }
        .moto {
          width: 520px;
          height: auto;
          filter: drop-shadow(0 25px 50px rgba(0,0,0,0.5));
          transition: transform 0.3s ease, filter 0.2s ease;
          background: #fff;
          padding: 20px;
          border-radius: 4px;
        }
        .scroll-container {
          height: 100vh;
          overflow-y: auto;
          scroll-snap-type: y mandatory;
          background: linear-gradient(180deg, #5a5a5a 0%, #3a3a3a 50%, #2a2a2a 100%);
        }
        .panel {
          height: 100vh;
          width: 100vw;
          scroll-snap-align: start;
          position: relative;
          display: flex;
          align-items: center;
          justify-content: center;
        }
        .panel-gallery {
          height: auto;
          min-height: 100vh;
          padding: 60px 20px;
          background: #222;
        }
        .content {
          position: absolute;
          z-index: 2;
          opacity: 0;
          transition: opacity 0.4s ease, transform 0.4s ease;
        }
        .content-top { top: 80px; left: 50%; transform: translateX(-50%) translateY(-30px); text-align: center; }
        .title-main { font-size: 72px; font-weight: 800; color: #fff; letter-spacing: 6px; text-shadow: 0 4px 30px rgba(0,0,0,0.4); }
        .subtitle-main { font-size: 24px; color: #aaa; letter-spacing: 5px; margin-top: 14px; }
        .content-center { bottom: 180px; left: 50%; transform: translateX(-50%) translateY(30px); text-align: center; }
        .title-product { font-size: 48px; font-weight: 700; color: #fff; letter-spacing: 5px; }
        .price { font-size: 42px; color: #f00; margin-top: 14px; font-weight: 700; }
        .btn-learn {
          display: inline-flex; align-items: center; margin-top: 16px; padding: 18px 40px;
          background: #25d366; border: none; color: #fff; font-size: 18px; letter-spacing: 2px;
          cursor: pointer; transition: all 0.3s ease; text-decoration: none; border-radius: 6px; font-weight: 600;
        }
        .btn-learn:hover { background: #128c4e; }
        .content-left { left: calc(50% - 620px); top: 50%; transform: translateY(-50%) translateX(-100%); width: 340px; max-height: 80vh; overflow-y: auto; }
        .content-right { right: calc(50% - 620px); top: 50%; transform: translateY(-50%) translateX(100%); width: 340px; max-height: 80vh; overflow-y: auto; }
        .card-white { background: transparent; }
        .card-title { font-size: 24px; font-weight: 800; color: #fff; letter-spacing: 2px; margin-bottom: 22px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 12px; }
        .specs-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18px 24px; }
        .spec-item { display: flex; flex-direction: column; }
        .spec-label { font-size: 13px; font-weight: 700; color: #aaa; text-transform: uppercase; margin-bottom: 4px; letter-spacing: 0.5px; }
        .spec-value { font-size: 16px; color: #fff; line-height: 1.4; font-weight: 500; }
        .content-bottom { left: 50px; bottom: 80px; transform: translateY(30px); text-align: left; }
        .label-small { font-size: 14px; color: #888; letter-spacing: 2px; margin-bottom: 6px; }
        .title-large { font-size: 100px; font-weight: 800; color: #fff; letter-spacing: 8px; text-shadow: 0 6px 40px rgba(0,0,0,0.5); line-height: 1; }
        .content-gallery { position: relative; opacity: 1; width: 100%; max-width: 1000px; }
        .gallery-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; }
        .gallery-item { position: relative; aspect-ratio: 16/10; border-radius: 12px; overflow: hidden; cursor: pointer; transition: transform 0.3s; }
        .gallery-item:hover { transform: scale(1.03); }
        .gallery-img { object-fit: cover; }
        .content.active { opacity: 1; }
        .content-top.active { transform: translateX(-50%) translateY(0); }
        .content-center.active { transform: translateX(-50%) translateY(0); }
        .content-left.active { transform: translateY(-50%) translateX(0); }
        .content-right.active { transform: translateY(-50%) translateX(0); }
        .content-bottom.active { transform: translateY(0); }
        .scroll-container::-webkit-scrollbar { width: 6px; }
        .scroll-container::-webkit-scrollbar-thumb { background: #555; border-radius: 3px; }
        .whatsapp-float {
          position: fixed; right: 24px; bottom: 24px; z-index: 200; display: flex; align-items: center; justify-content: center;
          width: 60px; height: 60px; background: #25d366; border-radius: 50%; box-shadow: 0 4px 24px rgba(0,0,0,0.25); transition: transform 0.2s;
        }
        .whatsapp-float:hover { transform: scale(1.1); }
        .whatsapp-icon { width: 32px; height: 32px; }
        .lightbox { position: fixed; inset: 0; z-index: 300; background: rgba(0,0,0,0.95); display: flex; align-items: center; justify-content: center; }
        .lb-close { position: absolute; top: 20px; right: 20px; background: none; border: none; color: #fff; font-size: 40px; cursor: pointer; }
        .lb-prev, .lb-next { position: absolute; top: 50%; transform: translateY(-50%); background: rgba(0,0,0,0.5); border: none; color: #fff; font-size: 48px; padding: 10px 18px; cursor: pointer; border-radius: 4px; }
        .lb-prev { left: 20px; }
        .lb-next { right: 20px; }
        .lb-img-wrap { position: relative; width: 80vw; height: 80vh; }
        .lb-img { object-fit: contain; }
        .lb-counter { position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%); background: rgba(0,0,0,0.6); color: #fff; padding: 8px 20px; border-radius: 20px; }
        @media (max-width: 1200px) {
          .content-left { left: 20px; }
          .content-right { right: 20px; }
        }
        @media (max-width: 768px) {
          .moto { width: 280px; }
          .title-main { font-size: 36px; letter-spacing: 3px; }
          .subtitle-main { font-size: 16px; }
          .title-product { font-size: 28px; }
          .price { font-size: 28px; }
          .btn-learn { font-size: 14px; padding: 14px 28px; }
          .title-large { font-size: 48px; letter-spacing: 4px; }
          .card-title { font-size: 20px; }
          .spec-label { font-size: 11px; }
          .spec-value { font-size: 14px; }
          .label-small { font-size: 12px; }
          .content-left, .content-right { width: 90%; left: 5%; right: auto; transform: none; position: relative; top: auto; max-height: none; margin-bottom: 40px; }
          .content-left.active, .content-right.active { transform: none; }
        }
      `}</style>
    </>
  );
}






