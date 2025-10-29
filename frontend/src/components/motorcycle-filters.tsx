"use client";

import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Search, ChevronDown, RefreshCcw } from 'lucide-react';
import { Button } from './ui/button';
import { Popover, PopoverContent, PopoverTrigger } from './ui/popover';
import { Badge } from './ui/badge';
import { LogoSvg } from '@/components/logo-svg';

interface MotorcycleFiltersProps {
    searchQuery: string;
    setSearchQuery: (value: string) => void;
    selectedBrand: string;
    setSelectedBrand: (value: string) => void;
    priceRange: number[];
    setPriceRange: (value: number[]) => void;
    yearRange: number[];
    setYearRange: (value: number[]) => void;
    brands: string[];
    maxPrice: number;
    minYear: number;
    maxYear: number;
    resultCount: number;
    closeSheet: () => void;
    stylesOptions?: string[];
    displacementOptions?: string[];
    selectedStyles?: string[];
    setSelectedStyles?: (v: string[]) => void;
    selectedDisplacements?: string[];
    setSelectedDisplacements?: (v: string[]) => void;
    onReset?: () => void;
}

export default function MotorcycleFilters({
    searchQuery, setSearchQuery,
    selectedBrand, setSelectedBrand,
    priceRange, setPriceRange,
    yearRange, setYearRange,
    brands, maxPrice, minYear, maxYear,
    resultCount,
    closeSheet,
    horizontal,
    stylesOptions = [],
    displacementOptions = [],
    selectedStyles = [],
    setSelectedStyles = () => {},
    selectedDisplacements = [],
    setSelectedDisplacements = () => {},
    onReset = () => {}
}: MotorcycleFiltersProps & { horizontal?: boolean }) {
            if (!horizontal) return null;

            // Buckets de precio y año para botones por rangos
            const priceBuckets = getPriceBuckets(maxPrice);
            const yearBuckets = getYearBuckets(minYear, maxYear);

            const isPriceSelected = (min: number, max: number) => priceRange[0] === min && priceRange[1] === max;
            const isYearSelected = (min: number, max: number) => yearRange[0] === min && yearRange[1] === max;

            return (
            <div className="w-full flex flex-col gap-4">
                {/* Buscador estilo Google */}
                <div className="w-full">
                    <label htmlFor="search-input" className="sr-only">Buscar</label>
                    <div className="relative">
                        <div className="absolute left-4 top-1/2 -translate-y-1/2">
                            <LogoSvg className="h-6 w-auto opacity-90" />
                        </div>
                        <Input
                            id="search-input"
                            type="text"
                            placeholder="Busca por modelo o marca..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            className="h-12 md:h-14 w-full rounded-full pl-14 pr-12 bg-white text-gray-900 placeholder:text-gray-500 shadow-md ring-1 ring-black/5 focus-visible:ring-2 focus-visible:ring-yellow-500"
                        />
                        <Search className="absolute right-4 top-1/2 -translate-y-1/2 h-5 w-5 text-gray-400" />
                    </div>
                </div>

                {/* Secciones de filtros */}
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 items-start">
                    {/* Marca */}
                    <div className="flex flex-col">
                        <label htmlFor="brand-select" className="text-xs font-medium mb-1 tracking-wide text-white/90">Marca</label>
                        <Select value={selectedBrand} onValueChange={setSelectedBrand}>
                                    <SelectTrigger id="brand-select" className="min-w-[200px] bg-yellow-400 text-black border-yellow-500 hover:bg-yellow-500">
                                <SelectValue placeholder="Filtrar por marca" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem value="all">Todas las Marcas</SelectItem>
                                {brands.map(brand => (
                                    <SelectItem key={brand} value={brand}>{brand}</SelectItem>
                                ))}
                            </SelectContent>
                        </Select>
                    </div>

                    {/* Estilos */}
                    <div className="flex flex-col">
                        <label className="text-xs font-medium mb-1 tracking-wide text-white/90">Estilos</label>
                        <MultiCheckboxPopover
                            options={stylesOptions}
                            selected={selectedStyles}
                            setSelected={setSelectedStyles}
                            placeholder="Todos"
                            emptyLabel="Sin estilos"
                        />
                    </div>

                    {/* Cilindrada */}
                    <div className="flex flex-col">
                        <label className="text-xs font-medium mb-1 tracking-wide text-white/90">Cilindrada</label>
                        <MultiCheckboxPopover
                            options={displacementOptions}
                            selected={selectedDisplacements}
                            setSelected={setSelectedDisplacements}
                            placeholder="Todas"
                            emptyLabel="Sin datos"
                        />
                    </div>

                            {/* Precio por rangos */}
                            <div className="flex flex-col">
                                <label className="text-xs font-medium mb-1 tracking-wide text-white/90">Precio</label>
                                <div className="flex flex-wrap gap-2">
                                    {priceBuckets.map((b, idx) => (
                                        <button
                                            key={idx}
                                            type="button"
                                            onClick={() => setPriceRange([b.min, b.max])}
                                            className={`px-3 py-1.5 rounded-full text-xs border transition-colors ${isPriceSelected(b.min, b.max) ? 'bg-yellow-300 text-yellow-900 border-yellow-500' : 'bg-white/5 text-white/90 border-white/15 hover:bg-white/10'}`}
                                        >
                                            {b.label}
                                        </button>
                                    ))}
                                </div>
                                <span className="mt-1 text-[11px] text-white/80">Seleccionado: S/{priceRange[0].toLocaleString()} - S/{priceRange[1].toLocaleString()}</span>
                            </div>

                            {/* Año por rangos */}
                            {minYear !== 0 && maxYear !== 0 && (
                                <div className="flex flex-col">
                                    <label className="text-xs font-medium mb-1 tracking-wide text-white/90">Año</label>
                                    <div className="flex flex-wrap gap-2">
                                        {yearBuckets.map((b, idx) => (
                                            <button
                                                key={idx}
                                                type="button"
                                                onClick={() => setYearRange([b.min, b.max])}
                                                className={`px-3 py-1.5 rounded-full text-xs border transition-colors ${isYearSelected(b.min, b.max) ? 'bg-yellow-300 text-yellow-900 border-yellow-500' : 'bg-white/5 text-white/90 border-white/15 hover:bg-white/10'}`}
                                            >
                                                {b.label}
                                            </button>
                                        ))}
                                    </div>
                                    <span className="mt-1 text-[11px] text-white/80">Seleccionado: {yearRange[0]} - {yearRange[1]}</span>
                                </div>
                            )}

                    {/* Acciones */}
                    <div className="flex flex-col">
                        <label className="invisible">Acciones</label>
                        <div className="flex flex-col gap-2">
                            <Button variant="default" onClick={closeSheet} className="w-full">
                                Ver {resultCount} Motos
                            </Button>
                            <Button variant="outline" onClick={onReset} className="w-full text-xs flex items-center gap-1 bg-white/5 border-white/20 text-white hover:bg-white/10">
                                <RefreshCcw className="h-3 w-3" /> Reset
                            </Button>
                        </div>
                    </div>
                </div>
            </div>
        );
}

