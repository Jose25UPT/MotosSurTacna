"use client";

import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Search } from "lucide-react";

export default function NotFound() {
  return (
    <div className="min-h-[60vh] flex flex-col items-center justify-center px-6 text-center">
      <div className="mb-8 flex items-center justify-center w-20 h-20 rounded-full bg-yellow-400/10 border border-yellow-400/30">
        <Search className="h-10 w-10 text-yellow-500" />
      </div>
      <h1 className="font-headline text-4xl md:text-5xl font-extrabold tracking-tight mb-4">Página no encontrada</h1>
      <p className="max-w-lg text-muted-foreground mb-8 leading-relaxed">
        No pudimos encontrar la página que buscabas. Es posible que el enlace esté roto o que la URL haya cambiado. Vuelve al inicio para seguir explorando motos.
      </p>
      <div className="flex gap-4 flex-wrap justify-center">
        <Button asChild size="lg" className="bg-primary hover:bg-primary/90 shadow">
          <Link href="/">Ir al Inicio</Link>
        </Button>
        <Button asChild variant="outline" size="lg" className="hover:bg-black/60 backdrop-blur-sm">
          <Link href="/catalog">Ver Catálogo</Link>
        </Button>
      </div>
    </div>
  );
}
