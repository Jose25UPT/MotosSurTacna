"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { getMotorcycles, updatePromoImage, getPromoImages, getMotorcycleById, getAllMotorcyclesAccum } from "@/lib/data.service";
import { DollarSign, List, Users, Loader2, Image as ImageIcon, Upload, Link2, Download, DatabaseBackup, Save } from "lucide-react";
import BulkPriceEditor from "@/components/bulk-price-editor";
import AddMotorcycleDialog from "@/components/add-motorcycle-dialog";
import { updateMotorcycle, deleteMotorcycle } from "@/lib/data.service";
import EditMotorcycleDialog from "@/components/edit-motorcycle-dialog";
import type { Motorcycle, PromoImage } from "@/lib/types";
import { Skeleton } from "@/components/ui/skeleton";
import { useToast } from "@/hooks/use-toast";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import Image from "next/image";
import { Label } from "@/components/ui/label";
import { Separator } from "@/components/ui/separator";

function PromoCarouselManager({ initialImages }: { initialImages: PromoImage[] }) {
	const [images, setImages] = useState(initialImages);
	const [currentImageIndex, setCurrentImageIndex] = useState(0);
	const [url, setUrl] = useState(images[0]?.url || '');
	const [isSaving, setIsSaving] = useState(false);
	const { toast } = useToast();

	const currentImage = images[currentImageIndex];

	useEffect(() => {
		setUrl(images[currentImageIndex]?.url || '');
	}, [currentImageIndex, images]);

	const handleUrlChange = (e: React.ChangeEvent<HTMLInputElement>) => {
		setUrl(e.target.value);
	};
  
	const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
		const selectedFile = e.target.files?.[0];
		if (selectedFile) {
			if (selectedFile.size > 4 * 1024 * 1024) { // 4MB limit
				toast({ title: "Error", description: "El archivo es muy grande. El límite es 4MB.", variant: "destructive" });
				return;
			}
			const reader = new FileReader();
			reader.onloadend = () => {
				setUrl(reader.result as string);
			};
			reader.readAsDataURL(selectedFile);
		}
	};

	const handleSave = async () => {
		if (!currentImage) return;
		setIsSaving(true);
		try {
			const success = await updatePromoImage(currentImage.id, url);
			if (success) {
				toast({ title: "Éxito", description: `La imagen ${currentImageIndex + 1} ha sido actualizada.` });
				const newImages = [...images];
				newImages[currentImageIndex] = { ...currentImage, url };
				setImages(newImages);
			} else {
				throw new Error("Failed to update image URL");
			}
		} catch (error) {
			console.error("Failed to update promo image", error);
			toast({ title: "Error", description: `No se pudo actualizar la imagen ${currentImageIndex + 1}.`, variant: "destructive" });
		} finally {
			setIsSaving(false);
		}
	};

	return (
		<Card>
			<CardHeader>
				<CardTitle>Gestionar Carrusel de Portada</CardTitle>
				<CardDescription>Cambia las 4 imágenes promocionales que se muestran en el carrusel de inicio.</CardDescription>
			</CardHeader>
			<CardContent className="space-y-6">
				<div className="flex items-center gap-4">
					<Label>Seleccionar Imagen a Editar:</Label>
					<div className="flex gap-2">
						{images.map((img, index) => (
							<Button
								key={img.id}
								variant={currentImageIndex === index ? "default" : "outline"}
								size="sm"
								onClick={() => setCurrentImageIndex(index)}
							>
								Imagen {index + 1}
							</Button>
						))}
					</div>
				</div>
				<Separator/>
				<div className="grid grid-cols-1 md:grid-cols-2 gap-6">
					<div>
						<Tabs defaultValue="url" className="w-full">
							<TabsList className="grid w-full grid-cols-2">
								<TabsTrigger value="url"><Link2 className="mr-2"/>Desde URL</TabsTrigger>
								<TabsTrigger value="upload"><Upload className="mr-2"/>Subir Archivo</TabsTrigger>
							</TabsList>
							<TabsContent value="url" className="pt-4">
								<div className="space-y-2">
									<Label htmlFor="promo-url">URL de la Imagen {currentImageIndex + 1}</Label>
									<Input 
										id="promo-url"
										value={url}
										onChange={handleUrlChange}
										placeholder="https://ejemplo.com/imagen.jpg"
									/>
								</div>
							</TabsContent>
							<TabsContent value="upload" className="pt-4">
								<div className="space-y-2">
									<Label htmlFor="promo-file">Seleccionar Archivo</Label>
									<Input 
										id="promo-file"
										type="file"
										accept="image/png, image/jpeg, image/webp"
										onChange={handleFileChange}
									/>
									<p className="text-xs text-muted-foreground">Sube una imagen desde tu computadora (Max. 4MB).</p>
								</div>
							</TabsContent>
						</Tabs>
						<Button onClick={handleSave} disabled={isSaving} className="mt-6 w-full md:w-auto">
							{isSaving ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : <Save className="mr-2 h-4 w-4" />}
							Guardar Imagen {currentImageIndex + 1}
						</Button>
					</div>
					<div>
						<Label className="text-sm font-medium">Vista Previa (Imagen {currentImageIndex + 1})</Label>
						<div className="mt-2 relative aspect-video w-full border rounded-md bg-secondary/30 flex items-center justify-center overflow-hidden">
							{url ? (
								<Image src={url} alt="Vista previa" layout="fill" objectFit="contain" />
							) : (
								<p className="text-sm text-muted-foreground">La vista previa aparecerá aquí</p>
							)}
						</div>
					</div>
				</div>
			</CardContent>
		</Card>
	);
}

