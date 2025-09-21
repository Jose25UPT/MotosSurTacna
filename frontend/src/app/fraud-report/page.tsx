import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { ShieldAlert } from "lucide-react";

export default function FraudReportPage() {
  return (
    <div className="container mx-auto max-w-4xl px-4 py-8 md:py-12">
      <Card className="shadow-lg">
        <CardHeader className="text-center">
          <div className="mx-auto bg-primary/10 p-3 rounded-full w-fit mb-4">
             <ShieldAlert className="h-10 w-10 text-primary" />
          </div>
          <CardTitle className="text-3xl font-bold">Reportar Fraude o Estafas</CardTitle>
          <CardDescription className="text-lg mt-2">
            Tu seguridad es nuestra prioridad. Por favor, ayúdanos a mantener la comunidad segura.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-6 text-base text-muted-foreground leading-relaxed">
          <div>
            En MotoCentral, estamos comprometidos a proporcionar una plataforma segura y confiable para todos los entusiastas de las motocicletas. Si encuentras algún listado sospechoso, vendedores fraudulentos o intentos de estafa, por favor repórtalo inmediatamente.
          </div>
          <div>
            <h3 className="text-xl font-semibold text-foreground mb-2">Cómo Reportar un Problema</h3>
            <ol className="list-decimal list-inside space-y-2">
              <li>
                <strong>Reúne Información:</strong> Recopila toda la información posible sobre el listado o usuario sospechoso. Esto incluye el modelo de la motocicleta, nombre del vendedor, detalles de contacto y una descripción de la actividad sospechosa.
              </li>
              <li>
                <strong>Toma Capturas de Pantalla:</strong> Si es posible, toma capturas de pantalla del listado, la conversación o cualquier otra evidencia relevante.
              </li>
              <li>
                <strong>Contáctanos Directamente:</strong> Envía toda la información recopilada a nuestro equipo de soporte por correo electrónico a{' '}
                <a href="mailto:support@motocentral.example.com" className="text-primary font-medium hover:underline">
                  support@motocentral.example.com
                </a>.
              </li>
              <li>
                <strong>Cesa la Comunicación:</strong> No te involucres más con el usuario sospechoso. No compartas información personal ni realices ningún pago.
              </li>
            </ol>
          </div>
           <div>
            <h3 className="text-xl font-semibold text-foreground mb-2">Qué Hacemos</h3>
            <p>
              Nuestro equipo investigará tu reporte a fondo y tomará las medidas apropiadas, que pueden incluir la eliminación del listado, la prohibición del usuario y, si es necesario, la denuncia del incidente a las autoridades policiales. Tu identidad se mantendrá confidencial durante todo el proceso.
            </p>
          </div>
          <p className="font-semibold text-center text-foreground pt-4">
            Gracias por ayudarnos a mantener un mercado seguro.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
