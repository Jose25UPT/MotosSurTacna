// Editar una motocicleta existente
export async function updateMotorcycle(id: string, data: any): Promise<Motorcycle> {
    const res = await fetch(`${API_URL}/motos/${id}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
            ...getAuthHeaders(),
        },
        body: JSON.stringify(data),
    });
    handle401(res);
    if (!res.ok) throw new Error('Error al actualizar motocicleta');
    return await res.json();
}

// Eliminar una motocicleta existente
export async function deleteMotorcycle(id: string): Promise<boolean> {
    const res = await fetch(`${API_URL}/motos/${id}`, {
        method: 'DELETE',
        headers: getAuthHeaders(),
    });
    handle401(res);
    if (!res.ok) throw new Error('Error al eliminar motocicleta');
    return true;
}

// Actualiza los precios de varias motos en lote
export async function updateMotorcyclePrices(updates: { id: string; price_soles: string }[]): Promise<boolean> {
    const res = await fetch(`${API_URL}/motos/precios`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
            ...getAuthHeaders(),
        },
        body: JSON.stringify({ updates }),
    });
    handle401(res);
    return res.ok;
}

// Obtener imágenes promocionales del carrusel
export async function getPromoImages(): Promise<PromoImage[]> {
    const res = await fetch(`${API_URL}/promo-images`, {
        cache: 'no-store',
        headers: getAuthHeaders(),
    });
    handle401(res);
    if (!res.ok) throw new Error('Error al obtener imágenes promocionales');
    return await res.json();
}

// Actualizar una imagen promocional
export async function updatePromoImage(id: string, url: string): Promise<boolean> {
    const res = await fetch(`${API_URL}/promo-images/${id}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
            ...getAuthHeaders(),
        },
        body: JSON.stringify({ url }),
    });
    handle401(res);
    return res.ok;
}
import type { Motorcycle, PromoImage } from './types';
import { API_URL } from './config';

function handle401(res: Response) {
    if (res.status === 401) {
        if (typeof window !== 'undefined') {
            localStorage.removeItem('admin_token');
            window.location.href = '/login';
        }
        throw new Error('No autorizado');
    }
}

function getAuthHeaders() {
    if (typeof window === 'undefined') return {};
    const token = localStorage.getItem('admin_token');
    return token ? { Authorization: `Bearer ${token}` } : {};
}

// --- Brand normalization helpers ---
function slugifyBrand(v: string): string {
    return String(v || '')
        .toLowerCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .replace(/\s+/g, '')
        .replace(/[^a-z0-9\-]/g, '');
}

const brandAliases: Record<string, string> = {
    // Advance (todas las variantes en minúsculas como key)
    'advance': 'Advance',
    'motosadvance': 'Advance',
    'advanceperu': 'Advance',
    'advancemotos': 'Advance',
    'advancemotocicletas': 'Advance',
    'motos advance': 'Advance',
    // B52 (todas las variantes en minúsculas como key)
    'b52': 'B52',
    'b52motos': 'B52',
    'b52motocicletas': 'B52',
    'b52motorcycles': 'B52',
    'motos b52': 'B52',
    'b 52': 'B52',
    'b-52': 'B52',
    // Ultravip
    'ultravip': 'Ultravip',
    'ultravipmotocicletas': 'Ultravip',
    'ultra': 'Ultravip',
    'ultra vip': 'Ultravip',
    // Duconda
    'duconda': 'Duconda',
    'duconda motos': 'Duconda',
    // JCH
    'jch': 'JCH',
    'jchmotos': 'JCH',
    // Rezzio
    'rezzio': 'Rezzio',
    'rezziomotocicletas': 'Rezzio',
    'rezziomotorcycles': 'Rezzio',
    // Wanxin
    'wanxin': 'Wanxin',
    'wanxín': 'Wanxin',
    'wanxinmotos': 'Wanxin',
    // Sonlink
    'sonlink': 'Sonlink',
    'son link': 'Sonlink',
    'sonlinkmotos': 'Sonlink',
    // Zontes
    'zontes': 'Zontes',
    'zontesmotos': 'Zontes',
    // Nami
    'nami': 'Nami',
    'namimotos': 'Nami',
};