function MultiCheckboxPopover({
    options,
    selected,
    setSelected,
    placeholder,
    emptyLabel
}: {
    options: string[];
    selected: string[];
    setSelected: (v: string[]) => void;
    placeholder: string;
    emptyLabel: string;
}) {
    const toggle = (opt: string) => {
        setSelected(selected.includes(opt) ? selected.filter(o => o !== opt) : [...selected, opt]);
    };
    return (
        <Popover>
            <PopoverTrigger asChild>
                <Button variant="outline" className="justify-between min-w-[200px] bg-yellow-400 text-black border-yellow-500 hover:bg-yellow-500">
                    <span className="truncate text-left">
                        {selected.length === 0 ? placeholder : `${selected.length} seleccionados`}
                    </span>
                    <ChevronDown className="h-4 w-4" />
                </Button>
            </PopoverTrigger>
            <PopoverContent className="w-56 p-2 flex flex-col gap-2 bg-yellow-200 text-yellow-900 border-yellow-400">
                {options.length === 0 && (
                    <span className="text-xs text-muted-foreground px-1 py-2">{emptyLabel}</span>
                )}
                {options.map(opt => {
                    const active = selected.includes(opt);
                    return (
                        <button
                            type="button"
                            key={opt}
                            onClick={() => toggle(opt)}
                            className={`flex items-center justify-between text-xs px-2 py-1.5 rounded-md border transition-colors ${active ? 'bg-yellow-300 border-yellow-500 font-semibold text-yellow-900' : 'bg-yellow-100 hover:bg-yellow-200 border-yellow-300 text-yellow-900'}`}
                        >
                            <span>{opt}</span>
                            {active && <span className="text-[10px]">✔</span>}
                        </button>
                    );
                })}
                {selected.length > 0 && (
                    <div className="flex flex-wrap gap-1 pt-1">
                        {selected.map(s => (
                            <Badge key={s} variant="secondary" className="text-[10px] px-1 py-0.5 flex gap-1 items-center bg-yellow-300 text-yellow-900 border border-yellow-500">
                                {s}
                                <span
                                    onClick={() => toggle(s)}
                                    className="cursor-pointer hover:text-destructive"
                                >✕</span>
                            </Badge>
                        ))}
                    </div>
                )}
            </PopoverContent>
        </Popover>
    );
}

