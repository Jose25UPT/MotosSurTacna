// API_URL fijo a un proxy interno para evitar CORS y contenido mixto en Vercel.
// Se configura un rewrite en next.config.ts para redirigir /api/* al BACKEND_ORIGIN.
export const API_URL = '/api';
