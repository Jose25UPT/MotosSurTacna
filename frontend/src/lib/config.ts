// Configuración dinámica de API URL
// Esta configuración funciona tanto en desarrollo como en producción

function getApiUrl(): string {
  // Si estamos en el navegador (lado cliente)
  if (typeof window !== 'undefined') {
    const hostname = window.location.hostname;
    
    // Si estamos en localhost, usar localhost
    if (hostname === 'localhost' || hostname === '127.0.0.1') {
      return 'http://localhost:8000';
    }
    
    // Si estamos en el VPS, usar la IP del VPS
    if (hostname === '138.197.218.131') {
      return 'http://138.197.218.131:8000';
    }
    
    // Fallback para cualquier otro dominio
    return `http://${hostname}:8000`;
  }
  
  // Si estamos en el servidor (lado servidor)
  return process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
}

export const API_URL = getApiUrl();

// Log para debugging
console.log('🔗 API_URL configurada dinámicamente:', API_URL);
console.log('🌍 Hostname actual:', typeof window !== 'undefined' ? window.location.hostname : 'servidor');