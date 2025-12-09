import Link from 'next/link';
import { MapPin, Phone, Mail, Clock } from 'lucide-react';
import type { SVGProps } from "react";

const FacebookIcon = (props: SVGProps<SVGSVGElement>) => (
  <svg xmlns="http://www.w3.org/2000/svg" className="h-7 w-7" fill="#1877F2" viewBox="0 0 24 24" {...props}>
    <path d="M12 2.04C6.5 2.04 2 6.53 2 12.06c0 5.52 4.5 10.02 10 10.02s10-4.5 10-10.02C22 6.53 17.5 2.04 12 2.04zM16 12.36h-2.3v6.93h-3.28v-6.93H8.72V9.6h1.7V7.8c0-1.7 1.02-2.7 2.6-2.7h1.9v2.76h-1.2c-.72 0-.88.34-.88.86v1.2h2.08l-.28 2.76z"/>
  </svg>
);

const InstagramIcon = (props: SVGProps<SVGSVGElement>) => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width="28"
    height="28"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
    {...props}
  >
    <rect x="2" y="2" width="20" height="20" rx="5" ry="5" />
    <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
    <line x1="17.5" y1="6.5" x2="17.51" y2="6.5" />
  </svg>
);

const TikTok = (props: SVGProps<SVGSVGElement>) => (
  <svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid" viewBox="0 0 256 290" width="1em" height="1em" {...props}><path fill="#FF004F" d="M189.72022 104.42148c18.67797 13.3448 41.55932 21.19661 66.27233 21.19661V78.08728c-4.67694.001-9.34196-.48645-13.91764-1.4554v37.41351c-24.71102 0-47.5894-7.85181-66.27232-21.19563v96.99656c0 48.5226-39.35537 87.85513-87.8998 87.85513-18.11308 0-34.94847-5.47314-48.93361-14.85978 15.96175 16.3122 38.22162 26.4315 62.84826 26.4315 48.54742 0 87.90477-39.33253 87.90477-87.85712v-96.99457h-.00199Zm17.16896-47.95275c-9.54548-10.4231-15.81283-23.89299-17.16896-38.78453v-6.11347h-13.18894c3.31982 18.92715 14.64335 35.09738 30.3579 44.898ZM69.67355 225.60685c-5.33316-6.9891-8.21517-15.53882-8.20226-24.3298 0-22.19236 18.0009-40.18631 40.20915-40.18631 4.13885-.001 8.2529.6324 12.19716 1.88328v-48.59308c-4.60943-.6314-9.26154-.89945-13.91167-.80117v37.82253c-3.94726-1.25089-8.06328-1.88626-12.20313-1.88229-22.20825 0-40.20815 17.99196-40.20815 40.1873 0 15.6937 8.99747 29.28075 22.1189 35.89954Z" /><path d="M175.80259 92.84876c18.68293 13.34382 41.5613 21.19563 66.27232 21.19563V76.63088c-13.79353-2.93661-26.0046-10.14114-35.18573-20.16215-15.71554-9.80162-27.03808-25.97185-30.3579-44.898H141.8876v189.84333c-.07843 22.1318-18.04855 40.05229-40.20915 40.05229-13.05889 0-24.66039-6.22169-32.00788-15.8595-13.12044-6.61879-22.1179-20.20683-22.1179-35.89854 0-22.19336 17.9999-40.1873 40.20815-40.1873 4.255 0 8.35614.66217 12.20312 1.88229v-37.82254c-47.69165.98483-86.0473 39.93316-86.0473 87.83429 0 23.91184 9.55144 45.58896 25.05353 61.4276 13.98514 9.38565 30.82053 14.85978 48.9336 14.85978 48.54544 0 87.89981-39.33452 87.89981-87.85612V92.84876h-.00099Z" /><path fill="#00F2EA" d="M242.07491 76.63088V66.51456c-12.4384.01886-24.6326-3.46278-35.18573-10.04683 9.34196 10.22255 21.64336 17.27121 35.18573 20.16315Zm-65.54363-65.06015a67.7881 67.7881 0 0 1-.72869-5.45726V0h-47.83362v189.84531c-.07644 22.12883-18.04557 40.04931-40.20815 40.04931-6.50661 0-12.64987-1.54375-18.09025-4.28677 7.34749 9.63681 18.949 15.8575 32.00788 15.8575 22.15862 0 40.13171-17.9185 40.20915-40.0503V11.57073h34.64368ZM99.96593 113.58077V102.8112c-3.9969-.54602-8.02655-.82003-12.06116-.81805C39.35537 101.99315 0 141.32669 0 189.84531c0 30.41846 15.46735 57.22621 38.97116 72.99536-15.5021-15.83765-25.05353-37.51576-25.05353-61.42661 0-47.90014 38.35466-86.84847 86.0483-87.8333Z" /></svg>
);

