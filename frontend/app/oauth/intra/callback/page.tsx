import { Suspense } from "react";
import { AuthCallback } from "@/app/oauth/intra/callback/auth-callback";

export default function AuthCallbackPage() {
  return (
    <Suspense fallback={<div>auth.oauth.completing</div>}>
      <AuthCallback />
    </Suspense>
  );
}
