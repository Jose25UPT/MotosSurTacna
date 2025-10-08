"use client";

import type { Motorcycle } from '@/lib/types';
import MotorcycleCard from './motorcycle-card';
import { Bike } from 'lucide-react';

interface MotorcycleGridProps {
  motorcycles: Motorcycle[];
  limitFirst?: number; // opcional si se quiere limitar en algún contexto
}

export default function MotorcycleGrid({ motorcycles, limitFirst }: MotorcycleGridProps) {
  const motos = limitFirst ? motorcycles.slice(0, limitFirst) : motorcycles;
  return (
    <div className="w-full px-2 sm:px-3 md:px-4 lg:px-6">
      {motos.length > 0 ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 w-full">
          {motos.map(motorcycle => (
            <MotorcycleCard key={motorcycle.id} motorcycle={motorcycle} largeWidth />
          ))}
        </div>
      ) : (
        <div className="text-center py-16 border-2 border-dashed rounded-lg col-span-full">
          <Bike className="mx-auto h-12 w-12 text-muted-foreground" />
          <h3 className="mt-4 text-lg font-semibold">No se Encontraron Motocicletas</h3>
          <p className="mt-2 text-sm text-muted-foreground">Intenta ajustar los filtros para encontrar la moto de tus sueños.</p>
        </div>
      )}
    </div>
  );
}
