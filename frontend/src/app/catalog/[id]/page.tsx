
"use client";
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { getMotorcycleById } from '@/lib/data.service';
import type { Motorcycle } from '@/lib/types';
import MotorcycleDetailClient from '@/components/motorcycle-detail-client';

export default function MotorcycleDetailPage({ params }: { params: { id: string } }) {
  const [motorcycle, setMotorcycle] = useState<Motorcycle | null>(null);
  const router = useRouter();

  useEffect(() => {
    getMotorcycleById(params.id)
      .then((data) => {
        if (!data) router.replace('/404');
        else setMotorcycle(data);
      })
      .catch(() => router.replace('/404'));
  }, [params.id, router]);

  if (!motorcycle) return <div>Cargando...</div>;
  return <MotorcycleDetailClient motorcycle={motorcycle} />;
}
