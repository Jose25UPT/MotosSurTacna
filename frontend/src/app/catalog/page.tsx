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

  // Estados para rangos dinámicos
  const [priceRange, setPriceRange] = useState<[number, number]>([0, 0]);
  const [yearRange, setYearRange] = useState<[number, number]>([0, 0]);
  const [maxPrice, setMaxPrice] = useState(0);
  const [minYear, setMinYear] = useState(0);
  const [maxYear, setMaxYear] = useState(0);
  // Nuevos estados para filtros avanzados
  const [selectedStyles, setSelectedStyles] = useState<string[]>([]);
  const [selectedDisplacements, setSelectedDisplacements] = useState<string[]>([]);
  const [stylesOptions, setStylesOptions] = useState<string[]>([]);
  const [displacementOptions, setDisplacementOptions] = useState<string[]>([]);
  // Debounce búsqueda
  const [searchInput, setSearchInput] = useState('');

  // Buckets de cilindrada definidas
  const DISPLACEMENT_BUCKETS: { label: string; test: (cc: number) => boolean; order: number }[] = [
    { label: '≤125cc', test: cc => cc <= 125, order: 1 },
    { label: '126-150cc', test: cc => cc >= 126 && cc <= 150, order: 2 },
    { label: '151-200cc', test: cc => cc >= 151 && cc <= 200, order: 3 },
    { label: '201-250cc', test: cc => cc >= 201 && cc <= 250, order: 4 },
    { label: '251-300cc', test: cc => cc >= 251 && cc <= 300, order: 5 },
    { label: '301cc+', test: cc => cc >= 301, order: 6 },
  ];

  const recomputeMetrics = useCallback((all: Motorcycle[]) => {
    if (!all.length) return;
    const prices: number[] = [];
    const years: number[] = [];
    const styleSet = new Set<string>();
    const dispBucketSet = new Set<string>();
    for (const m of all) {
      // price_soles puede venir como string o number; limpiar separadores/eventuales prefijos
      let p = 0;
      if (m.price_soles !== undefined && m.price_soles !== null) {
        const raw = String(m.price_soles).replace(/[^0-9.]/g, '');
        p = parseFloat(raw) || 0;
      }
      prices.push(p);
      if (m.year) years.push(Number(m.year));
      // estilos (si vienen)
      if (m.style && m.style.trim()) styleSet.add(capitalize(m.style));
      // cilindrada: intentar de displacement, si no engine
      const dispRaw = (m as any).displacement || m.engine || '';
      const match = String(dispRaw).match(/(\d{2,4})\s*cc/i);
      if (match) {
        const cc = parseInt(match[1], 10);
        const bucket = DISPLACEMENT_BUCKETS.find(b => b.test(cc));
        if (bucket) dispBucketSet.add(bucket.label);
      }
    }
    const newMaxPrice = Math.max(...prices);
    const newMinYear = Math.min(...years);
    const newMaxYear = Math.max(...years);
    setMaxPrice(prev => newMaxPrice > prev ? newMaxPrice : prev || newMaxPrice);
    setMinYear(prev => prev === 0 ? newMinYear : Math.min(prev, newMinYear));
    setMaxYear(prev => prev === 0 ? newMaxYear : Math.max(prev, newMaxYear));
    // Inicializar rangos sólo si aún están en cero
    setPriceRange(pr => (pr[0] === 0 && pr[1] === 0) ? [0, newMaxPrice] : [pr[0], Math.max(pr[1], newMaxPrice)]);
    setYearRange(yr => (yr[0] === 0 && yr[1] === 0) ? [newMinYear, newMaxYear] : [Math.min(yr[0], newMinYear), Math.max(yr[1], newMaxYear)]);
    setStylesOptions(Array.from(styleSet).sort());
    setDisplacementOptions(Array.from(dispBucketSet).sort((a,b) => {
      const oA = DISPLACEMENT_BUCKETS.find(d=>d.label===a)?.order || 99;
      const oB = DISPLACEMENT_BUCKETS.find(d=>d.label===b)?.order || 99;
      return oA - oB;
    }));
  }, []);

  function capitalize(s: string) { return s.charAt(0).toUpperCase() + s.slice(1).toLowerCase(); }

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
      recomputeMetrics(items);
      const brandNames = Array.isArray(brandData)
        ? brandData.map(b => typeof b === "string" ? b : (b as any).brand)
        : [];
      setBrands(brandNames);
      console.log(`🟢 Primera página motos=${items.length} total=${t}`, items[0]);
    } catch (e) {
      console.error('❌ Error cargando catálogo:', e);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { fetchFirstPage(); }, [fetchFirstPage]);

  // Debounce searchInput -> searchQuery
  useEffect(() => {
    const id = setTimeout(() => setSearchQuery(searchInput), 300);
    return () => clearTimeout(id);
  }, [searchInput]);

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
      recomputeMetrics(merged);
      console.log(`📦 loadMore -> acumuladas=${merged.length} page=${returnedPage} has_more=${has_more}`);
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
      // precio
      let priceNum = 0;
      if (m.price_soles !== undefined && m.price_soles !== null) {
        priceNum = parseFloat(String(m.price_soles).replace(/[^0-9.]/g, '')) || 0;
      }
      const priceOk = priceNum >= priceRange[0] && priceNum <= priceRange[1];
      // año
      const yearOk = !yearRange[0] || !yearRange[1] || (m.year >= yearRange[0] && m.year <= yearRange[1]);
      // estilos
      const styleOk = !selectedStyles.length || (m.style && selectedStyles.includes(capitalize(m.style)));
      // cilindrada bucket
      let dispOk = true;
      if (selectedDisplacements.length) {
        const dispRaw = (m as any).displacement || m.engine || '';
        const match = String(dispRaw).match(/(\d{2,4})\s*cc/i);
        if (match) {
          const cc = parseInt(match[1], 10);
          const bucket = DISPLACEMENT_BUCKETS.find(b => b.test(cc));
          dispOk = bucket ? selectedDisplacements.includes(bucket.label) : false;
        } else {
          dispOk = false;
        }
      }
      return brandOk && searchOk && priceOk && yearOk && styleOk && dispOk;
    });
  }, [motorcycles, selectedBrand, searchQuery, priceRange, yearRange, selectedStyles, selectedDisplacements]);

  useEffect(() => {
    if (!loading) {
      console.log(`🔍 Filtrado -> visibles=${filteredMotorcycles.length} / cargadas=${motorcycles.length}`);
    }
  }, [filteredMotorcycles, motorcycles, loading]);

  const filterProps = {
    searchQuery: searchInput,
    setSearchQuery: setSearchInput,
    selectedBrand, setSelectedBrand,
    priceRange, setPriceRange,
    yearRange, setYearRange,
    brands,
    maxPrice,
    minYear,
    maxYear,
    resultCount: filteredMotorcycles.length,
    closeSheet: () => {},
    stylesOptions,
    displacementOptions,
    selectedStyles, setSelectedStyles,
    selectedDisplacements, setSelectedDisplacements,
    onReset: handleResetFilters,
  } as any;

  function handleResetFilters() {
    setSelectedBrand('all');
    setSearchInput('');
    setSearchQuery('');
    setSelectedStyles([]);
    setSelectedDisplacements([]);
    if (maxPrice) setPriceRange([0, maxPrice]);
    if (minYear && maxYear) setYearRange([minYear, maxYear]);
  }

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
        <div className="flex flex-col gap-4 bg-white/80 rounded-xl shadow p-4 border-2 border-yellow-400">
          <MotorcycleFilters {...filterProps} horizontal />
          {/* Badges filtros activos */}
          <ActiveFiltersBar
            brand={selectedBrand !== 'all' ? selectedBrand : null}
            search={searchQuery || null}
            priceChanged={priceRange[0] !== 0 || (maxPrice && priceRange[1] !== maxPrice)}
            yearChanged={(minYear && maxYear) && (yearRange[0] !== minYear || yearRange[1] !== maxYear)}
            styles={selectedStyles}
            displacements={selectedDisplacements}
            onRemoveBrand={() => setSelectedBrand('all')}
            onRemoveSearch={() => { setSearchInput(''); setSearchQuery(''); }}
            onRemovePrice={() => maxPrice && setPriceRange([0, maxPrice])}
            onRemoveYear={() => (minYear && maxYear) && setYearRange([minYear, maxYear])}
            onRemoveStyle={(s) => setSelectedStyles(prev => prev.filter(x => x !== s))}
            onRemoveDisp={(d) => setSelectedDisplacements(prev => prev.filter(x => x !== d))}
            onResetAll={handleResetFilters}
          />
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

