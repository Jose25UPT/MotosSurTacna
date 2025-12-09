
"use client";
import { useEffect, useState, use } from 'react';
import { useRouter } from 'next/navigation';
import { getMotorcycleById } from '@/lib/data.service';
import type { Motorcycle } from '@/lib/types';
import MotorcycleDetailClient from '@/components/motorcycle-detail-client';

export default function MotorcycleDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const resolvedParams = use(params);
  const [motorcycle, setMotorcycle] = useState<Motorcycle | null>(null);
  const router = useRouter();

  useEffect(() => {
    getMotorcycleById(resolvedParams.id)
      .then((data) => {
        if (!data) router.replace('/404');
        else setMotorcycle(data);
      })
      .catch(() => router.replace('/404'));
  }, [resolvedParams.id, router]);

  if (!motorcycle) return <div>Cargando...</div>;
  return <MotorcycleDetailClient motorcycle={motorcycle} />;
}
