import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { ShieldAlert } from "lucide-react";

interface FraudWarningDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export default function FraudWarningDialog({ open, onOpenChange }: FraudWarningDialogProps) {
  return (
    <AlertDialog open={open} onOpenChange={onOpenChange}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <div className="flex justify-center mb-4">
            <ShieldAlert className="h-16 w-16 text-destructive" />
          </div>
          <AlertDialogTitle className="text-center text-2xl font-bold">
            ¡Aviso Importante de Seguridad!
          </AlertDialogTitle>
          <AlertDialogDescription asChild>
            <div className="text-center text-base py-2 space-y-2 text-muted-foreground">
              <div className="font-semibold text-foreground">
                ¡Bienvenido a Motossur Tacna!
              </div>
              <div className="mt-2">
                Para proteger tu compra, te informamos que este es nuestro <strong className="text-primary">ÚNICO SITIO WEB OFICIAL</strong>. No tenemos otras páginas ni perfiles de venta en redes sociales no vinculados a este sitio.
              </div>
              <div className="mt-2">
                Desconfía de ofertas en otros lugares y nunca realices pagos fuera de nuestros canales oficiales.
              </div>
            </div>
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogAction className="w-full">Entendido</AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