// Helpers para buckets
function roundToNice(value: number, step: number) {
  return Math.ceil(value / step) * step;
}

function getPriceBuckets(maxPrice: number): { label: string; min: number; max: number }[] {
  if (!maxPrice || maxPrice <= 0) return [{ label: 'Todos', min: 0, max: 0 }];
  const stepBase = Math.max(500, Math.round(maxPrice / 5 / 500) * 500); // pasos de 500 aprox en 5 tramos
  const size = roundToNice(maxPrice / 5, stepBase);
  const b0 = 0;
  const b1 = size;
  const b2 = size * 2;
  const b3 = size * 3;
  const b4 = size * 4;
  const b5 = Math.max(maxPrice, size * 5);
  return [
    { label: 'Todos', min: 0, max: maxPrice },
    { label: `≤ S/${b1.toLocaleString()}`, min: b0, max: b1 },
    { label: `S/${(b1 + 1).toLocaleString()} – S/${b2.toLocaleString()}`, min: b1 + 1, max: b2 },
    { label: `S/${(b2 + 1).toLocaleString()} – S/${b3.toLocaleString()}`, min: b2 + 1, max: b3 },
    { label: `S/${(b3 + 1).toLocaleString()} – S/${b4.toLocaleString()}`, min: b3 + 1, max: b4 },
    { label: `≥ S/${(b4 + 1).toLocaleString()}`, min: b4 + 1, max: maxPrice },
  ];
}

function getYearBuckets(minYear: number, maxYear: number): { label: string; min: number; max: number }[] {
  if (!minYear || !maxYear || minYear >= maxYear) return [{ label: 'Todos', min: minYear || 0, max: maxYear || 0 }];
  const span = maxYear - minYear + 1;
  const parts = Math.min(4, Math.max(2, Math.floor(span / 2))); // 2 a 4 tramos según span
  const size = Math.max(1, Math.floor(span / parts));
  const buckets: { label: string; min: number; max: number }[] = [
    { label: 'Todos', min: minYear, max: maxYear },
  ];
  let start = minYear;
  for (let i = 0; i < parts; i++) {
    const end = i === parts - 1 ? maxYear : Math.min(maxYear, start + size - 1);
    buckets.push({ label: `${start} – ${end}`, min: start, max: end });
    start = end + 1;
  }
  return buckets;
}