const YouTubeIcon = (props: SVGProps<SVGSVGElement>) => (
  <svg xmlns="http://www.w3.org/2000/svg" className="h-7 w-7" fill="#FF0000" viewBox="0 0 24 24" {...props}>
    <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
  </svg>
);

const WhatsApp = (props: SVGProps<SVGSVGElement>) => (
  <svg viewBox="0 0 256 259" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid" {...props}><path d="m67.663 221.823 4.185 2.093c17.44 10.463 36.971 15.346 56.503 15.346 61.385 0 111.609-50.224 111.609-111.609 0-29.297-11.859-57.897-32.785-78.824-20.927-20.927-48.83-32.785-78.824-32.785-61.385 0-111.61 50.224-110.912 112.307 0 20.926 6.278 41.156 16.741 58.594l2.79 4.186-11.16 41.156 41.853-10.464Z" fill="#00E676" /><path d="M219.033 37.668C195.316 13.254 162.531 0 129.048 0 57.898 0 .698 57.897 1.395 128.35c0 22.322 6.278 43.947 16.742 63.478L0 258.096l67.663-17.439c18.834 10.464 39.76 15.347 60.688 15.347 70.453 0 127.653-57.898 127.653-128.35 0-34.181-13.254-66.269-36.97-89.986ZM129.048 234.38c-18.834 0-37.668-4.882-53.712-14.648l-4.185-2.093-40.458 10.463 10.463-39.76-2.79-4.186C7.673 134.63 22.322 69.058 72.546 38.365c50.224-30.692 115.097-16.043 145.79 34.181 30.692 50.224 16.043 115.097-34.18 145.79-16.045 10.463-35.576 16.043-55.108 16.043Zm61.385-77.428-7.673-3.488s-11.16-4.883-18.136-8.371c-.698 0-1.395-.698-2.093-.698-2.093 0-3.488.698-4.883 1.396 0 0-.697.697-10.463 11.858-.698 1.395-2.093 2.093-3.488 2.093h-.698c-.697 0-2.092-.698-2.79-1.395l-3.488-1.395c-7.673-3.488-14.648-7.674-20.229-13.254-1.395-1.395-3.488-2.79-4.883-4.185-4.883-4.883-9.766-10.464-13.253-16.742l-.698-1.395c-.697-.698-.697-1.395-1.395-2.79 0-1.395 0-2.79.698-3.488 0 0 2.79-3.488 4.882-5.58 1.396-1.396 2.093-3.488 3.488-4.883 1.395-2.093 2.093-4.883 1.395-6.976-.697-3.488-9.068-22.322-11.16-26.507-1.396-2.093-2.79-2.79-4.883-3.488H83.01c-1.396 0-2.79.698-4.186.698l-.698.697c-1.395.698-2.79 2.093-4.185 2.79-1.395 1.396-2.093 2.79-3.488 4.186-4.883 6.278-7.673 13.951-7.673 21.624 0 5.58 1.395 11.161 3.488 16.044l.698 2.093c6.278 13.253 14.648 25.112 25.81 35.575l2.79 2.79c2.092 2.093 4.185 3.488 5.58 5.58 14.649 12.557 31.39 21.625 50.224 26.508 2.093.697 4.883.697 6.976 1.395h6.975c3.488 0 7.673-1.395 10.464-2.79 2.092-1.395 3.487-1.395 4.882-2.79l1.396-1.396c1.395-1.395 2.79-2.092 4.185-3.487 1.395-1.395 2.79-2.79 3.488-4.186 1.395-2.79 2.092-6.278 2.79-9.765v-4.883s-.698-.698-2.093-1.395Z" fill="#FFF" /></svg>
);

