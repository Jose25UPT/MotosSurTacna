import React, { useState, useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { updateMotorcycle } from "@/lib/data.service";
import { Upload, X } from "lucide-react";
import Image from "next/image";

const technicalFields = [
  { key: 'suspension', label: 'Suspensión' },
  { key: 'telescopic_forks', label: 'Horquillas telescópicas' },
  { key: 'length', label: 'Largo' },
  { key: 'width', label: 'Ancho' },
  { key: 'height', label: 'Alto' },
  { key: 'max_speed', label: 'Velocidad máxima' },
  { key: 'max_torque', label: 'Torque máximo' },
  { key: 'brakes', label: 'Frenos' },
  { key: 'fuel_capacity', label: 'Capacidad de combustible' },
  { key: 'tires', label: 'Llantas' },
  { key: 'start_type', label: 'Tipo de arranque' },
  { key: 'tank', label: 'Tanque' },
  { key: 'dashboard', label: 'Tablero' },
  { key: 'ohc', label: 'OHC' },
  { key: 'digital_dashboard', label: 'Tablero digital' },
  { key: 'alarm', label: 'Alarma' },
  { key: 'ignition', label: 'Encendido' },
  { key: 'usb', label: 'USB' },
  { key: 'led_lights', label: 'Luces LED' },
  { key: 'gearbox', label: 'Caja de cambios' },
];

const schema = z.object({
  brand: z.string().min(1),
  model: z.string().min(1),
  year: z.coerce.number().min(1980),
  engine: z.string().min(1),
  displacement: z.string().min(1),
  power: z.string().min(1),
  price_soles: z.coerce.number().min(0),
  style: z.string().min(1),
  transmission: z.string().min(1),
  imageUrl: z.string().min(1),
  color: z.string().min(1),
  description: z.string().min(1),
  is_active: z.boolean(),
});

type FormValues = z.infer<typeof schema>;

type EditMotorcycleDialogProps = {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  initialData: any;
  onSave: (updated: any) => void;
};

export default function EditMotorcycleDialog({ open, onOpenChange, initialData, onSave }: EditMotorcycleDialogProps) {
  const safeData = initialData || {};
  const { toast } = useToast();
  const [gallery, setGallery] = useState<string[]>(safeData.gallery || []);
  const [specs, setSpecs] = useState<{ key: string; value: string }[]>(
    technicalFields.map(f => ({ key: f.key, value: safeData.specs?.[f.key] || "" }))
  );
  const [isUploading, setIsUploading] = useState(false);
  const [previewImage, setPreviewImage] = useState<string>('');
  
  const form = useForm<FormValues>({
    resolver: zodResolver(schema),
    defaultValues: {
      brand: safeData.brand || "",
      model: safeData.model || "",
      year: safeData.year || new Date().getFullYear(),
      engine: safeData.engine || "",
      displacement: safeData.displacement || "",
      power: safeData.power || "",
      price_soles: safeData.price_soles || 0,
      style: safeData.style || "",
      transmission: safeData.transmission || "",
      imageUrl: safeData.image_url || safeData.imageUrl || "",
      color: safeData.color || "",
      description: safeData.description || "",
      is_active: safeData.is_active ?? true,
    },
  });

  // Función para subir imagen principal
  const handleImageUpload = async (file: File) => {
    if (!file) return;

    setIsUploading(true);
    const formDataUpload = new FormData();
    formDataUpload.append('file', file);

    try {
      const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
      const response = await fetch(`${API_URL}/upload`, {
        method: 'POST',
        body: formDataUpload,
      });

      const result = await response.json();

      if (result.success) {
        form.setValue('imageUrl', result.imagePath);
        setPreviewImage(result.imagePath);
        toast({ title: "Imagen subida", description: "Imagen principal actualizada exitosamente." });
      } else {
        toast({ title: "Error", description: result.message || 'Error subiendo imagen', variant: "destructive" });
      }
    } catch (error) {
      console.error('Error uploading image:', error);
      toast({ title: "Error", description: 'Error subiendo imagen', variant: "destructive" });
    } finally {
      setIsUploading(false);
    }
  };

  // Función para subir múltiples imágenes a la galería
  const handleGalleryUpload = async (files: FileList) => {
    const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
    
    const uploadPromises = Array.from(files).map(async (file) => {
      const formDataUpload = new FormData();
      formDataUpload.append('file', file);

      const response = await fetch(`${API_URL}/upload`, {
        method: 'POST',
        body: formDataUpload,
      });

      const result = await response.json();
      return result.success ? result.imagePath : null;
    });

    try {
      const uploadedPaths = await Promise.all(uploadPromises);
      const validPaths = uploadedPaths.filter(path => path !== null);
      
      setGallery(prev => [...prev, ...validPaths]);
      toast({ title: "Imágenes subidas", description: `${validPaths.length} imágenes añadidas a la galería.` });
    } catch (error) {
      console.error('Error uploading gallery images:', error);
      toast({ title: "Error", description: 'Error subiendo imágenes de galería', variant: "destructive" });
    }
  };

  const removeGalleryImage = (index: number) => {
    setGallery(prev => prev.filter((_, i) => i !== index));
  };

  useEffect(() => {
    if (!open) return;
    const safeData = initialData || {};
    // Normalizar siempre a array de strings
    let galleryArr: string[] = [];
    if (Array.isArray(safeData.gallery)) {
      galleryArr = safeData.gallery.map(x => (x ? String(x) : ""));
    } else if (typeof safeData.gallery === 'string' && safeData.gallery) {
      try {
        const parsed = JSON.parse(safeData.gallery);
        if (Array.isArray(parsed)) {
          galleryArr = parsed.map(x => (x ? String(x) : ""));
        } else if (parsed) {
          galleryArr = [String(parsed)];
        }
      } catch {
        galleryArr = [safeData.gallery];
      }
    } else {
      galleryArr = [];
    }
    setGallery(galleryArr);
    setPreviewImage(safeData.image_url || safeData.imageUrl || '');
    setSpecs(technicalFields.map(f => ({ key: f.key, value: safeData.specs?.[f.key] || "" })));
    form.reset({
      brand: safeData.brand || "",
      model: safeData.model || "",
      year: safeData.year || new Date().getFullYear(),
      engine: safeData.engine || "",
      displacement: safeData.displacement || "",
      power: safeData.power || "",
      price_soles: safeData.price_soles || 0,
      style: safeData.style || "",
      transmission: safeData.transmission || "",
      imageUrl: safeData.image_url || safeData.imageUrl || "",
      color: safeData.color || "",
      description: safeData.description || "",
      is_active: safeData.is_active ?? true,
    });
    // eslint-disable-next-line
  }, [open, initialData]);

  const handleSpecsChange = (key: string, value: string) => {
    setSpecs(prev => prev.map(s => s.key === key ? { ...s, value } : s));
  };

  const onSubmit = async (data: FormValues) => {
    try {
      const specsObj: Record<string, string> = {};
      specs.forEach(s => { if (s.value) specsObj[s.key] = s.value; });
      const payload = {
        ...data,
        image_url: data.imageUrl,
        specs: specsObj,
        gallery: gallery.filter(Boolean),
      };
      const updated = await updateMotorcycle(initialData.id, payload);
      toast({ title: "Motocicleta actualizada", description: "La moto fue actualizada correctamente." });
      onSave(updated);
      onOpenChange(false);
    } catch (e) {
      toast({ title: "Error", description: "No se pudo actualizar la motocicleta.", variant: "destructive" });
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-3xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>Editar Motocicleta</DialogTitle>
        </DialogHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <FormField control={form.control} name="brand" render={({ field }) => (
                <FormItem>
                  <FormLabel>Marca</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="model" render={({ field }) => (
                <FormItem>
                  <FormLabel>Modelo</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="year" render={({ field }) => (
                <FormItem>
                  <FormLabel>Año</FormLabel>
                  <FormControl><Input type="number" {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="engine" render={({ field }) => (
                <FormItem>
                  <FormLabel>Motor</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="displacement" render={({ field }) => (
                <FormItem>
                  <FormLabel>Cilindrada</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="power" render={({ field }) => (
                <FormItem>
                  <FormLabel>Potencia</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="price_soles" render={({ field }) => (
                <FormItem>
                  <FormLabel>Precio (Soles)</FormLabel>
                  <FormControl><Input type="number" {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="style" render={({ field }) => (
                <FormItem>
                  <FormLabel>Estilo</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="transmission" render={({ field }) => (
                <FormItem>
                  <FormLabel>Transmisión</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="imageUrl" render={({ field }) => (
                <FormItem>
                  <FormLabel>Imagen Principal</FormLabel>
                  <FormControl>
                    <div className="space-y-2">
                      <Input
                        type="file"
                        accept="image/jpeg,image/jpg,image/png,image/webp,image/avif"
                        onChange={(e) => {
                          const file = e.target.files?.[0];
                          if (file) {
                            handleImageUpload(file);
                          }
                        }}
                        disabled={isUploading}
                      />
                      {isUploading && <p className="text-sm text-gray-500">Subiendo imagen...</p>}
                      {(previewImage || field.value) && (
                        <div className="mt-2">
                          <Image
                            src={previewImage || field.value}
                            alt="Preview"
                            width={200}
                            height={150}
                            className="rounded-lg object-cover border"
                            unoptimized
                          />
                        </div>
                      )}
                    </div>
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="color" render={({ field }) => (
                <FormItem>
                  <FormLabel>Color</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="description" render={({ field }) => (
                <FormItem>
                  <FormLabel>Descripción</FormLabel>
                  <FormControl><Textarea {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField control={form.control} name="is_active" render={({ field }) => (
                <FormItem>
                  <FormLabel>¿Activa?</FormLabel>
                  <FormControl><input type="checkbox" checked={field.value} onChange={e => field.onChange(e.target.checked)} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
            </div>
            <div>
              <label className="block font-medium mb-1">Galería de Imágenes</label>
              <div className="space-y-2">
                <Input
                  type="file"
                  accept="image/jpeg,image/jpg,image/png,image/webp,image/avif"
                  multiple
                  onChange={(e) => {
                    const files = e.target.files;
                    if (files && files.length > 0) {
                      handleGalleryUpload(files);
                    }
                  }}
                  disabled={isUploading}
                />
                {isUploading && <p className="text-sm text-gray-500">Subiendo imágenes...</p>}
                {gallery && gallery.length > 0 && (
                  <div className="grid grid-cols-3 gap-2 mt-2">
                    {gallery.map((image: string, index: number) => (
                      <div key={index} className="relative">
                        <Image
                          src={image}
                          alt={`Galería ${index + 1}`}
                          width={100}
                          height={75}
                          className="rounded-lg object-cover border"
                          unoptimized
                        />
                        <button
                          type="button"
                          onClick={() => removeGalleryImage(index)}
                          className="absolute -top-2 -right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600 transition-colors"
                        >
                          <X className="w-3 h-3" />
                        </button>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </div>
            <div className="mt-6">
              <label className="block font-semibold mb-2">Especificaciones técnicas</label>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {technicalFields.map(({ key, label }) => (
                  <Input
                    key={key}
                    placeholder={label}
                    value={specs.find(s => s.key === key)?.value || ''}
                    onChange={e => handleSpecsChange(key, e.target.value)}
                  />
                ))}
              </div>
            </div>
            <DialogFooter>
              <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
                Cancelar
              </Button>
              <Button type="submit" disabled={form.formState.isSubmitting}>
                Guardar Cambios
              </Button>
            </DialogFooter>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
