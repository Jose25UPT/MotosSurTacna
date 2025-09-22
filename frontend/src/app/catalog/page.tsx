
"use client";

import { useState, useMemo, useEffect, useCallback } from 'react';
import type { Motorcycle } from '@/lib/types';
import MotorcycleGrid from "@/components/motorcycle-grid";
import MotorcycleCard from "@/components/motorcycle-card";
import MotorcycleFilters from "@/components/motorcycle-filters";
import { Button } from '@/components/ui/button';
import { ListFilter, Loader2, ArrowUpDown } from 'lucide-react';
import { getMotorcycles, getBrands } from '@/lib/data.service';
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationNext,
  PaginationPrevious,
  PaginationLink,
  PaginationEllipsis,
} from "@/components/ui/pagination";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

const ITEMS_PER_PAGE = 20;

export default function CatalogPage() {
  const [motorcycles, setMotorcycles] = useState<Motorcycle[]>([]);
  const [brands, setBrands] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [sortOrder, setSortOrder] = useState('default');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedBrand, setSelectedBrand] = useState('all');
  const [currentPage, setCurrentPage] = useState(1);

  const fetchData = useCallback(async () => {
    setLoading(true);
    try {
      console.log('🔍 Iniciando fetchData...');
      const [motorcycleData, brandData] = await Promise.all([
        getMotorcycles(),
        getBrands()
      ]);
      console.log('🏍️ Datos de motos recibidos:', motorcycleData?.length || 0, 'motos');
      console.log('🏷️ Datos de marcas recibidos:', brandData?.length || 0, 'marcas');
      
      // Mapear year y price a número para evitar problemas con los filtros
      // No forzar a number aquí, mantenemos el tipo original para evitar conflictos con el tipo Motorcycle
      setMotorcycles(motorcycleData);
      // Asegura que brands sea un array de strings
      const brandNames = Array.isArray(brandData)
        ? brandData.map(b => typeof b === "string" ? b : (b as any).brand)
        : [];
      setBrands(brandNames);
      console.log('✅ Estado actualizado - motos:', motorcycleData?.length, 'marcas:', brandNames?.length);
    } catch (error) {
      console.error('❌ Error en fetchData:', error);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const [minYear, maxYear] = useMemo(() => {
    if (motorcycles.length === 0) return [2000, new Date().getFullYear()];
    const years = motorcycles.map(m => m.year).filter(y => !isNaN(y));
    return years.length > 0 ? [Math.min(...years), Math.max(...years)] : [2000, new Date().getFullYear()];
  }, [motorcycles]);

  const maxPrice = useMemo(() => {
    if (motorcycles.length === 0) return 15000;
    // Incluir todas las motos, incluso las que tienen precio 0
    const prices = motorcycles.map(m => Number(m.price_soles)).filter(p => !isNaN(p));
    return prices.length > 0 ? Math.ceil(Math.max(...prices) / 1000) * 1000 : 15000;
  }, [motorcycles]);

  const [priceRange, setPriceRange] = useState([0, maxPrice]);
  const [yearRange, setYearRange] = useState([minYear, maxYear]);

  useEffect(() => {
    setPriceRange([0, maxPrice]);
    setYearRange([minYear, maxYear]);
  }, [maxPrice, minYear, maxYear]);

  const filteredAndSortedMotorcycles = useMemo(() => {
    console.log('🔄 Filtrando motos. Total disponibles:', motorcycles.length);
    console.log('🔧 Filtros activos - Marca:', selectedBrand, 'Búsqueda:', searchQuery, 'Precio:', priceRange, 'Año:', yearRange);
    
    let filtered = motorcycles.filter(motorcycle => {
      const normalize = (str: string) => str?.toLowerCase().trim();
      const brandMatch = selectedBrand === 'all' || normalize(motorcycle.brand) === normalize(selectedBrand);
      let searchMatch = true;
      if (searchQuery.trim() !== '') {
        if (selectedBrand === 'all') {
          // Si no hay marca seleccionada, buscar en modelo o marca
          searchMatch = motorcycle.model.toLowerCase().includes(searchQuery.toLowerCase()) ||
                        motorcycle.brand.toLowerCase().includes(searchQuery.toLowerCase());
        } else {
          // Si hay marca seleccionada, buscar solo en modelo
          searchMatch = motorcycle.model.toLowerCase().includes(searchQuery.toLowerCase());
        }
      }
      const price = Number(motorcycle.price_soles);
      // Permitir motos con precio 0 si el rango incluye 0, o motos con precio en el rango especificado
      const priceMatch = (price === 0 && priceRange[0] === 0) || (price >= priceRange[0] && price <= priceRange[1]);
      const yearMatch = motorcycle.year >= yearRange[0] && motorcycle.year <= yearRange[1];
      return brandMatch && searchMatch && priceMatch && yearMatch;
    });

    console.log('✅ Motos después del filtrado:', filtered.length);

    if (sortOrder === 'price-asc') {
      filtered.sort((a, b) => Number(a.price_soles) - Number(b.price_soles));
    } else if (sortOrder === 'price-desc') {
      filtered.sort((a, b) => Number(b.price_soles) - Number(a.price_soles));
    }
    return filtered;
  }, [motorcycles, searchQuery, selectedBrand, priceRange, yearRange, sortOrder]);

  useEffect(() => {
    setCurrentPage(1);
  }, [searchQuery, selectedBrand, priceRange, yearRange, sortOrder]);

  // Paginación: mostrar 15 motos por página (3x5)
  const ITEMS_PER_PAGE = 15;
  const totalPages = Math.ceil(filteredAndSortedMotorcycles.length / ITEMS_PER_PAGE);
  const motosToShow = filteredAndSortedMotorcycles.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  const handlePageChange = (page: number) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  };

  // Eliminar paginación, solo grid de 3 motos y filtro grande
  const filterProps = {
    searchQuery, setSearchQuery,
    selectedBrand, setSelectedBrand,
    priceRange, setPriceRange,
    yearRange, setYearRange,
    brands, maxPrice, minYear, maxYear,
    resultCount: filteredAndSortedMotorcycles.length,
    closeSheet: () => {},
  };

  return (
  <div className="w-full max-w-7xl mx-auto px-4 sm:px-8 py-8 md:py-12 flex-grow flex flex-col">
      <header className="mb-8 md:mb-12 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
        <div>
          <h1 className="text-3xl md:text-4xl font-bold tracking-tight">Nuestro Catálogo</h1>
          <p className="mt-2 text-lg text-muted-foreground">Encuentra la motocicleta perfecta para ti.</p>
        </div>
        <Button onClick={fetchData} variant="outline" className="self-start md:self-center">
          <Loader2 className={loading ? "mr-2 h-5 w-5 animate-spin" : "mr-2 h-5 w-5"} />
          {loading ? "Actualizando..." : "Actualizar catálogo"}
        </Button>
      </header>
  {/* Filtros arriba en barra horizontal */}
  <div className="w-full mb-6">
    <div className="flex flex-wrap gap-4 items-end bg-white/80 rounded-xl shadow p-4 border-2 border-yellow-400">
      <MotorcycleFilters {...filterProps} horizontal />
    </div>
  </div>
  {/* Contenido principal: solo 3 motos en grid vertical */}
  <main className="flex-1 flex flex-col gap-6 sm:gap-8">
    <div>
      <h2 className="text-lg font-semibold mb-2">Motos</h2>
      {loading ? (
        <div className="flex-grow flex items-center justify-center">
          <Loader2 className="h-10 w-10 animate-spin text-primary" />
        </div>
      ) : (
        <>
          <MotorcycleGrid motorcycles={motosToShow} />
          {/* Paginación */}
          {totalPages > 1 && (
            <div className="flex justify-center mt-8">
              <nav className="inline-flex items-center gap-2" aria-label="Paginación">
                <button
                  onClick={() => handlePageChange(currentPage - 1)}
                  disabled={currentPage === 1}
                  className="px-3 py-1 rounded bg-yellow-400 text-black font-bold disabled:opacity-50"
                >
                  Anterior
                </button>
                {Array.from({ length: totalPages }, (_, i) => (
                  <button
                    key={i + 1}
                    onClick={() => handlePageChange(i + 1)}
                    className={`px-3 py-1 rounded font-bold ${currentPage === i + 1 ? 'bg-black text-yellow-400' : 'bg-gray-200 text-black'}`}
                  >
                    {i + 1}
                  </button>
                ))}
                <button
                  onClick={() => handlePageChange(currentPage + 1)}
                  disabled={currentPage === totalPages}
                  className="px-3 py-1 rounded bg-yellow-400 text-black font-bold disabled:opacity-50"
                >
                  Siguiente
                </button>
              </nav>
            </div>
          )}
        </>
      )}
    </div>
  </main>
    </div>
  );
}
