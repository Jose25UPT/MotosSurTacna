
export interface MotorcycleCardData {
  modelo: string;
  marca: string;
  cilindrada: string;
  descripcion: string;
  precio_soles: string;
  imagen: string;
  ficha_url: string;
}

export interface MotorcycleDetailData {
  descripcion: string;
  especificaciones: Record<string, any>;
  galeria: string[];
  marca: string;
  modelo: string;
}

export type BrandData<T> = Record<string, T[]>;

export interface Motorcycle {
  id: string;
  brand: string;
  model: string;
  price_soles: string;
  year: number;
  engine: string;
  description: string;
  imageUrl: string;
  technicalSheetUrl?: string;
  gallery?: string[];
  specifications?: Record<string, any>;
  color?: string;
  stock?: number;
  transmission?: string;
  style?: string; // estilo comercial (urbana, deportiva, etc.)
  displacement?: string | number; // cilindrada cruda para clasificar buckets
}

export interface PromoImage {
  id: string;
  url: string;
}
