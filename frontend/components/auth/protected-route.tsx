"use client";

import { useRouter } from "next/navigation";
import { useEffect } from "react";
import { useUserStore } from "@/providers/user";

export function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const user = useUserStore((state) => state.user);
  const router = useRouter();

  useEffect(() => {
    if (!user) router.replace("/");
  }, [user, router]);

  if (!user) return null;

  return <>{children}</>;
}