function MaintenanceManager() {
	const { toast } = useToast();
	const fileInputRef = useRef<HTMLInputElement>(null);

	const handleDownloadBackup = () => {
		toast({ title: "Función no implementada", description: "La descarga del backup se haría desde el servidor." });
	};

	const handleRestoreClick = () => {
		fileInputRef.current?.click();
	};

	const handleFileSelected = (e: React.ChangeEvent<HTMLInputElement>) => {
		const file = e.target.files?.[0];
		if (file && file.type === "application/json") {
			toast({ title: "Función no implementada", description: `Se ha seleccionado ${file.name}. La restauración se haría en el backend.` });
		} else {
			toast({ title: "Archivo inválido", description: "Por favor, selecciona un archivo .json.", variant: "destructive" });
		}
	};

	return (
		<Card>
			<CardHeader>
				<CardTitle>Mantenimiento y Seguridad</CardTitle>
				<CardDescription>Gestiona los backups y el estado de la base de datos.</CardDescription>
			</CardHeader>
			<CardContent className="space-y-6">
				<div className="space-y-2">
					<h4 className="font-medium">Backup de Datos</h4>
					<p className="text-sm text-muted-foreground">
						Los backups automáticos se envían diariamente a <span className="font-mono text-primary">napana2626@hosintoy.com</span>.
					</p>
					<p className="text-xs text-muted-foreground">(Esta es una demostración. La funcionalidad de envío de correo no está implementada).</p>
				</div>
				<Separator />
				<div className="flex flex-col sm:flex-row gap-4">
					<Button variant="outline" onClick={handleDownloadBackup} className="w-full sm:w-auto">
						<Download className="mr-2"/>
						Descargar Backup Actual (.json)
					</Button>
					<Button onClick={handleRestoreClick} className="w-full sm:w-auto">
						<DatabaseBackup className="mr-2"/>
						Restaurar desde Backup
					</Button>
					<Input 
						type="file"
						accept=".json"
						ref={fileInputRef}
						onChange={handleFileSelected}
						className="hidden"
					/>
				</div>
			</CardContent>
		</Card>
	)
}