function canonicalizeBrand(input: string): { name: string; slug: string } {
    const raw = String(input || '');
    const key = slugifyBrand(raw);
    const canonicalName = brandAliases[key] || (raw.trim() ? raw.trim() : '');
    const slug = slugifyBrand(canonicalName || raw);
    return { name: canonicalName, slug };
}

export interface PaginatedMotorcycles {
    items: Motorcycle[];
    total: number;
    page: number;
    limit: number;
    has_more: boolean;
}

export async function getMotorcycles(page: number = 1, limit: number = 20): Promise<PaginatedMotorcycles> {
    console.log('📡 Iniciando petición a:', `${API_URL}/motos?page=${page}&limit=${limit}`);
    const res = await fetch(`${API_URL}/motos?page=${page}&limit=${limit}`, {
        cache: 'no-store',
        headers: getAuthHeaders(),
    });
    console.log('📡 Respuesta recibida. Status:', res.status, 'OK:', res.ok);
    handle401(res);
    if (!res.ok) throw new Error('Error al obtener motos');
    const payload = await res.json();
    // Normalizar distintas posibles formas: {items:[]}, {data:[]}, []
    let rawItems: any[] = [];
    if (Array.isArray(payload)) {
        rawItems = payload;
    } else if (Array.isArray(payload.items)) {
        rawItems = payload.items;
    } else if (Array.isArray(payload.data)) {
        rawItems = payload.data; // backend está usando "data" en lugar de "items"
    } else {
        console.warn('⚠️ Formato de payload inesperado en /motos:', payload);
    }

    const mapped = rawItems.map((moto: any) => {
        // Unificar campos del backend (es/eng)
        const brandRaw = moto.brand ?? moto.marca ?? '';
        const { name: brand, slug: brand_slug } = canonicalizeBrand(brandRaw);
        const model = moto.model ?? moto.modelo ?? '';
        const price_soles = moto.price_soles ?? moto.precio_soles ?? 0;
        const year = Number(moto.year ?? moto.anio ?? moto.año ?? moto.ano ?? 0) || 0;
        const engine = moto.engine ?? moto.cilindrada ?? '';
        const displacement = moto.displacement ?? moto.cilindrada ?? '';
        const style = moto.style ?? moto.estilo ?? '';
        const transmission = moto.transmission ?? moto.transmision ?? '';

        // Imagen: aceptar image_url o imagen
        let rawImage: string = moto.image_url ?? moto.imagen ?? '';
        let imageUrl = '';
        if (rawImage && String(rawImage).trim()) {
            const val = String(rawImage);
            if (val.startsWith('http://') || val.startsWith('https://')) {
                try { new URL(val); imageUrl = val; } catch { imageUrl = ''; }
            } else if (val.startsWith('/uploads/')) {
                imageUrl = val;
            } else if (val.startsWith('/')) {
                imageUrl = val;
            }
        }
        const description = moto.description ?? moto.descripcion ?? '';

        const obj = {
            ...moto,
            brand,
            brand_slug,
            model,
            price_soles,
            year,
            engine,
            displacement,
            style,
            transmission,
            description,
            imageUrl,
        } as Motorcycle;
        return obj;
    });

    const effectiveTotal = payload.total ?? payload.count ?? mapped.length;
    const effectivePage = payload.page ?? page;
    const effectiveLimit = payload.limit ?? limit;
    const hasMore = payload.has_more ?? (effectiveTotal ? (effectivePage * effectiveLimit) < effectiveTotal : false);

    // Diagnóstico adicional: mostrar primeros slugs únicos detectados
    try {
        const uniqueBrands = Array.from(new Set(mapped.map(m => (m as any).brand_slug || m.brand))).slice(0, 15);
        console.log(`🔎 Normalizado -> items:${mapped.length} total:${effectiveTotal} page:${effectivePage} has_more:${hasMore} brands=[${uniqueBrands.join(',')}]`);
    } catch {
        console.log(`🔎 Normalizado -> items:${mapped.length} total:${effectiveTotal} page:${effectivePage} has_more:${hasMore}`);
    }

    return {
        items: mapped,
        total: effectiveTotal,
        page: effectivePage,
        limit: effectiveLimit,
        has_more: hasMore
    };
}

