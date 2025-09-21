
"use client";

import { useState, useMemo, useEffect } from "react";
import type { Motorcycle } from "@/lib/types";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Checkbox } from "@/components/ui/checkbox";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { useToast } from "@/hooks/use-toast";
import { Badge } from "./ui/badge";
import { updateMotorcyclePrices } from "@/lib/data.service";

interface BulkPriceEditorProps {
  initialMotorcycles: Motorcycle[];
  onPricesUpdated: (updatedMotorcycles: Motorcycle[]) => void;
}

type AdjustmentType = "percentage" | "fixed";
type PriceChange = {
  motorcycle: Motorcycle;
  newPrice: number;
};

export default function BulkPriceEditor({ initialMotorcycles, onPricesUpdated }: BulkPriceEditorProps) {
  const [motorcycles, setMotorcycles] = useState(initialMotorcycles);
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [adjustmentType, setAdjustmentType] = useState<AdjustmentType>("percentage");
  const [adjustmentValue, setAdjustmentValue] = useState("");
  const [isConfirmOpen, setIsConfirmOpen] = useState(false);
  const [pendingChanges, setPendingChanges] = useState<PriceChange[]>([]);
  const { toast } = useToast();

  useEffect(() => {
    setMotorcycles(initialMotorcycles);
  }, [initialMotorcycles]);

  const handleSelectAll = (checked: boolean | string) => {
    if (checked) {
      setSelectedIds(new Set(motorcycles.map((m) => m.id)));
    } else {
      setSelectedIds(new Set());
    }
  };

  const handleSelectRow = (id: string, checked: boolean | string) => {
    const newSelectedIds = new Set(selectedIds);
    if (checked) {
      newSelectedIds.add(id);
    } else {
      newSelectedIds.delete(id);
    }
    setSelectedIds(newSelectedIds);
  };

  const calculateNewPrices = (): PriceChange[] => {
    const value = parseFloat(adjustmentValue);
    if (isNaN(value)) return [];

    const selectedMotorcycles = motorcycles.filter(m => selectedIds.has(m.id));

    return selectedMotorcycles.map(motorcycle => {
      let newPrice: number;
      if (adjustmentType === "percentage") {
        if (value < -100 || value > 500) { // Aumentamos el límite superior
           toast({ title: "Error de Validación", description: "El porcentaje debe estar entre -100 y 500.", variant: "destructive" });
           throw new Error("Invalid percentage");
        }
        newPrice = Number(motorcycle.price_soles) * (1 + value / 100);
      } else {
        newPrice = value;
      }
      return {
        motorcycle,
        newPrice: Math.max(0, parseFloat(newPrice.toFixed(2))) // Prevenir precios negativos y redondear
      };
    });
  };

  const handleReviewChanges = () => {
    if (!adjustmentValue) {
        toast({ title: "Valor Requerido", description: "Por favor, introduce un valor para el ajuste.", variant: "destructive" });
        return;
    }
    if (selectedIds.size === 0) {
      toast({ title: "No hay selección", description: "Por favor, selecciona al menos una motocicleta.", variant: "destructive" });
      return;
    }
    try {
        const changes = calculateNewPrices();
        if(changes.length > 0) {
            setPendingChanges(changes);
            setIsConfirmOpen(true);
        } else {
             toast({ title: "Error", description: "No se pudieron calcular los cambios. Revisa el valor introducido.", variant: "destructive" });
        }
    } catch (error) {
        // Toast is already shown in calculateNewPrices for validation errors
    }
  };

  const handleConfirmUpdate = async () => {
    const updates = pendingChanges.map(p => ({
      id: p.motorcycle.id,
      price_soles: p.newPrice.toFixed(2)
    }));
    
    try {
      await updateMotorcyclePrices(updates);

      const updatedMotorcycles = motorcycles.map(moto => {
          const change = pendingChanges.find(c => c.motorcycle.id === moto.id);
          return change ? { ...moto, price: change.newPrice } : moto;
      });
      
      onPricesUpdated(updatedMotorcycles); // Notificar al padre sobre los cambios

      toast({ title: "Éxito", description: `${pendingChanges.length} precios actualizados correctamente.` });

    } catch (error) {
       toast({ title: "Error", description: "No se pudieron actualizar los precios.", variant: "destructive" });
    } finally {
       // Resetear estado
      setIsConfirmOpen(false);
      setSelectedIds(new Set());
      setAdjustmentValue("");
    }
  };

  const isAllSelected = selectedIds.size > 0 && selectedIds.size === motorcycles.length;
  const isAnySelected = selectedIds.size > 0;

  return (
    <>
      <Card>
        <CardHeader>
          <CardTitle>Gestión de Precios de Inventario</CardTitle>
          <CardDescription>Selecciona las motocicletas y aplica cambios de precio de forma masiva.</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="border rounded-md">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-[50px]">
                    <Checkbox
                      checked={isAllSelected}
                      onCheckedChange={handleSelectAll}
                      aria-label="Seleccionar todo"
                    />
                  </TableHead>
                  <TableHead>Modelo</TableHead>
                  <TableHead>Marca</TableHead>
                  <TableHead className="text-right">Precio Actual</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {motorcycles.map((moto) => (
                  <TableRow key={moto.id} data-state={selectedIds.has(moto.id) ? "selected" : ""}>
                    <TableCell>
                      <Checkbox
                        checked={selectedIds.has(moto.id)}
                        onCheckedChange={(checked) => handleSelectRow(moto.id, checked)}
                        aria-label={`Seleccionar ${moto.model}`}
                      />
                    </TableCell>
                    <TableCell className="font-medium">{moto.model}</TableCell>
                    <TableCell>
                       <Badge variant="outline">{moto.brand}</Badge>
                    </TableCell>
                    <TableCell className="text-right">${(moto.price_soles ?? 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </CardContent>
      </Card>
      
      {isAnySelected && (
        <Card className="fixed bottom-4 left-1/2 -translate-x-1/2 w-full max-w-2xl shadow-2xl z-50 animate-in slide-in-from-bottom-10">
            <CardContent className="p-4 flex flex-col sm:flex-row items-center gap-4">
                <div className="flex-shrink-0">
                    <p className="font-medium">{selectedIds.size} motos seleccionadas</p>
                </div>
                <div className="flex-grow grid grid-cols-1 sm:grid-cols-2 gap-4 w-full">
                    <Select value={adjustmentType} onValueChange={(v) => setAdjustmentType(v as AdjustmentType)}>
                        <SelectTrigger>
                            <SelectValue placeholder="Tipo de ajuste" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="percentage">Porcentaje (%)</SelectItem>
                            <SelectItem value="fixed">Precio Fijo ($)</SelectItem>
                        </SelectContent>
                    </Select>
                     <div>
                        <Label htmlFor="adjustment-value" className="sr-only">Valor</Label>
                        <Input
                            id="adjustment-value"
                            type="number"
                            placeholder={adjustmentType === 'percentage' ? "Ej: -5" : "Ej: 8999"}
                            value={adjustmentValue}
                            onChange={(e) => setAdjustmentValue(e.target.value)}
                        />
                    </div>
                </div>
                <div className="flex-shrink-0 flex gap-2">
                     <Button variant="outline" onClick={() => setSelectedIds(new Set())}>Cancelar</Button>
                    <Button onClick={handleReviewChanges}>Revisar Cambios</Button>
                </div>
            </CardContent>
        </Card>
      )}

      <AlertDialog open={isConfirmOpen} onOpenChange={setIsConfirmOpen}>
        <AlertDialogContent>
            <AlertDialogHeader>
                <AlertDialogTitle>Confirmar Actualización de Precios</AlertDialogTitle>
                <AlertDialogDescription>
                    Se actualizará el precio para {pendingChanges.length} motocicletas. Por favor, revisa los cambios antes de confirmar.
                </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="max-h-60 overflow-y-auto pr-4 -mr-4">
                 <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>Modelo</TableHead>
                            <TableHead className="text-right">Precio Anterior</TableHead>
                            <TableHead className="text-right">Precio Nuevo</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {pendingChanges.map(({ motorcycle, newPrice }) => (
                            <TableRow key={motorcycle.id}>
                                <TableCell className="font-medium">{motorcycle.model}</TableCell>
                                <TableCell className="text-right">${(motorcycle.price_soles ?? 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</TableCell>
                                <TableCell className="text-right font-bold text-primary">${(newPrice ?? 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </div>
            <AlertDialogFooter>
                <AlertDialogCancel>Cancelar</AlertDialogCancel>
                <AlertDialogAction onClick={handleConfirmUpdate}>Confirmar y Actualizar</AlertDialogAction>
            </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </>
  );
}
