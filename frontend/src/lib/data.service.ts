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

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
console.log('🔗 API_URL configurada:', API_URL);

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

export async function getMotorcycles(): Promise<Motorcycle[]> {
    console.log('🌐 Haciendo petición a:', `${API_URL}/motos`);
    const res = await fetch(`${API_URL}/motos`, {
        cache: 'no-store',
        headers: getAuthHeaders(),
    });
    console.log('📡 Respuesta recibida. Status:', res.status, 'OK:', res.ok);
    handle401(res);
    if (!res.ok) throw new Error('Error al obtener motos');
    const motorcycles = await res.json();
    console.log('🔢 Motos parseadas del JSON:', motorcycles?.length || 0);
    
    // Mapear image_url a imageUrl y construir URL completa
    return motorcycles.map((moto: any) => {
        let imageUrl = '';
        
        if (moto.image_url && moto.image_url.trim()) {
            // Si ya es una URL completa (http/https), usarla tal como está
            if (moto.image_url.startsWith('http://') || moto.image_url.startsWith('https://')) {
                // Verificar si la URL externa es válida
                try {
                    new URL(moto.image_url);
                    imageUrl = moto.image_url;
                } catch {
                    console.warn(`URL externa inválida para moto ${moto.id}: ${moto.image_url}`);
                    imageUrl = '';
                }
            } else if (moto.image_url.startsWith('/uploads/')) {
                // Si es una ruta relativa local, construir URL completa
                imageUrl = `${API_URL}${moto.image_url}`;
            }
        }
        
        return {
            ...moto,
            imageUrl,
            price_soles: moto.price_soles || 0
        };
    });
}

export async function getMotorcycleById(id: string | number): Promise<Motorcycle> {
    const res = await fetch(`${API_URL}/motos/${id}`, {
        cache: 'no-store',
        headers: getAuthHeaders(),
    });
    handle401(res);
    if (!res.ok) throw new Error('Moto no encontrada');
    const moto = await res.json();
    
    // Mapear image_url a imageUrl y construir URL completa
    let imageUrl = '';
    
    if (moto.image_url && moto.image_url.trim()) {
        // Si ya es una URL completa (http/https), usarla tal como está
        if (moto.image_url.startsWith('http://') || moto.image_url.startsWith('https://')) {
            // Verificar si la URL externa es válida
            try {
                new URL(moto.image_url);
                imageUrl = moto.image_url;
            } catch {
                console.warn(`URL externa inválida para moto ${moto.id}: ${moto.image_url}`);
                imageUrl = '';
            }
        } else if (moto.image_url.startsWith('/uploads/')) {
            // Si es una ruta relativa local, construir URL completa
            imageUrl = `${API_URL}${moto.image_url}`;
        }
    }
    
    return {
        ...moto,
        imageUrl,
        price_soles: moto.price_soles || 0
    };
}

export async function getBrands(): Promise<string[]> {
    const res = await fetch(`${API_URL}/marcas`, {
        cache: 'no-store',
        headers: getAuthHeaders(),
    });
    handle401(res);
    if (!res.ok) throw new Error('Error al obtener marcas');
    return await res.json();
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