const Gmail = (props: SVGProps<SVGSVGElement>) => (
  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 49.4 512 399.42" width="1em" height="1em" {...props}><g fill="none" fillRule="evenodd"><g fillRule="nonzero"><path fill="#4285f4" d="M34.91 448.818h81.454V251L0 163.727V413.91c0 19.287 15.622 34.91 34.91 34.91z" /><path fill="#34a853" d="M395.636 448.818h81.455c19.287 0 34.909-15.622 34.909-34.909V163.727L395.636 251z" /><path fill="#fbbc04" d="M395.636 99.727V251L512 163.727v-46.545c0-43.142-49.25-67.782-83.782-41.891z" /></g><path fill="#ea4335" d="M116.364 251V99.727L256 204.455 395.636 99.727V251L256 355.727z" /><path fill="#c5221f" fillRule="nonzero" d="M0 117.182v46.545L116.364 251V99.727L83.782 75.291C49.25 49.4 0 74.04 0 117.18z" /></g></svg>
);

const socialLinks = [
  { name: "Facebook", href: "https://www.facebook.com/profile.php?id=100078232245166", icon: FacebookIcon },
  { name: "Instagram", href: "https://www.instagram.com/motossurtacna/?igsh=NjhjNGhjZjlpbWs%3D#", icon: InstagramIcon },
  { name: "TikTok", href: "https://www.tiktok.com/@motossurtacna?_t=ZS-8yVNjktIUFE&_r=1", icon: TikTok },
  { name: "YouTube", href: "#", icon: YouTubeIcon }
];

const usefulLinks = [
  { href: "/", label: "Inicio" },
  { href: "/catalog", label: "Catálogo de Motos" },
  { href: "/accesorios", label: "Accesorios" },
  { href: "/tiendas", label: "Tiendas" },
  { href: "/fraud-report", label: "Reportar Fraude" }
];

const servicesLinks = [
  { href: "#", label: "Mantenimiento" },
  { href: "/accesorios", label: "Accesorios" },
  { href: "/catalog", label: "Venta de Motos" }
];

const contactInfo = [
  { href: "https://maps.app.goo.gl/9VQXypNvU9Eud4oU7", text: "Av. la Cultura 23004, Tacna 23004", icon: MapPin, color: "text-red-500" },
  { href: "tel:+51983504654", text: "+51 983 504 654", icon: Phone, color: "text-blue-500" },
  { href: "https://wa.me/c/51983504654", text: "WhatsApp Directo", icon: WhatsApp, color: "text-green-500" },
  { href: "mailto:alex.tello995@gmail.com", text: "alex.tello995@gmail.com", icon: Gmail, color: "text-gray-400" }
];

