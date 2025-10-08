"use client";

import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Slider } from '@/components/ui/slider';
import { Search, ChevronDown, RefreshCcw } from 'lucide-react';
import { Button } from './ui/button';
import { Popover, PopoverContent, PopoverTrigger } from './ui/popover';
import { Badge } from './ui/badge';

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
    return (
            <div className="flex flex-wrap gap-4 items-end w-full">
                {/* Buscar */}
                <div className="flex flex-col">
                    <label htmlFor="search-input" className="text-sm font-medium mb-1">Buscar</label>
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                        <Input
                            id="search-input"
                            type="text"
                            placeholder="Busca por modelo o marca..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            className="pl-10 min-w-[180px]"
                        />
                    </div>
                </div>
                {/* Marca */}
                <div className="flex flex-col">
                    <label htmlFor="brand-select" className="text-sm font-medium mb-1">Marca</label>
                    <Select value={selectedBrand} onValueChange={setSelectedBrand}>
                        <SelectTrigger id="brand-select" className="min-w-[140px]">
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
                <div className="flex flex-col min-w-[160px]">
                    <label className="text-sm font-medium mb-1">Estilos</label>
                    <MultiCheckboxPopover
                        options={stylesOptions}
                        selected={selectedStyles}
                        setSelected={setSelectedStyles}
                        placeholder="Todos"
                        emptyLabel="Sin estilos"
                    />
                </div>
                {/* Cilindrada */}
                <div className="flex flex-col min-w-[160px]">
                    <label className="text-sm font-medium mb-1">Cilindrada</label>
                    <MultiCheckboxPopover
                        options={displacementOptions}
                        selected={selectedDisplacements}
                        setSelected={setSelectedDisplacements}
                        placeholder="Todas"
                        emptyLabel="Sin datos"
                    />
                </div>
                {/* Precio */}
                <div className="flex flex-col min-w-[240px]">
                    <label className="text-sm font-medium mb-1">
                        Precio: S/{priceRange[0].toLocaleString()} - S/{priceRange[1].toLocaleString()}
                    </label>
                    <Slider
                        min={0}
                        max={maxPrice}
                        step={100}
                        value={priceRange}
                        onValueChange={setPriceRange}
                        className="w-full"
                    />
                </div>
                {/* Año */}
                {minYear !== 0 && maxYear !== 0 && (
                    <div className="flex flex-col min-w-[220px]">
                        <label className="text-sm font-medium mb-1">Año: {yearRange[0]} - {yearRange[1]}</label>
                        <Slider
                            min={minYear}
                            max={maxYear}
                            step={1}
                            value={yearRange}
                            onValueChange={setYearRange}
                            className="w-full"
                        />
                    </div>
                )}
                {/* Acciones */}
                <div className="flex flex-col">
                    <label className="invisible">Acciones</label>
                    <div className="flex flex-col gap-2">
                        <Button variant="default" onClick={closeSheet} className="w-full">
                            Ver {resultCount} Motos
                        </Button>
                        <Button variant="outline" onClick={onReset} className="w-full text-xs flex items-center gap-1">
                            <RefreshCcw className="h-3 w-3" /> Reset
                        </Button>
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
                <Button variant="outline" className="justify-between min-w-[150px]">
                    <span className="truncate text-left">
                        {selected.length === 0 ? placeholder : `${selected.length} seleccionados`}
                    </span>
                    <ChevronDown className="h-4 w-4 opacity-60" />
                </Button>
            </PopoverTrigger>
            <PopoverContent className="w-56 p-2 flex flex-col gap-2">
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
                            className={`flex items-center justify-between text-xs px-2 py-1.5 rounded-md border transition-colors ${active ? 'bg-yellow-200 border-yellow-400 font-medium' : 'hover:bg-muted'}`}
                        >
                            <span>{opt}</span>
                            {active && <span className="text-[10px]">✔</span>}
                        </button>
                    );
                })}
                {selected.length > 0 && (
                    <div className="flex flex-wrap gap-1 pt-1">
                        {selected.map(s => (
                            <Badge key={s} variant="secondary" className="text-[10px] px-1 py-0.5 flex gap-1 items-center">
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
