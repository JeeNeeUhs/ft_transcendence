import { Suspense } from "react";

import { AuthCallback } from "@/app/oauth/intra/callback/auth-callback";

export default async function AuthCallbackPage() {

  return (
    <Suspense>
      <AuthCallback />
    </Suspense>
  );
}
