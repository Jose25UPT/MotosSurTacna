"use client";

import { useState, useMemo, useEffect, useCallback, useRef, Suspense } from 'react';
import { useSearchParams } from 'next/navigation';
import type { Motorcycle } from '@/lib/types';
import MotorcycleGrid from "@/components/motorcycle-grid";
import MotorcycleFilters from "@/components/motorcycle-filters";
import { Button } from '@/components/ui/button';
import { Loader2 } from 'lucide-react';
import { getMotorcycles, getBrands, getAllMotorcyclesAccum } from '@/lib/data.service';

const PAGE_LIMIT = 20;

function CatalogContent() {
  const [motorcycles, setMotorcycles] = useState<Motorcycle[]>([]);
  const [brands, setBrands] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedBrand, setSelectedBrand] = useState('all');
  const [page, setPage] = useState(1);
  const [hasMore, setHasMore] = useState(false);
  const [total, setTotal] = useState(0);
  const searchParams = useSearchParams();

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

  // Normalizador reutilizable (coincide con el servicio)
  const slugify = (v: string) => (v || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/\s+/g, '')
    .replace(/[^a-z0-9\-]/g, '');

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
        ? brandData.map(b => typeof b === 'string' ? b : (b as any).brand)
        : [];
      setBrands(brandNames);
      console.log(`🟢 Primera página motos=${items.length} total=${t}`);
    } catch (e) {
      console.error('❌ Error cargando catálogo:', e);
    } finally {
      setLoading(false);
    }
  }, [recomputeMetrics]);

  // Carga progresiva enfocada a una marca si viene ?brand=
  const fetchFocusedBrand = useCallback(async (brandParam: string) => {
    setLoading(true);
    try {
      const target = slugify(brandParam);
      const accumulated: Motorcycle[] = [];
      let pageCursor = 1;
      let hasMoreLocal = true;
      let totalLocal = 0;
      const MAX_SCAN_PAGES = 100; // tope amplio para explorar todas las páginas si es necesario

      while (hasMoreLocal && pageCursor <= MAX_SCAN_PAGES) {
        const { items, has_more, total } = await getMotorcycles(pageCursor, PAGE_LIMIT);
        totalLocal = total;
        // Fusionar evitando duplicados
        const ids = new Set(accumulated.map(m => m.id));
        for (const m of items) if (!ids.has(m.id)) accumulated.push(m);
        // ¿Ya tenemos al menos una moto de la marca objetivo?
        const found = accumulated.some(m => slugify((m as any).brand_slug || (m as any).brand || (m as any).marca) === target);
        if (found) {
          hasMoreLocal = false; // detener
        } else {
          hasMoreLocal = has_more;
          pageCursor += 1;
        }
      }
      setMotorcycles(accumulated);
      setPage(pageCursor);
      setHasMore(pageCursor * PAGE_LIMIT < totalLocal);
      setTotal(totalLocal);
      recomputeMetrics(accumulated);
      // cargar lista de marcas (independiente)
      try {
        const brandsRaw = await getBrands();
        const brandNames = Array.isArray(brandsRaw)
          ? brandsRaw.map(b => typeof b === 'string' ? b : (b as any).brand)
          : [];
        setBrands(brandNames);
      } catch {}
      // Log diagnóstico: primeras 10 marcas detectadas en el acumulado
      try {
        const uniq = Array.from(new Set(accumulated.map(m => slugify((m as any).brand_slug || (m as any).brand || (m as any).marca))));
        console.log(`🎯 Carga enfocada marca='${brandParam}' páginas=${pageCursor} motos=${accumulated.length} marcasDetectadas=${uniq.slice(0,10).join(',')}${uniq.length>10?'...':''}`);
      } catch {}
    } catch (e) {
      console.error('❌ Error carga enfocada marca:', e);
    } finally {
      setLoading(false);
    }
  }, [recomputeMetrics]);

  // Cargar datos iniciales: si hay ?brand= usamos carga enfocada; si no, la primera página
  useEffect(() => {
    const qBrand = searchParams?.get('brand');
    if (qBrand && qBrand.trim()) {
      setSelectedBrand(qBrand);
      fetchFocusedBrand(qBrand);
    } else {
      fetchFirstPage();
    }
  }, [searchParams, fetchFirstPage, fetchFocusedBrand]);

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

  // Sentinel para infinite scroll
  const sentinelRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    const el = sentinelRef.current;
    if (!el) return;
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries.some((e) => e.isIntersecting)) {
          // Respetar guards internos de loadMore (loadingMore/hasMore)
          loadMore();
        }
      },
      {
        root: null,
        // Disparar un poco antes de llegar al final para sensación fluida
        rootMargin: '200px 0px',
        threshold: 0.1,
      }
    );
    observer.observe(el);
    return () => observer.disconnect();
    // intentionally not including loadMore in deps to avoid rebinds; guards inside loadMore
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [hasMore, loadingMore]);

  // Filtrado client-side sobre lo que ya se cargó (páginas acumuladas)
  const filteredMotorcycles = useMemo(() => {
    const normalize = (s: string) => (s ?? '').toLowerCase().trim();
    const key = (s: string) => normalize(s)
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '') // quitar acentos
      .replace(/\s+/g, '') // quitar espacios
      .replace(/[^a-z0-9\-]/g, ''); // permitir guiones (slugs)
    const selectedKey = key(selectedBrand);
    const yearActive = (minYear && maxYear) && !(yearRange[0] === minYear && yearRange[1] === maxYear);
    return motorcycles.filter(m => {
      const mBrandKey = key((m as any).brand_slug ?? (m as any).brand ?? (m as any).marca ?? '');
      const brandOk = selectedBrand === 'all'
        || mBrandKey === selectedKey
        || mBrandKey.includes(selectedKey)
        || selectedKey.includes(mBrandKey)
        // tolerar variantes comunes (espacios vs guiones)
        || mBrandKey.replace(/-/g,'') === selectedKey.replace(/-/g,'');
      const mModel = ((m as any).model ?? (m as any).modelo ?? '').toString();
      const mBrand = ((m as any).brand ?? (m as any).marca ?? '').toString();
      const searchOk = !searchQuery.trim() ||
        mModel.toLowerCase().includes(searchQuery.toLowerCase()) ||
        (selectedBrand === 'all' && mBrand.toLowerCase().includes(searchQuery.toLowerCase()));
      // precio
      let priceNum = 0;
      const rawPrice = (m as any).price_soles ?? (m as any).precio_soles;
      if (rawPrice !== undefined && rawPrice !== null) {
        priceNum = parseFloat(String(rawPrice).replace(/[^0-9.]/g, '')) || 0;
      }
      // Precio: si el rango está en [0,0] lo tratamos como "sin filtro"
      const priceOk = (priceRange[0] === 0 && priceRange[1] === 0)
        || (priceNum >= priceRange[0] && priceNum <= priceRange[1]);
      // año: si la moto no tiene año, NO la excluimos
      const mYear = Number((m as any).year ?? (m as any).anio ?? (m as any).año ?? (m as any).ano ?? 0) || 0;
      // Solo activar el filtro de año si el usuario cambió respecto al rango completo
      const yearOk = !yearActive || !mYear || (mYear >= yearRange[0] && mYear <= yearRange[1]);
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
  }, [motorcycles, selectedBrand, searchQuery, priceRange, yearRange, selectedStyles, selectedDisplacements, minYear, maxYear]);

  useEffect(() => {
    if (!loading) {
      console.log(`🔍 Filtrado -> visibles=${filteredMotorcycles.length} / cargadas=${motorcycles.length}`);
      if (selectedBrand !== 'all' && filteredMotorcycles.length === 0 && motorcycles.length) {
        try {
          const norm = (s: string) => (s||'').toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g,'').replace(/\s+/g,'').replace(/[^a-z0-9\-]/g,'');
          const have = Array.from(new Set(motorcycles.map(m => norm((m as any).brand_slug || (m as any).brand || (m as any).marca)))).slice(0,20);
          console.log(`⚠️ Marca seleccionada='${selectedBrand}' normalizada='${norm(selectedBrand)}' disponibles=[${have.join(',')}]`);
        } catch {}
      }
    }
  }, [filteredMotorcycles, motorcycles, loading, selectedBrand]);

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
        <div className="relative flex flex-col gap-4 rounded-xl border border-white/10 bg-neutral-900/60 supports-[backdrop-filter]:backdrop-blur-md shadow-[0_10px_40px_-20px_rgba(0,0,0,0.6)] p-4 md:p-5 before:content-[''] before:absolute before:inset-x-0 before:top-0 before:h-px before:bg-gradient-to-r before:from-yellow-400/70 before:via-amber-300/60 before:to-yellow-400/70">
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
              {filteredMotorcycles.length === 0 ? (
                <div className="w-full py-16 flex flex-col items-center justify-center text-center border border-dashed border-border rounded-xl bg-muted/20">
                  <p className="text-lg font-semibold">No encontramos resultados</p>
                  <p className="text-sm text-muted-foreground mt-1 max-w-md">
                    {selectedBrand !== 'all' ? `No hay motos disponibles para la marca "${selectedBrand}" con los filtros actuales.` : 'Ajusta los filtros o intenta buscar por otro término.'}
                  </p>
                  <div className="mt-4 flex gap-2">
                    <Button variant="outline" onClick={handleResetFilters}>Quitar filtros</Button>
                    <Button onClick={fetchFirstPage}>Recargar catálogo</Button>
                  </div>
                </div>
              ) : (
                <>
                  <MotorcycleGrid motorcycles={filteredMotorcycles} />
                  {/* Infinite scroll sentinel + fallback botón */}
                  <div className="mt-8 flex flex-col items-center gap-4">
                    {hasMore && (
                      <>
                        <div ref={sentinelRef} className="h-6 w-full" aria-hidden />
                        {loadingMore && (
                          <div className="flex items-center gap-2 text-sm text-muted-foreground">
                            <Loader2 className="h-4 w-4 animate-spin" /> Cargando más...
                          </div>
                        )}
                        <Button disabled={loadingMore} onClick={loadMore} variant="outline" className="w-48">
                          {loadingMore && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                          {loadingMore ? 'Cargando...' : 'Cargar más'}
                        </Button>
                      </>
                    )}
                    {!hasMore && filteredMotorcycles.length > 0 && (
                      <p className="text-sm text-muted-foreground">No hay más resultados.</p>
                    )}
                  </div>
                </>
              )}
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

export default function CatalogPage() {
  return (
    <Suspense fallback={
      <div className="w-full max-w-7xl mx-auto px-4 sm:px-8 py-8 md:py-12 flex-grow flex items-center justify-center">
        <Loader2 className="h-10 w-10 animate-spin text-primary" />
      </div>
    }>
      <CatalogContent />
    </Suspense>
  );
}
