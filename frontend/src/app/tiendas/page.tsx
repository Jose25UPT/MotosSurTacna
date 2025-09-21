import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { MapPin, Phone, Clock } from "lucide-react";

export default function TiendasPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-yellow-50 via-white to-yellow-100">
      {/* HERO SECTION CON DISEÑO MEJORADO */}
      <div className="relative w-full h-[60vh] md:h-[70vh] overflow-hidden">
        {/* Imagen de fondo */}
        <img
          src="https://scontent.flim2-1.fna.fbcdn.net/v/t39.30808-6/487692578_1105013185003786_3339753605493780961_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGDhkZzu89jRh8ksEm0Iga3NP3YzVA_Z1I0_djNUD9nUn431xXj1I1CLYoootm-DxPLt5-v2cnDtLqZFYm9zKBL&_nc_ohc=dYT9j0doY0MQ7kNvwESrhyc&_nc_oc=AdmdQWZsFuBk4G5D5JRTSKs4ZTQCrpdy86u-1vpfOMwkvmb40j5dzHoVz4-qMQ1USHqQegVzlD7Or6zGqeUh5PYH&_nc_zt=23&_nc_ht=scontent.flim2-1.fna&_nc_gid=oKuQLe9l18OMjb90lbsirg&oh=00_AfW4uf5u5ygwieagrtGoMKS6NSrB61QiUit6gdUE_Oq7eA&oe=68A12FF4"
          alt="Hero Motossur"
          className="w-full h-full object-cover brightness-50"
        />
        
        {/* Overlay con gradiente */}
        <div className="absolute inset-0 bg-gradient-to-r from-black/70 via-black/50 to-yellow-900/60"></div>
        
        {/* Contenido del hero */}
        <div className="absolute inset-0 flex items-center justify-center">
          <div className="text-center text-white px-4 max-w-4xl">
            <div className="mb-6">
              <span className="inline-block px-6 py-2 bg-yellow-500/90 text-black font-bold text-sm uppercase tracking-wider rounded-full shadow-lg">
                Motossur Tacna
              </span>
            </div>
            <h1 className="text-5xl md:text-7xl font-extrabold mb-6 tracking-tight leading-tight">
              Nuestra <span className="text-yellow-400">Tienda</span>
            </h1>
            <p className="text-xl md:text-2xl text-gray-200 mb-8 leading-relaxed">
              Más de 10 años sirviendo a la comunidad tacneña con las mejores motocicletas
            </p>
            <div className="flex flex-wrap justify-center gap-4">
              <div className="bg-white/10 backdrop-blur-sm rounded-lg px-6 py-3 border border-white/20">
                <span className="text-yellow-400 font-bold text-lg">+1000</span>
                <span className="text-white ml-2">Motos Vendidas</span>
              </div>
              <div className="bg-white/10 backdrop-blur-sm rounded-lg px-6 py-3 border border-white/20">
                <span className="text-yellow-400 font-bold text-lg">10+</span>
                <span className="text-white ml-2">Años de Experiencia</span>
              </div>
            </div>
          </div>
        </div>
        
        {/* Decoración con formas geométricas */}
        <div className="absolute top-10 right-10 w-20 h-20 bg-yellow-400/20 rounded-full blur-xl"></div>
        <div className="absolute bottom-20 left-10 w-32 h-32 bg-yellow-300/10 rounded-full blur-2xl"></div>
      </div>

      {/* CONTENIDO PRINCIPAL */}
      <div className="container mx-auto px-4 py-16 md:py-20">
        {/* Título de sección */}
        <div className="text-center mb-16">
          <h2 className="text-4xl md:text-5xl font-bold text-gray-800 mb-4">
            Información de <span className="text-yellow-600">Contacto</span>
          </h2>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto">
            Te esperamos en nuestra tienda principal con la mejor atención personalizada
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 lg:gap-12 items-start">
          <div className="lg:sticky lg:top-28">
            <Card className="hover:shadow-2xl transition-all duration-300 border-0 shadow-xl bg-gradient-to-br from-white to-yellow-50/50 backdrop-blur-sm">
              <CardHeader className="bg-gradient-to-r from-yellow-500 to-yellow-600 text-white rounded-t-lg">
                <CardTitle className="text-3xl font-bold flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center">
                    <MapPin className="h-6 w-6" />
                  </div>
                  Motossur Tacna
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-6 p-8 text-gray-700">
                <div className="flex items-start gap-4 p-4 bg-yellow-50 rounded-xl border-l-4 border-yellow-400">
                  <MapPin className="h-6 w-6 text-yellow-600 mt-1 flex-shrink-0" />
                  <div>
                    <p className="font-semibold text-gray-800 mb-1">Dirección</p>
                    <p className="text-gray-600">Av. la Cultura 23004, Tacna 23004</p>
                  </div>
                </div>
                
                <div className="flex items-center gap-4 p-4 bg-green-50 rounded-xl border-l-4 border-green-400">
                  <Phone className="h-6 w-6 text-green-600 flex-shrink-0" />
                  <div>
                    <p className="font-semibold text-gray-800 mb-1">Teléfono</p>
                    <p className="text-gray-600 text-lg font-medium">+51 983 504 654</p>
                  </div>
                </div>
                
                <div className="flex items-start gap-4 p-4 bg-blue-50 rounded-xl border-l-4 border-blue-400">
                  <Clock className="h-6 w-6 text-blue-600 mt-1 flex-shrink-0" />
                  <div className="w-full">
                    <p className="font-semibold text-gray-800 mb-3">Horarios de Atención</p>
                    <div className="space-y-2">
                      <div className="flex justify-between items-center">
                        <span className="font-medium text-gray-700">Lunes a Viernes:</span>
                        <span className="text-gray-600 font-semibold">8:00 AM - 8:00 PM</span>
                      </div>
                      <div className="flex justify-between items-center">
                        <span className="font-medium text-gray-700">Sábado:</span>
                        <span className="text-gray-600 font-semibold">9:00 AM - 6:00 PM</span>
                      </div>
                      <div className="flex justify-between items-center">
                        <span className="font-medium text-gray-700">Domingo:</span>
                        <span className="text-gray-600 font-semibold">9:00 AM - 4:00 PM</span>
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
              <div className="bg-gradient-to-r from-yellow-500 to-yellow-600 p-6">
                <h3 className="text-2xl font-bold text-white flex items-center gap-3">
                  <MapPin className="h-6 w-6" />
                  Nuestra Ubicación
                </h3>
                <p className="text-yellow-100 mt-2">Encuéntranos fácilmente en el corazón de Tacna</p>
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
        <div className="bg-gradient-to-r from-yellow-500 to-yellow-600 text-white py-16 mt-20 rounded-3xl">
          <div className="container mx-auto px-4 text-center">
            <h3 className="text-3xl md:text-4xl font-bold mb-8">¿Por qué elegirnos?</h3>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 border border-white/20">
                <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Clock className="h-8 w-8" />
                </div>
                <h4 className="text-xl font-bold mb-2">Experiencia</h4>
                <p className="text-yellow-100">Más de 10 años en el mercado tacneño</p>
              </div>
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 border border-white/20">
                <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Phone className="h-8 w-8" />
                </div>
                <h4 className="text-xl font-bold mb-2">Atención 24/7</h4>
                <p className="text-yellow-100">Soporte y asesoría cuando lo necesites</p>
              </div>
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 border border-white/20">
                <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4">
                  <MapPin className="h-8 w-8" />
                </div>
                <h4 className="text-xl font-bold mb-2">Ubicación Central</h4>
                <p className="text-yellow-100">Fácil acceso en pleno centro de Tacna</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
