"use client";

import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
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
import { PlusCircle, Upload, X } from "lucide-react";
import { API_URL } from "@/lib/config";
import { getBrands, addMotorcycle } from "@/lib/data.service";
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

export default function AddMotorcycleDialog({ isEdit = false, onMotorcycleAdded = () => {} }) {
  const { toast } = useToast();
  const [open, setOpen] = useState(false);
  const [gallery, setGallery] = useState<string[]>([]);
  const [specs, setSpecs] = useState<{ key: string; value: string }[]>(technicalFields.map(f => ({ key: f.key, value: "" })));
  const [isUploading, setIsUploading] = useState(false);
  const [previewImage, setPreviewImage] = useState<string>('');
  
  const form = useForm<FormValues>({
    resolver: zodResolver(schema),
    defaultValues: {
      brand: "",
      model: "",
      year: new Date().getFullYear(),
      engine: "",
      displacement: "",
      power: "",
      price_soles: 0,
      style: "",
      transmission: "",
      imageUrl: "",
      color: "",
      description: "",
      is_active: true,
    },
  });

  // Función para subir imagen principal
  const handleImageUpload = async (file: File) => {
    if (!file) return;

    setIsUploading(true);
    const formDataUpload = new FormData();
    formDataUpload.append('file', file);

    try {
      // Usar la configuración dinámica de API_URL
      console.log('🔄 Subiendo imagen a:', `${API_URL}/upload`);
      const response = await fetch(`${API_URL}/upload`, {
        method: 'POST',
        body: formDataUpload,
      });

      const result = await response.json();

      if (result.success) {
        form.setValue('imageUrl', result.imagePath);
        setPreviewImage(result.imagePath);
        toast({ title: "Imagen subida", description: "Imagen principal subida exitosamente." });
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
    console.log('🖼️ Subiendo galería de imágenes a:', `${API_URL}/upload`);
    
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
      toast({ title: "Imágenes subidas", description: `${validPaths.length} imágenes subidas a la galería.` });
    } catch (error) {
      console.error('Error uploading gallery images:', error);
      toast({ title: "Error", description: 'Error subiendo imágenes de galería', variant: "destructive" });
    }
  };

  const removeGalleryImage = (index: number) => {
    setGallery(prev => prev.filter((_, i) => i !== index));
  };

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
      await addMotorcycle(payload);
      toast({ title: "Motocicleta añadida", description: "La moto fue añadida correctamente." });
      setOpen(false);
      form.reset();
      setGallery([]);
      setPreviewImage('');
      setSpecs(technicalFields.map(f => ({ key: f.key, value: "" })));
      onMotorcycleAdded();
    } catch (e) {
      toast({ title: "Error", description: "No se pudo añadir la motocicleta.", variant: "destructive" });
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button>
          <PlusCircle className="mr-2 h-4 w-4" />
          Añadir Motocicleta
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-3xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>Añadir Nueva Motocicleta</DialogTitle>
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
                      {previewImage && (
                        <div className="mt-2">
                          <Image
                            src={previewImage}
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
            
            {/* Galería de imágenes con upload de archivos */}
            <div>
              <label className="block font-medium mb-2">Galería de Imágenes</label>
              <div className="space-y-4">
                <Input
                  type="file"
                  accept="image/jpeg,image/jpg,image/png,image/webp,image/avif"
                  multiple
                  onChange={(e) => {
                    const files = e.target.files;
                    if (files) {
                      handleGalleryUpload(files);
                    }
                  }}
                  className="mb-2"
                />
                
                {gallery.length > 0 && (
                  <div className="grid grid-cols-3 gap-2">
                    {gallery.map((imagePath, index) => (
                      <div key={index} className="relative">
                        <Image
                          src={imagePath}
                          alt={`Gallery ${index + 1}`}
                          width={150}
                          height={100}
                          className="rounded object-cover border"
                          unoptimized
                        />
                        <Button
                          type="button"
                          variant="destructive"
                          size="sm"
                          className="absolute top-1 right-1 w-6 h-6 p-0"
                          onClick={() => removeGalleryImage(index)}
                        >
                          <X className="w-3 h-3" />
                        </Button>
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
              <Button type="button" variant="outline" onClick={() => setOpen(false)}>
                Cancelar
              </Button>
              <Button type="submit" disabled={form.formState.isSubmitting}>
                Añadir Motocicleta
              </Button>
            </DialogFooter>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
