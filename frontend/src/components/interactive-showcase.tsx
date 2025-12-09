"use client";
import React, { useEffect, useRef } from "react";
import Image from "next/image";
import type { Motorcycle } from "@/lib/types";
import { API_URL } from "@/lib/config";

function clamp(n: number, min: number, max: number) {
  return Math.max(min, Math.min(n, max));
}

function processUrl(url?: string): string {
  if (!url) return "";
  if (url.startsWith("http://") || url.startsWith("https://")) return url;
  if (url.startsWith("/uploads/")) return `${API_URL}${url}`;
  return url;
}

export default function InteractiveShowcase({ motorcycle }: { motorcycle: Motorcycle }) {
  const scrollerRef = useRef<HTMLDivElement | null>(null);
  const motoRef = useRef<HTMLImageElement | null>(null);

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

  const motoImage = motorcycle.imageUrl ? processUrl(motorcycle.imageUrl) : "";

  // Extraer algunas specs para mostrar en la grilla
  const engineSpecs = motorcycle.specifications?.["motor y sistema eléctrico"] || {};
  const otherSpecs = motorcycle.specifications?.otros || {};

  return (
    <div className="detail-experience">
      {/* Header fijo minimal */}
      <header className="header">
        <div className="header-left">
          <span className="dot"></span>
          <span className="dot"></span>
        </div>
        <div className="header-right">
          <span className="icon">☐</span>
          <span className="icon">⋮</span>
        </div>
      </header>

      {/* Imagen central fija */}
      <div className="hero">
        {motoImage ? (
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
        ) : null}
      </div>

      {/* Contenedor de scroll con paneles */}
      <div className="scroll-container" ref={scrollerRef}>
        {/* Panel 1: Título */}
        <section className="panel" data-dir="top">
          <div className="content content-top">
            <h1 className="title-main">READY TO CRUISE</h1>
            <p className="subtitle-main">RELAX AND ENJOY THE RIDE</p>
          </div>
        </section>

        {/* Panel 2: Nombre y precio */}
        <section className="panel" data-dir="center">
          <div className="content content-center">
            <h2 className="title-product">{motorcycle.brand} {motorcycle.model}</h2>
            <p className="price">S/ {motorcycle.price_soles}</p>
            <button className="btn-learn">LEARN MORE</button>
          </div>
        </section>

        {/* Panel 3: ENGINE specs */}
        <section className="panel" data-dir="left">
          <div className="content content-left card-white">
            <h3 className="card-title">ENGINE</h3>
            <div className="specs-grid">
              {Object.entries(engineSpecs).slice(0, 12).map(([label, value]) => (
                <div className="spec-item" key={label}>
                  <span className="spec-label">{label}</span>
                  <span className="spec-value">{String(value)}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Panel 4: CHARACTERISTICS (otros) */}
        <section className="panel" data-dir="right">
          <div className="content content-right card-white">
            <h3 className="card-title">CHARACTERISTICS</h3>
            <div className="specs-grid">
              {Object.entries(otherSpecs).slice(0, 12).map(([label, value]) => (
                <div className="spec-item" key={label}>
                  <span className="spec-label">{label}</span>
                  <span className="spec-value">{String(value)}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Panel 5: Label grande */}
        <section className="panel" data-dir="bottom">
          <div className="content content-bottom">
            <p className="label-small">{motorcycle.brand?.toUpperCase()}</p>
            <h1 className="title-large">{motorcycle.model?.toUpperCase()}</h1>
            <p className="label-small">• {motorcycle.model}</p>
          </div>
        </section>
      </div>

      <style jsx>{`
        .detail-experience { position: relative; background: linear-gradient(180deg, #5a5a5a 0%, #3a3a3a 50%, #2a2a2a 100%); }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 40px; background: #2d2d2d; display: flex; justify-content: space-between; align-items: center; padding: 0 16px; z-index: 100; border-bottom: 1px solid #444; }
        .header-left { display: flex; gap: 8px; }
        .dot { width: 12px; height: 12px; background: #666; border-radius: 50%; }
        .header-right { display: flex; gap: 16px; }
        .icon { color: #888; font-size: 16px; cursor: pointer; }

        .hero { position: fixed; inset: 0; display: flex; align-items: center; justify-content: center; pointer-events: none; z-index: 5; padding-top: 40px; }
        .moto { width: 520px; height: auto; filter: drop-shadow(0 25px 50px rgba(0,0,0,0.5)); transition: transform 0.3s ease, filter 0.2s ease; z-index: 10; background: #fff; padding: 20px; border-radius: 4px; }

        .scroll-container { height: 100vh; overflow-y: auto; scroll-snap-type: y mandatory; padding-top: 40px; }
        .panel { height: 100vh; width: 100vw; scroll-snap-align: start; position: relative; display: flex; align-items: center; justify-content: center; }
        .content { position: absolute; z-index: 2; opacity: 0; transition: opacity 0.4s ease, transform 0.4s ease; }

        .content-top { top: 60px; left: 50%; transform: translateX(-50%) translateY(-30px); text-align: center; }
        .title-main { font-size: 52px; font-weight: 800; color: #fff; letter-spacing: 5px; text-shadow: 0 4px 30px rgba(0,0,0,0.4); }
        .subtitle-main { font-size: 18px; font-weight: 400; color: #aaa; letter-spacing: 4px; margin-top: 10px; }

        .content-center { bottom: 100px; left: 50%; transform: translateX(-50%) translateY(30px); text-align: center; }
        .title-product { font-size: 32px; font-weight: 700; color: #fff; letter-spacing: 4px; }
        .price { font-size: 20px; color: #ddd; margin-top: 10px; }
        .btn-learn { margin-top: 20px; padding: 12px 28px; background: transparent; border: 2px solid #777; color: #fff; font-size: 12px; letter-spacing: 2px; cursor: pointer; transition: all 0.3s ease; }
        .btn-learn:hover { background: #fff; color: #222; }

        .content-left { left: calc(50% - 580px); top: 50%; transform: translateY(-50%) translateX(-100%); width: 260px; max-height: 80vh; overflow-y: auto; }
        .content-right { right: calc(50% - 580px); top: 50%; transform: translateY(-50%) translateX(100%); width: 260px; max-height: 80vh; overflow-y: auto; }
        .card-white { background: transparent; padding: 0; border-radius: 0; box-shadow: none; }
        .card-title { font-size: 16px; font-weight: 800; color: #fff; letter-spacing: 1px; margin-bottom: 18px; border-bottom: 1px solid rgba(255,255,255,0.2); padding-bottom: 10px; }
        .specs-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px 20px; }
        .spec-item { display: flex; flex-direction: column; }
        .spec-label { font-size: 10px; font-weight: 700; color: #888; letter-spacing: 0.5px; text-transform: uppercase; margin-bottom: 3px; }
        .spec-value { font-size: 12px; font-weight: 400; color: #fff; line-height: 1.3; }

        .content-bottom { left: 50px; bottom: 80px; transform: translateY(30px); text-align: left; }
        .label-small { font-size: 10px; color: #888; letter-spacing: 1px; margin-bottom: 4px; }
        .title-large { font-size: 80px; font-weight: 800; color: #fff; letter-spacing: 6px; text-shadow: 0 6px 40px rgba(0,0,0,0.5); line-height: 1; }

        .content.active { opacity: 1; }
        .content-top.active { transform: translateX(-50%) translateY(0); }
        .content-center.active { transform: translateX(-50%) translateY(0); }
        .content-left.active { transform: translateY(-50%) translateX(0); }
        .content-right.active { transform: translateY(-50%) translateX(0); }
        .content-bottom.active { transform: translateY(0); }

        /* Scrollbars */
        .scroll-container::-webkit-scrollbar { width: 6px; }
        .scroll-container::-webkit-scrollbar-track { background: transparent; }
        .scroll-container::-webkit-scrollbar-thumb { background: #555; border-radius: 3px; }
        .card-white::-webkit-scrollbar { width: 4px; }
        .card-white::-webkit-scrollbar-thumb { background: #ccc; border-radius: 2px; }
      `}</style>
    </div>
  );
}
