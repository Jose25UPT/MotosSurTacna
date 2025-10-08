"use client";

import { useState, useMemo, useEffect, useCallback } from 'react';
import type { Motorcycle } from '@/lib/types';
import MotorcycleGrid from "@/components/motorcycle-grid";
import MotorcycleFilters from "@/components/motorcycle-filters";
import { Button } from '@/components/ui/button';
import { Loader2 } from 'lucide-react';
import { getMotorcycles, getBrands, getAllMotorcyclesAccum } from '@/lib/data.service';

const PAGE_LIMIT = 20;

export default function CatalogPage() {
  const [motorcycles, setMotorcycles] = useState<Motorcycle[]>([]);
  const [brands, setBrands] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedBrand, setSelectedBrand] = useState('all');
  const [page, setPage] = useState(1);
  const [hasMore, setHasMore] = useState(false);
  const [total, setTotal] = useState(0);

  const fetchFirstPage = useCallback(async () => {
    setLoading(true);
    try {
      const [{ items, has_more, total: t }, brandData] = await Promise.all([
        getMotorcycles(1, PAGE_LIMIT),
        getBrands()
      ]);
      setMotorcycles(items);
      setHasMore(has_more);
      setTotal(t);
      setPage(1);
      const brandNames = Array.isArray(brandData)
        ? brandData.map(b => typeof b === "string" ? b : (b as any).brand)
        : [];
      setBrands(brandNames);
    } catch (e) {
      console.error('❌ Error cargando catálogo:', e);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { fetchFirstPage(); }, [fetchFirstPage]);

  const loadMore = async () => {
    if (loadingMore || !hasMore) return;
    setLoadingMore(true);
    try {
      const nextPage = page + 1;
      const { merged, page: returnedPage, has_more, total: t } = await getAllMotorcyclesAccum(motorcycles, nextPage, PAGE_LIMIT);
      setMotorcycles(merged);
      setPage(returnedPage);
      setHasMore(has_more);
      setTotal(t);
    } catch (e) {
      console.error('❌ Error cargando más motos:', e);
    } finally {
      setLoadingMore(false);
    }
  };

  // Filtrado client-side sobre lo que ya se cargó (páginas acumuladas)
  const filteredMotorcycles = useMemo(() => {
    const normalize = (s: string) => s.toLowerCase().trim();
    return motorcycles.filter(m => {
      const brandOk = selectedBrand === 'all' || normalize(m.brand) === normalize(selectedBrand);
      const searchOk = !searchQuery.trim() || m.model.toLowerCase().includes(searchQuery.toLowerCase()) || (selectedBrand === 'all' && m.brand.toLowerCase().includes(searchQuery.toLowerCase()));
      return brandOk && searchOk;
    });
  }, [motorcycles, selectedBrand, searchQuery]);

  const filterProps = {
    searchQuery, setSearchQuery,
    selectedBrand, setSelectedBrand,
    // placeholders para sliders removidos temporalmente
    priceRange: [0, 0], setPriceRange: () => {},
    yearRange: [0, 0], setYearRange: () => {},
    brands,
    maxPrice: 0,
    minYear: 0,
    maxYear: 0,
    resultCount: filteredMotorcycles.length,
    closeSheet: () => {},
  } as any;

  return (
    <div className="w-full max-w-7xl mx-auto px-4 sm:px-8 py-8 md:py-12 flex-grow flex flex-col">
      <header className="mb-8 md:mb-12 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
        <div>
          <h1 className="text-3xl md:text-4xl font-bold tracking-tight">Nuestro Catálogo</h1>
          <p className="mt-2 text-lg text-muted-foreground">Encuentra la motocicleta perfecta para ti.</p>
        </div>
        <Button onClick={fetchFirstPage} variant="outline" className="self-start md:self-center">
          <Loader2 className={loading ? "mr-2 h-5 w-5 animate-spin" : "mr-2 h-5 w-5"} />
          {loading ? "Actualizando..." : "Refrescar"}
        </Button>
      </header>

      <div className="w-full mb-6">
        <div className="flex flex-wrap gap-4 items-end bg-white/80 rounded-xl shadow p-4 border-2 border-yellow-400">
          <MotorcycleFilters {...filterProps} horizontal />
        </div>
      </div>

      <main className="flex-1 flex flex-col gap-6 sm:gap-8">
        <div>
          <h2 className="text-lg font-semibold mb-2 flex items-center gap-2">Motos <span className="text-sm font-normal text-muted-foreground">({filteredMotorcycles.length} / {total})</span></h2>
          {loading ? (
            <div className="flex-grow flex items-center justify-center">
              <Loader2 className="h-10 w-10 animate-spin text-primary" />
            </div>
          ) : (
            <>
              <MotorcycleGrid motorcycles={filteredMotorcycles} />
              <div className="mt-8 flex flex-col items-center gap-4">
                {hasMore && (
                  <Button disabled={loadingMore} onClick={loadMore} className="w-48">
                    {loadingMore && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                    {loadingMore ? 'Cargando...' : 'Cargar más'}
                  </Button>
                )}
                {!hasMore && filteredMotorcycles.length > 0 && (
                  <p className="text-sm text-muted-foreground">No hay más resultados.</p>
                )}
              </div>
            </>
          )}
        </div>
      </main>
    </div>
  );
}
