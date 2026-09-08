"use client";

import { useUserStore } from "@/providers/user";

export function SignedIn({
  children,
  fallback = null
}: {
  children: React.ReactNode;
  fallback?: React.ReactNode;
}) {
  const user = useUserStore((state) => state.user);

  if (!user) return <>{fallback}</>;

  return <>{children}</>;
}

export function SignedOut({ children }: { children: React.ReactNode }) {
  const user = useUserStore((state) => state.user);

  if (user) return null;

  return <>{children}</>;
}