export default function AdminDashboard() {
	const [motorcycles, setMotorcycles] = useState<Motorcycle[] | null>(null);
	const [promoImages, setPromoImages] = useState<PromoImage[] | null>(null);
	const [loading, setLoading] = useState(true);
	const { toast } = useToast();

	useEffect(() => {
		async function loadData() {
			setLoading(true);
			try {
				// Traer motos con paginación (acumular varias páginas si hay muchas)
				const first = await getMotorcycles(1, 100);
				let list = first.items;
				let page = first.page;
				let hasMore = first.has_more;
				// Límite de seguridad: 50 páginas máx (5,000 items si limit=100)
				let guard = 0;
				while (hasMore && guard < 50) {
					const acc = await getAllMotorcyclesAccum(list, page + 1, 100);
					list = acc.merged;
					page = acc.page;
					hasMore = acc.has_more;
					guard++;
				}
				const safeMotorcycles = list.map((m: any) => ({
					...m,
					id: m.id?.toString?.() ?? '',
					gallery: m.gallery || [],
					specifications: m.specifications || {},
				}));
				setMotorcycles(safeMotorcycles);

				try {
					const promoImageData = await getPromoImages();
					setPromoImages(promoImageData);
				} catch (imgErr) {
					setPromoImages([]); // No bloquea el dashboard
					toast({ title: "Aviso", description: "No se pudieron cargar las imágenes promocionales.", variant: "default" });
				}
			} catch (error) {
				console.error("Failed to fetch data", error);
				toast({ title: "Error", description: "No se pudieron cargar las motos.", variant: "destructive" });
			} finally {
				setLoading(false);
			}
		}
		loadData();
	}, [toast]);

	const [mounted, setMounted] = useState(false);
	useEffect(() => { setMounted(true); }, []);
	const handleMotorcycleAdded = () => {
		// Recargar la lista de motocicletas después de añadir una nueva
		// Si quieres feedback, puedes mostrar un toast aquí
		setTimeout(() => window.location.reload(), 300);
	};
  
	const handlePricesUpdated = (updatedMotorcycles: Motorcycle[]) => {
		setMotorcycles(updatedMotorcycles);
	}

		// Evitar hydration mismatch: no renderizar nada hasta que los datos estén listos en el cliente
			const [editOpen, setEditOpen] = useState(false);
			const [editData, setEditData] = useState(null);
			if (!mounted || motorcycles === null) {
				return (
					<div className="flex justify-center items-center h-64">
						<Loader2 className="h-8 w-8 animate-spin text-primary" />
					</div>
				);
			}
		const handleEdit = async (moto) => {
			// Obtener la moto actualizada desde el backend
			try {
				const updated = await getMotorcycleById(moto.id);
				setEditData(updated);
			} catch {
				setEditData(moto); // fallback
			}
			setEditOpen(true);
		};
			const handleEditSave = async (updatedMoto) => {
				// Refrescar desde el backend (primera página) y actualizar estado; si falla, actualizar solo la moto editada
				try {
					const refreshed = await getMotorcycles(1, 100);
					setMotorcycles(refreshed.items);
				} catch {
					setMotorcycles((prev) => prev.map((m) => m.id === updatedMoto.id ? updatedMoto : m));
				}
				setEditOpen(false);
				setEditData(null);
				toast({ title: "Actualizado", description: `La motocicleta ${updatedMoto.brand} ${updatedMoto.model} fue actualizada.` });
			};
	const handleDelete = async (id) => {
		if (!window.confirm("¿Seguro que deseas eliminar esta motocicleta?")) return;
		try {
			await deleteMotorcycle(id);
			setMotorcycles((prev) => prev.filter((m) => m.id !== id));
			toast({ title: "Eliminada", description: "Motocicleta eliminada correctamente." });
		} catch {
			toast({ title: "Error", description: "No se pudo eliminar la motocicleta.", variant: "destructive" });
		}
	};

	const totalMotorcycles = motorcycles.length;
	const averagePrice =
		totalMotorcycles > 0
			? motorcycles.reduce((acc, m) => acc + Number(m.price_soles), 0) / totalMotorcycles
			: 0;

		return (
			<div className="container mx-auto px-4 py-8 md:py-12 space-y-8">
				<header className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
					<div>
						<h1 className="text-3xl font-bold tracking-tight">Panel de Administración</h1>
						<p className="text-muted-foreground">Bienvenido, aquí puedes gestionar el contenido de la web.</p>
					</div>
					<AddMotorcycleDialog onMotorcycleAdded={handleMotorcycleAdded} />
				</header>

				<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
					<Card>
						<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
							<CardTitle className="text-sm font-medium">Total de Motocicletas</CardTitle>
							<List className="h-4 w-4 text-muted-foreground" />
						</CardHeader>
						<CardContent>
							<div className="text-2xl font-bold">{totalMotorcycles}</div>
							<p className="text-xs text-muted-foreground">
								Número total de motocicletas en el catálogo.
							</p>
						</CardContent>
					</Card>
					<Card>
						<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
							<CardTitle className="text-sm font-medium">Precio Promedio</CardTitle>
							<DollarSign className="h-4 w-4 text-muted-foreground" />
						</CardHeader>
						<CardContent>
							<div className="text-2xl font-bold">${averagePrice.toFixed(2)}</div>
							<p className="text-xs text-muted-foreground">
								Precio promedio de todas las motocicletas.
							</p>
						</CardContent>
					</Card>
					<Card>
						<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
							<CardTitle className="text-sm font-medium">Usuarios Activos</CardTitle>
							<Users className="h-4 w-4 text-muted-foreground" />
						</CardHeader>
						<CardContent>
							<div className="text-2xl font-bold">+23</div>
							<p className="text-xs text-muted-foreground">+5% que el mes pasado</p>
						</CardContent>
					</Card>
				</div>

				{/* Tabla/lista de motos */}
				<div className="overflow-x-auto mt-8">
					<table className="min-w-full bg-white border rounded shadow">
						<thead>
							<tr>
								<th className="px-2 py-2 border">Marca</th>
								<th className="px-2 py-2 border">Modelo</th>
								<th className="px-2 py-2 border">Año</th>
								<th className="px-2 py-2 border">Precio</th>
								<th className="px-2 py-2 border">Acciones</th>
							</tr>
						</thead>
						<tbody>
							{motorcycles.map((moto) => (
								<tr key={moto.id} className="border-b">
									<td className="px-2 py-2 border">{moto.brand}</td>
									<td className="px-2 py-2 border">{moto.model}</td>
									<td className="px-2 py-2 border">{moto.year}</td>
									<td className="px-2 py-2 border">${moto.price_soles}</td>
									<td className="px-2 py-2 border flex gap-2">
										<Button size="sm" variant="outline" onClick={() => handleEdit(moto)}>Editar</Button>
										<Button size="sm" variant="destructive" onClick={() => handleDelete(moto.id)}>Eliminar</Button>
									</td>
								</tr>
							))}
						</tbody>
					</table>
				</div>

				<div className="space-y-8">
					{promoImages && promoImages.length > 0 ? (
						<PromoCarouselManager initialImages={promoImages} />
					) : (
						<div className="p-4 border rounded text-sm text-muted-foreground bg-secondary/30">
							No hay imágenes promocionales configuradas.
						</div>
					)}
					<BulkPriceEditor initialMotorcycles={motorcycles} onPricesUpdated={handlePricesUpdated} />
					<MaintenanceManager />
				</div>

				{/* Botón de backup completo */}
				<div className="my-12 flex justify-center">
					<Button
						variant="default"
						size="lg"
						className="text-lg px-8 py-4"
						onClick={async () => {
							try {
								let apiUrl = '';
								if (typeof window !== 'undefined') {
									apiUrl = window.location.origin.replace(/(:3000)?$/, ':8000');
								} else {
									apiUrl = 'http://localhost:8000';
								}
								const res = await fetch(`${apiUrl}/backup`, {
									method: 'GET',
								});
								if (!res.ok) throw new Error('Error al generar backup');
								const blob = await res.blob();
								const url = window.URL.createObjectURL(blob);
								const a = document.createElement('a');
								a.href = url;
								a.download = 'backup_tienda_motos.zip';
								document.body.appendChild(a);
								a.click();
								a.remove();
								window.URL.revokeObjectURL(url);
							} catch (err) {
								alert('Error al descargar backup');
							}
						}}
					>
						Descargar Backup Completo (DB + Imágenes)
					</Button>
				</div>

				{/* Modal de edición */}
						<EditMotorcycleDialog
							open={editOpen}
							onOpenChange={(v) => {
								setEditOpen(v);
								if (!v) setEditData(null);
							}}
							initialData={editData}
							onSave={handleEditSave}
						/>
			</div>
		);
}
