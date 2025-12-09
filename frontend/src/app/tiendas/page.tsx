import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { MapPin, Phone, Clock } from "lucide-react";

export default function TiendasPage() {
  return (
    <div className="min-h-screen bg-white text-black">
      {/* HERO BLANCO CON IMAGEN DE FONDO AÚN MÁS VISIBLE */}
      <section className="relative w-full h-[40vh] md:h-[50vh] flex items-center justify-center bg-white overflow-hidden">
        {/* Imagen de fondo sutil */}
        <img
          src="/assets/portada.webp"
          alt="Hero Motossur"
          className="absolute inset-0 w-full h-full object-cover opacity-60"
        />
        {/* Velo blanco para mantener contraste */}
        <div className="absolute inset-0 bg-white/20"></div>
        <div className="relative text-center px-4 max-w-4xl">
          <div className="mb-4">
            <span className="inline-block px-6 py-2 bg-red-600 text-white font-bold text-sm uppercase tracking-wider rounded-full shadow">
              Motossur Tacna
            </span>
          </div>
          <h1 className="text-5xl md:text-7xl font-extrabold mb-6 tracking-tight leading-tight text-neutral-900 drop-shadow-sm">
            Nuestra <span className="text-red-600">Tienda</span>
          </h1>
          <p className="text-xl md:text-2xl text-neutral-700 max-w-2xl mx-auto">
            Más de 10 años sirviendo a la comunidad tacneña con las mejores motocicletas
          </p>
          <div className="flex flex-wrap justify-center gap-4 mt-8">
            <div className="bg-red-50 rounded-lg px-6 py-3 border border-red-200">
              <span className="text-red-600 font-bold text-lg">+1000</span>
              <span className="text-neutral-700 ml-2">Motos Vendidas</span>
            </div>
            <div className="bg-red-50 rounded-lg px-6 py-3 border border-red-200">
              <span className="text-red-600 font-bold text-lg">10+</span>
              <span className="text-neutral-700 ml-2">Años de Experiencia</span>
            </div>
          </div>
        </div>
      </section>

      {/* CONTENIDO PRINCIPAL */}
      <div className="container mx-auto px-4 py-16 md:py-20">
        {/* Título de sección */}
        <div className="text-center mb-16">
          <h2 className="text-4xl md:text-5xl font-bold text-neutral-900 mb-4">
            Información de <span className="text-red-500">Contacto</span>
          </h2>
          <p className="text-xl text-neutral-600 max-w-2xl mx-auto">
            Te esperamos en nuestra tienda principal con la mejor atención personalizada
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 lg:gap-12 items-start">
          <div className="lg:sticky lg:top-28">
            <Card className="hover:shadow-2xl transition-all duration-300 border border-neutral-200 shadow-xl bg-gradient-to-br from-white to-neutral-50 text-neutral-900">
              <CardHeader className="bg-gradient-to-r from-red-600 to-red-700 text-white rounded-t-lg">
                <CardTitle className="text-3xl font-bold flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center">
                    <MapPin className="h-6 w-6" />
                  </div>
                  Motossur Tacna
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-6 p-8 text-neutral-800">
                <div className="flex items-start gap-4 p-4 bg-red-50 rounded-xl border-l-4 border-red-600">
                  <MapPin className="h-6 w-6 text-red-600 mt-1 flex-shrink-0" />
                  <div>
                    <p className="font-semibold text-neutral-900 mb-1">Dirección</p>
                    <p className="text-neutral-700">Av. la Cultura 23004, Tacna 23004</p>
                  </div>
                </div>
                
                <div className="flex items-center gap-4 p-4 bg-green-50 rounded-xl border-l-4 border-green-500">
                  <Phone className="h-6 w-6 text-green-600 flex-shrink-0" />
                  <div>
                    <p className="font-semibold text-neutral-900 mb-1">Teléfono</p>
                    <p className="text-neutral-800 text-lg font-medium">+51 983 504 654</p>
                  </div>
                </div>
                
                <div className="flex items-start gap-4 p-4 bg-blue-50 rounded-xl border-l-4 border-blue-500">
                  <Clock className="h-6 w-6 text-blue-500 mt-1 flex-shrink-0" />
                  <div className="w-full">
                    <p className="font-semibold text-neutral-900 mb-3">Horarios de Atención</p>
                    <div className="space-y-2">
                      <div className="flex justify-between items-center">
                        <span className="font-medium text-neutral-800">Lunes a Viernes:</span>
                        <span className="text-neutral-700 font-semibold">8:00 AM - 8:00 PM</span>
                      </div>
                      <div className="flex justify-between items-center">
                        <span className="font-medium text-neutral-800">Sábado:</span>
                        <span className="text-neutral-700 font-semibold">9:00 AM - 6:00 PM</span>
                      </div>
                      <div className="flex justify-between items-center">
                        <span className="font-medium text-neutral-800">Domingo:</span>
                        <span className="text-neutral-700 font-semibold">9:00 AM - 4:00 PM</span>
                      </div>
                    </div>
                  </div>
                </div>
                
                {/* Botón de WhatsApp */}
                <div className="pt-4">
                  <a 
                    href="https://wa.me/51983504654?text=Hola,%20me%20interesa%20información%20sobre%20sus%20motocicletas"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="w-full flex items-center justify-center gap-3 bg-green-500 hover:bg-green-600 text-white font-bold py-4 px-6 rounded-xl transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1"
                  >
                    <Phone className="h-5 w-5" />
                    Contactar por WhatsApp
                  </a>
                </div>
              </CardContent>
            </Card>
          </div>
          
          {/* MAPA MEJORADO */}
          <div className="w-full">
            <div className="bg-white rounded-2xl shadow-2xl overflow-hidden border border-gray-100">
              <div className="bg-gradient-to-r from_red-600 to_red-700 p-6">
                <h3 className="text-2xl font-bold text-white flex items-center gap-3">
                  <MapPin className="h-6 w-6" />
                  Nuestra Ubicación
                </h3>
                <p className="text-neutral-700 mt-2">Encuéntranos fácilmente en el corazón de Tacna</p>
              </div>
              <div className="relative h-[350px] md:h-[500px] lg:h-[600px]">
                <iframe
                  src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3789.97123910543!2d-70.2483168248135!3d-18.00392374662664!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x915acf615a1a361d%3A0x6a1c1d4f4e3c5f49!2sMotossur%20Tacna!5e0!3m2!1sen!2sus!4v1752741559897!5m2!1sen!2sus"
                  width="100%"
                  height="100%"
                  style={{ border: 0 }}
                  allowFullScreen={true}
                  loading="lazy"
                  referrerPolicy="no-referrer-when-downgrade"
                  title="Ubicación de Motossur Tacna"
                  className="w-full h-full"
                ></iframe>
              </div>
            </div>
          </div>
        </div>
        
        {/* SECCIÓN ADICIONAL DE SERVICIOS */}
        <div className="bg-gradient-to-r from-red-600 to-red-700 text-white py-16 mt-20 rounded-3xl">
          <div className="container mx-auto px-4 text-center">
            <h3 className="text-3xl md:text-4xl font-bold mb-8">¿Por qué elegirnos?</h3>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 border border-white/20">
                <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Clock className="h-8 w-8" />
                </div>
                <h4 className="text-xl font-bold mb-2">Experiencia</h4>
                <p className="text-white/80">Más de 10 años en el mercado tacneño</p>
              </div>
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 border border-white/20">
                <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Phone className="h-8 w-8" />
                </div>
                <h4 className="text-xl font-bold mb-2">Atención 24/7</h4>
                <p className="text-white/80">Soporte y asesoría cuando lo necesites</p>
              </div>
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 border border-white/20">
                <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4">
                  <MapPin className="h-8 w-8" />
                </div>
                <h4 className="text-xl font-bold mb-2">Ubicación Central</h4>
                <p className="text-white/80">Fácil acceso en pleno centro de Tacna</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
