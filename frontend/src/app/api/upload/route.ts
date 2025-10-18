import { NextRequest, NextResponse } from 'next/server';

// Esta ruta actúa como proxy hacia el backend FastAPI para guardar las imágenes allí.
// Así, las URLs devueltas (/uploads/...) serán servidas por el backend y no fallarán en producción.
export async function POST(request: NextRequest) {
  try {
    const formData = await request.formData();
    const file: File | null = formData.get('file') as unknown as File;

    if (!file) {
      return NextResponse.json({ success: false, message: 'No se encontró archivo' });
    }

    // Revalidación básica de tipo y tamaño (opcional, el backend también valida)
    const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp', 'image/avif'];
    if (!validTypes.includes(file.type)) {
      return NextResponse.json({ success: false, message: 'Tipo de archivo no válido. Solo JPG, PNG, WEBP, AVIF' });
    }
    if (file.size > 5 * 1024 * 1024) {
      return NextResponse.json({ success: false, message: 'El archivo es demasiado grande. Máximo 5MB' });
    }

    // Preparar FormData a reenviar al backend
    const forward = new FormData();
    forward.append('file', file, (file as any).name || 'upload');

    const backendOrigin = process.env.BACKEND_ORIGIN || 'http://localhost:8000';
    const resp = await fetch(`${backendOrigin}/upload`, {
      method: 'POST',
      body: forward as any,
      // No añadimos cabeceras Content-Type manualmente; el navegador las compone con boundary
    });

    const json = await resp.json().catch(() => ({ success: false, message: 'Respuesta inválida del backend' }));
    if (!resp.ok) {
      return NextResponse.json(json, { status: resp.status });
    }
    return NextResponse.json(json);
  } catch (error) {
    console.error('Error proxy upload:', error);
    return NextResponse.json({ success: false, message: 'Error interno del servidor' }, { status: 500 });
  }
}
