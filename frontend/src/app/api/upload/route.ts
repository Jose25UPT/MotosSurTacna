import { NextRequest, NextResponse } from 'next/server';
import { writeFile } from 'fs/promises';
import path from 'path';

export async function POST(request: NextRequest) {
  try {
    const data = await request.formData();
    const file: File | null = data.get('file') as unknown as File;

    if (!file) {
      return NextResponse.json({ success: false, message: 'No se encontró archivo' });
    }

    // Validar tipo de archivo
    const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp', 'image/avif'];
    if (!validTypes.includes(file.type)) {
      return NextResponse.json({ 
        success: false, 
        message: 'Tipo de archivo no válido. Solo se permiten: JPG, PNG, WEBP, AVIF' 
      });
    }

    // Validar tamaño (máximo 5MB)
    if (file.size > 5 * 1024 * 1024) {
      return NextResponse.json({ 
        success: false, 
        message: 'El archivo es demasiado grande. Máximo 5MB' 
      });
    }

    const bytes = await file.arrayBuffer();
    const buffer = Buffer.from(bytes);

    // Generar nombre único para el archivo
    const timestamp = Date.now();
    const extension = path.extname(file.name);
    const filename = `${timestamp}${extension}`;
    
    // Ruta donde se guardará el archivo
    const uploadsPath = path.join(process.cwd(), 'public', 'uploads', 'motos');
    const filePath = path.join(uploadsPath, filename);

    // Guardar el archivo
    await writeFile(filePath, buffer);

    // Retornar la ruta relativa que se guardará en la BD
    const relativePath = `/uploads/motos/${filename}`;

    return NextResponse.json({ 
      success: true, 
      message: 'Imagen subida exitosamente',
      imagePath: relativePath 
    });

  } catch (error) {
    console.error('Error subiendo imagen:', error);
    return NextResponse.json({ 
      success: false, 
      message: 'Error interno del servidor' 
    });
  }
}
