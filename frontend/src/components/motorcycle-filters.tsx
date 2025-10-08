"use client";

import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Slider } from '@/components/ui/slider';
import { Search } from 'lucide-react';
import { Separator } from './ui/separator';
import { Button } from './ui/button';

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
}

export default function MotorcycleFilters({
    searchQuery, setSearchQuery,
    selectedBrand, setSelectedBrand,
    priceRange, setPriceRange,
    yearRange, setYearRange,
    brands, maxPrice, minYear, maxYear,
    resultCount,
    closeSheet,
    horizontal
}: MotorcycleFiltersProps & { horizontal?: boolean }) {
    if (horizontal) {
        // Filtros en barra horizontal, con precio y espacio para capacidad de combustible
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
                {/* Cilindrada */}
                <div className="flex flex-col min-w-[120px]">
                    <label className="text-sm font-medium mb-1">Cilindrada</label>
                    <Select>
                        <SelectTrigger className="min-w-[120px]">
                            <SelectValue placeholder="Todas" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">Todas</SelectItem>
                            <SelectItem value="125">125cc</SelectItem>
                            <SelectItem value="150">150cc</SelectItem>
                            <SelectItem value="200">200cc</SelectItem>
                            <SelectItem value="250">250cc</SelectItem>
                            <SelectItem value="300">300cc+</SelectItem>
                        </SelectContent>
                    </Select>
                </div>
                {/* Estilo */}
                <div className="flex flex-col min-w-[120px]">
                    <label className="text-sm font-medium mb-1">Estilo</label>
                    <Select>
                        <SelectTrigger className="min-w-[120px]">
                            <SelectValue placeholder="Todos" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">Todos</SelectItem>
                            <SelectItem value="urbana">Urbana</SelectItem>
                            <SelectItem value="deportiva">Deportiva</SelectItem>
                            <SelectItem value="enduro">Enduro</SelectItem>
                            <SelectItem value="crossover">Crossover</SelectItem>
                            <SelectItem value="scooter">Scooter</SelectItem>
                        </SelectContent>
                    </Select>
                </div>
                {/* Precio */}
                <div className="flex flex-col min-w-[200px]">
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
                {/* Capacidad de combustible (si existe) */}
                {/*
                <div className="flex flex-col min-w-[160px]">
                    <label className="text-sm font-medium mb-1">Capacidad de combustible (L)</label>
                    <Select>
                        <SelectTrigger className="min-w-[120px]">
                            <SelectValue placeholder="Todas" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">Todas</SelectItem>
                            <SelectItem value="5">5L</SelectItem>
                            <SelectItem value="10">10L</SelectItem>
                            <SelectItem value="15">15L+</SelectItem>
                        </SelectContent>
                    </Select>
                </div>
                */}
                {/* Otros posibles filtros útiles:
                    - Transmisión (manual/automática)
                    - Estado (nuevo/usado)
                    - Color
                    - Año (slider)
                    - Potencia
                    - Frenos
                    - Suspensión
                */}
                {/* Botón */}
                <div className="flex flex-col">
                    <label className="invisible">Ver motos</label>
                    <Button onClick={closeSheet} className="w-full">
                        Ver {resultCount} Motos
                    </Button>
                </div>
            </div>
        );
    }
    // Fallback (no horizontal) - se puede extender a modo lateral luego
    return null;
}
