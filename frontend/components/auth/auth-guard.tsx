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

// Example usage:
// TODO: do not remove until these are used in a page
//
// <SignedIn fallback={<div>korumali component bu kardesim goremezsin</div>}>
//   <div>sen yetkili bi abiye benziyosun gorebilirsin bunu</div>
// </SignedIn>
// <SignedOut>
//   <div>giris yapmadiysan gorursun bunu oyle bir component yani</div>
// </SignedOut>
