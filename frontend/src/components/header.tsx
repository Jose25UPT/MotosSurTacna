
"use client";

import Link from "next/link";
import { Menu, ShieldAlert, Home, Grid2X2, Wrench, MapPin } from "lucide-react";
import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";
import { cn } from "@/lib/utils";
import { LogoSvg } from "./logo-svg";

const MAINTENANCE_MODE = false;

export default function Header() {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isHidden, setIsHidden] = useState(false);
  const [lastScrollY, setLastScrollY] = useState(0);

  useEffect(() => {
    const controlNavbar = () => {
      if (typeof window !== 'undefined') { 
        if (window.scrollY > lastScrollY && window.scrollY > 80) { // if scroll down hide the navbar
          setIsHidden(true); 
        } else { // if scroll up show the navbar
          setIsHidden(false);  
        }
        setLastScrollY(window.scrollY); 
      }
    };

    if (typeof window !== 'undefined') {
      window.addEventListener('scroll', controlNavbar);
      return () => {
        window.removeEventListener('scroll', controlNavbar);
      };
    }
  }, [lastScrollY]);


  const navLinks: Array<{ href: string; label: string; icon?: React.ComponentType<{ className?: string }>; } > = [
    { href: "/", label: "Inicio", icon: Home },
    { href: "/catalog", label: "Catálogo", icon: Grid2X2 },
    { href: "/accesorios", label: "Accesorios", icon: Wrench },
    { href: "/tiendas", label: "Nuestras Tiendas", icon: MapPin },
    { href: "/fraud-report", label: "Reportar Fraude", icon: ShieldAlert },
  ];
  

  return (
    <header className={cn(
      "sticky top-0 z-50 w-full border-b transition-all duration-300 border-border/40 bg-gradient-to-r from-black via-black to-white text-white",
        isHidden ? '-translate-y-full' : 'translate-y-0'
    )}>
      {MAINTENANCE_MODE && (
        <Alert variant="destructive" className="rounded-none border-x-0 border-t-0">
          <ShieldAlert className="h-4 w-4" />
          <AlertTitle>Maintenance Mode</AlertTitle>
          <AlertDescription>
            The site is currently undergoing scheduled maintenance. Some features may be unavailable.
          </AlertDescription>
        </Alert>
      )}
      <div className="container mx-auto flex h-32 max-w-7xl items-center justify-between px-4">
          <Link href="/" className="flex items-center" onClick={() => setIsMobileMenuOpen(false)}>
              <span className="inline-flex items-center justify-center rounded-md bg-black p-4 shadow-sm">
                <img src="/assets/logomotossur/file.svg" alt="Logo Motossur Tacna" className="h-24 w-auto" />
              </span>
        </Link>
        <nav className="hidden md:flex items-center gap-6 text-lg font-bold">
          {navLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="text-white/90 transition-colors hover:text-white hover:scale-105 font-headline tracking-wider"
            >
              {link.label}
            </Link>
          ))}
        </nav>
        <div className="md:hidden">
          <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
            <SheetTrigger asChild>
              <Button
                variant="ghost"
                className="h-12 px-4 rounded-xl bg-white/10 text-white hover:bg-white/20 border border-white/20 flex items-center gap-2"
              >
                <Menu className="h-7 w-7" />
                <span className="text-base font-bold tracking-wide">Menú</span>
              </Button>
            </SheetTrigger>
            <SheetContent
              side="right"
              className="w-[92vw] sm:max-w-sm bg-gradient-to-br from-black via-black to-white text-white p-6"
            >
              <SheetHeader>
                <SheetTitle className="sr-only">Menú Principal</SheetTitle>
                <Link href="/" className="flex items-center mb-4" onClick={() => setIsMobileMenuOpen(false)}>
                  <span className="inline-flex items-center justify-center rounded-md bg-black p-3 shadow-sm">
                    <img src="/assets/logomotossur/file.svg" alt="Logo Motossur Tacna" className="h-16 w-auto" />
                  </span>
                </Link>
              </SheetHeader>
              <nav className="mt-2 flex flex-col gap-3">
                {navLinks.map(({ href, label, icon: Icon }) => (
                  <Link
                    key={href}
                    href={href}
                    onClick={() => setIsMobileMenuOpen(false)}
                    className="flex items-center gap-4 px-4 py-4 rounded-xl bg-white/10 hover:bg-white/15 text-white text-[18px] font-bold tracking-wide border border-white/20"
                  >
                    {Icon ? <Icon className="w-6 h-6 text-white/90" /> : null}
                    <span>{label}</span>
                  </Link>
                ))}
              </nav>
            </SheetContent>
          </Sheet>
        </div>
      </div>
    </header>
  );
}