// Componente de badges de filtros activos
function ActiveFiltersBar(props: {
  brand: string | null;
  search: string | null;
  priceChanged: boolean;
  yearChanged: boolean;
  styles: string[];
  displacements: string[];
  onRemoveBrand: () => void;
  onRemoveSearch: () => void;
  onRemovePrice: () => void;
  onRemoveYear: () => void;
  onRemoveStyle: (s: string) => void;
  onRemoveDisp: (d: string) => void;
  onResetAll: () => void;
}) {
  const any = props.brand || props.search || props.priceChanged || props.yearChanged || props.styles.length || props.displacements.length;
  if (!any) return null;
  const Badge = ({ label, onClear }: { label: string; onClear: () => void }) => (
    <span className="flex items-center gap-1 bg-yellow-100 text-yellow-800 px-2 py-1 rounded-full text-xs font-medium border border-yellow-300">
      {label}
      <button aria-label="Quitar filtro" onClick={onClear} className="hover:text-red-600 transition-colors">✕</button>
    </span>
  );
  return (
    <div className="flex flex-wrap gap-2 items-center">
      <span className="text-xs font-semibold text-muted-foreground mr-1">Filtros activos:</span>
      {props.brand && <Badge label={`Marca: ${props.brand}`} onClear={props.onRemoveBrand} />}
      {props.search && <Badge label={`Busca: ${props.search}`} onClear={props.onRemoveSearch} />}
      {props.priceChanged && <Badge label="Precio" onClear={props.onRemovePrice} />}
      {props.yearChanged && <Badge label="Año" onClear={props.onRemoveYear} />}
      {props.styles.map(s => <Badge key={s} label={s} onClear={() => props.onRemoveStyle(s)} />)}
      {props.displacements.map(d => <Badge key={d} label={d} onClear={() => props.onRemoveDisp(d)} />)}
      <button onClick={props.onResetAll} className="ml-2 text-xs text-blue-600 hover:underline font-medium">Reset</button>
    </div>
  );
}