export async function getAllMotorcyclesAccum(current: Motorcycle[], nextPage: number, limit: number): Promise<{ merged: Motorcycle[]; page: number; has_more: boolean; total: number; }> {
    const { items, page, has_more, total } = await getMotorcycles(nextPage, limit);
    // evitar duplicados por id
    const existingIds = new Set(current.map(m => m.id));
    const merged = [...current, ...items.filter(i => !existingIds.has(i.id))];
    return { merged, page, has_more, total };
}

export async function getMotorcycleById(id: string | number): Promise<Motorcycle> {
    const res = await fetch(`${API_URL}/motos/${id}`, {
        cache: 'no-store',
        headers: getAuthHeaders(),
    });
    handle401(res);
    if (!res.ok) throw new Error('Moto no encontrada');
    const moto = await res.json();

    // Normalizar campos clave
    const brandRaw = moto.brand ?? moto.marca ?? '';
    const { name: brand, slug: brand_slug } = canonicalizeBrand(brandRaw);
    const model = moto.model ?? moto.modelo ?? '';
    const price_soles = moto.price_soles ?? moto.precio_soles ?? 0;
    const year = Number(moto.year ?? moto.anio ?? moto.año ?? moto.ano ?? 0) || 0;
    const engine = moto.engine ?? moto.cilindrada ?? '';
    const displacement = moto.displacement ?? moto.cilindrada ?? '';
    const style = moto.style ?? moto.estilo ?? '';
    const transmission = moto.transmission ?? moto.transmision ?? '';
    const description = moto.description ?? moto.descripcion ?? '';

    // Mapear imagen (image_url o imagen)
    let rawImage: string = moto.image_url ?? moto.imagen ?? '';
    let imageUrl = '';
    if (rawImage && String(rawImage).trim()) {
        const val = String(rawImage);
        if (val.startsWith('http://') || val.startsWith('https://')) {
            try { new URL(val); imageUrl = val; } catch { imageUrl = ''; }
        } else if (val.startsWith('/uploads/') || val.startsWith('/')) {
            imageUrl = val;
        }
    }

    return {
        ...moto,
        brand,
        brand_slug,
        model,
        price_soles,
        year,
        engine,
        displacement,
        style,
        transmission,
        description,
        imageUrl,
    } as Motorcycle;
}

export async function getBrands(): Promise<string[]> {
    const res = await fetch(`${API_URL}/marcas`, {
        cache: 'no-store',
        headers: getAuthHeaders(),
    });
    handle401(res);
    if (!res.ok) throw new Error('Error al obtener marcas');
    const rawBrands = await res.json();
    // Normalizar las marcas usando canonicalizeBrand para consistencia
    const normalized = Array.isArray(rawBrands)
        ? rawBrands.map(b => {
            const brandStr = typeof b === 'string' ? b : (b.brand || String(b));
            const { name } = canonicalizeBrand(brandStr);
            return name;
        })
        : [];
    // Eliminar duplicados y ordenar
    return Array.from(new Set(normalized)).sort();
}

// Función para añadir motocicleta usando el endpoint de tu backend
export async function addMotorcycle(data: any): Promise<Motorcycle> {
    const payload = {
        brand: data.brand,
        model: data.model,
        year: data.year,
        engine: data.engine || "N/A",
        displacement: data.displacement || "N/A",
        power: data.power || "N/A",
        price_soles: data.price_soles || 0,
        style: data.style || "N/A",
        transmission: data.transmission || "N/A",
        image_url: data.imageUrl || data.image_url,
        color: data.color || "N/A",
        description: data.description || "N/A",
        is_active: data.is_active !== undefined ? data.is_active : true,
        specs: data.specs || {},
        gallery: data.gallery || [],
        brand_info: data.brand_info || null
    };
    
    const res = await fetch(`${API_URL}/motos`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            ...getAuthHeaders(),
        },
        body: JSON.stringify(payload),
    });
    handle401(res);
    if (!res.ok) throw new Error('Error al añadir motocicleta');
    return await res.json();
}


