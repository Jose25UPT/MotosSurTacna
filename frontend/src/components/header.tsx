
"use client";

import Link from "next/link";
import { Menu, ShieldAlert } from "lucide-react";
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


  const navLinks = [
    { href: "/", label: "Inicio" },
    { href: "/catalog", label: "Catálogo" },
    { href: "/accesorios", label: "Accesorios" },
    { href: "/tiendas", label: "Nuestras Tiendas" },
    { href: "/fraud-report", label: "Reportar Fraude" },
  ];
  

  return (
    <header className={cn(
        "sticky top-0 z-50 w-full border-b transition-all duration-300 border-border/40 bg-gradient-to-r from-primary to-accent text-primary-foreground",
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
      <div className="container mx-auto flex h-20 max-w-7xl items-center justify-between px-4">
        <Link href="/" className="flex items-center gap-2" onClick={() => setIsMobileMenuOpen(false)}>
          <img src="/assets/2.svg" alt="Logo Motossur" className="h-12 w-auto" />
          <div className="flex flex-col leading-tight ml-2 select-none">
            <span className="font-headline text-2xl md:text-3xl font-black tracking-widest flex">
              <span className="text-[#E53935]">MOTOS</span>
              <span className="text-foreground ml-1">SUR</span>
            </span>
            <span className="flex items-center justify-center gap-2 mt-[-2px]">
              <span className="block w-6 h-1 bg-[#E53935] rounded-full md:w-10 md:h-1"></span>
              <span className="font-headline text-xs md:text-sm text-foreground tracking-widest font-bold">TACNA</span>
              <span className="block w-6 h-1 bg-[#E53935] rounded-full md:w-10 md:h-1"></span>
            </span>
          </div>
        </Link>
        <nav className="hidden md:flex items-center gap-6 text-lg font-bold">
          {navLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="text-primary-foreground/90 transition-colors hover:text-primary-foreground hover:scale-105 font-headline tracking-wider"
            >
              {link.label}
            </Link>
          ))}
        </nav>
        <div className="md:hidden">
          <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
            <SheetTrigger asChild>
              <Button variant="ghost" size="icon" className="text-primary-foreground hover:bg-black/10 hover:text-primary-foreground">
                <Menu className="h-6 w-6" />
                <span className="sr-only">Open menu</span>
              </Button>
            </SheetTrigger>
            <SheetContent side="right" className="bg-gradient-to-br from-primary to-accent text-primary-foreground">
              <SheetHeader>
                <SheetTitle className="sr-only">Menú Principal</SheetTitle>
                <Link href="/" className="flex items-center gap-2 mb-4" onClick={() => setIsMobileMenuOpen(false)}>
                  <img src="/assets/2.svg" alt="Logo Motossur" className="h-10 w-auto" />
                  <div className="flex flex-col leading-tight ml-2 select-none">
                    <span className="font-headline text-lg font-black tracking-widest flex">
                      <span className="text-[#E53935]">MOTOS</span>
                      <span className="text-foreground ml-1">SUR</span>
                    </span>
                    <span className="flex items-center justify-center gap-2 mt-[-2px]">
                      <span className="block w-4 h-0.5 bg-[#E53935] rounded-full"></span>
                      <span className="font-headline text-xs text-foreground tracking-widest font-bold">TACNA</span>
                      <span className="block w-4 h-0.5 bg-[#E53935] rounded-full"></span>
                    </span>
                  </div>
                </Link>
              </SheetHeader>
              <div className="flex flex-col gap-4">
                {navLinks.map((link) => (
                  <Link
                    key={link.href}
                    href={link.href}
                    className="text-lg font-medium text-primary-foreground/80 transition-colors hover:text-primary-foreground"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    {link.label}
                  </Link>
                ))}
              </div>
            </SheetContent>
          </Sheet>
        </div>
      </div>
    </header>
  );
}