export default function Footer() {
  return (
    <footer className="bg-gradient-to-t from-neutral-900 to-neutral-700 text-white font-body font-semibold">
      <div className="container mx-auto max-w-[1280px] px-6 md:px-10 py-16">
        <div className="grid grid-cols-1 md:grid-cols-12 gap-y-[32px] md:gap-y-[40px] md:gap-x-[64px] items-start">
          
          <div className="col-span-12 md:col-span-4 xl:col-span-4 space-y-5 md:items-center md:text-center">
            <Link href="/" className="flex justify-center items-center">
              <span className="inline-flex items-center justify-center rounded-md bg-transparent p-0 shadow-none">
                <img src="/assets/logomotossur/file.svg" alt="Logo Motossur" className="h-24 w-auto" />
              </span>
            </Link>
            <p className="text-base text-white/90">"Motor, calle y actitud. Eso es MOTOSSUR."</p>
            <h4 className="font-headline text-lg text-white tracking-wider font-extrabold mt-2">Horario</h4>
            <div className="flex items-start gap-3 pt-1 md:justify-center">
              <Clock className="h-5 w-5 mt-1 flex-shrink-0 text-red-600" />
              <div className="text-sm text-white/90">
                <p><strong>Lunes a Viernes:</strong> 8:00 AM - 8:00 PM</p>
                <p><strong>Sábado:</strong> 9:00 AM - 6:00 PM</p>
                <p><strong>Domingo:</strong> 9:00 AM - 4:00 PM</p>
              </div>
            </div>
          </div>
          
          <div className="col-span-12 md:col-span-3 xl:col-span-3 space-y-5 md:border-l md:border-white/10 md:pl-[64px]">
            <h4 className="font-headline text-lg text-white tracking-wider font-extrabold">Enlaces Útiles</h4>
            <ul className="space-y-2">
              {usefulLinks.map(link => (
                <li key={link.label}>
                  <Link
                    href={link.href}
                    className="relative inline-block text-sm text-white/90 transition-colors duration-300 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-600/50 rounded-sm after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-red-600/70 after:transition-all after:duration-300 hover:after:w-full hover:text-white"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div className="col-span-12 md:col-span-3 xl:col-span-3 space-y-5 md:border-l md:border-white/10 md:pl-[64px]">
            <h4 className="font-headline text-lg text-white tracking-wider font-extrabold">Contacto</h4>
            <ul className="space-y-3.5">
              {contactInfo.map(item => (
                <li key={item.text}>
                  <a 
                    href={item.href} 
                    target="_blank" 
                    rel="noopener noreferrer" 
                    className="flex items-center gap-3 group focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-600/50 rounded-sm"
                  >
                    <span className="inline-flex h-7 w-7 items-center justify-center">
                      <item.icon className={`h-5 w-5 ${item.color}`} />
                    </span>
                    <span className="relative inline-block text-sm text-white/90 transition-colors duration-300 after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-red-600/70 after:transition-all after:duration-300 group-hover:after:w-full group-hover:text-white">
                      {item.text}
                    </span>
                  </a>
                </li>
              ))}
            </ul>
          </div>
          
          <div className="col-span-12 md:col-span-2 xl:col-span-2 space-y-5 md:border-l md:border-white/10 md:pl-[64px]">
            <h4 className="font-headline text-lg text-white tracking-wider font-extrabold">Síguenos</h4>
            <div className="flex items-center space-x-6">
              {socialLinks.map(link => (
                <a 
                  key={link.name} 
                  href={link.href}
                  target="_blank" 
                  rel="noopener noreferrer" 
                  className="text-white/70 hover:scale-110 transition-transform duration-300"
                  aria-label={link.name}
                >
                  <link.icon />
                </a>
              ))}
            </div>
             <div className="pt-4 space-y-3">
                 <h4 className="font-headline text-lg text-white tracking-wider font-extrabold">Servicios</h4>
                 <ul className="space-y-2">
                  {servicesLinks.map(link => (
                    <li key={link.label}>
                      <Link
                        href={link.href}
                        className="relative inline-block text-sm text-white/90 transition-colors duration-300 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-600/50 rounded-sm after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-red-600/70 after:transition-all after:duration-300 hover:after:w-full hover:text-white"
                      >
                        {link.label}
                      </Link>
                    </li>
                  ))}
                </ul>
            </div>
          </div>
        </div>
        
        <div className="mt-12 pt-8 border-t border-white/20 text-center">
          <div className="flex flex-col items-center justify-center gap-2 text-xs text-white/80">
            <div className="text-sm font-semibold">
                Varnox Tech.
            </div>
            <span>
              © 2025 Todos los derechos reservados.
            </span>
          </div>
        </div>
      </div>
    </footer>
  );
}
