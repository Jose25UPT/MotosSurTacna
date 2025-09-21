import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Wrench } from "lucide-react";

export default function AccesoriosPage() {
  return (
    <div className="container mx-auto px-4 py-12 text-center">
      <div className="mx-auto max-w-2xl">
        <Wrench className="mx-auto h-16 w-16 text-primary mb-6" />
        <h1 className="text-4xl font-bold tracking-tight mb-4">
          Accesorios Próximamente
        </h1>
        <p className="text-xl text-muted-foreground mb-8">
          Estamos trabajando para traerte los mejores accesorios para tu motocicleta.
          ¡Vuelve pronto para descubrir nuestra selección de cascos, guantes, chaquetas y mucho más!
        </p>
        <Card className="text-left bg-secondary/30">
          <CardHeader>
            <CardTitle>Mantente Informado</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">
              Sigue nuestras redes sociales o suscríbete a nuestro boletín para ser el primero en saber cuándo lanzamos nuestra nueva línea de accesorios.
            </p>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
