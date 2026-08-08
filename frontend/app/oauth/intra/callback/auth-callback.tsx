"use client";

import { useSearchParams } from "next/navigation";
import { useEffect } from "react";

import { authService } from "@/lib/api/auth";

export function AuthCallback() {
  const searchParams = useSearchParams();

  useEffect(() => {
    const handleCallback = async () => {
      if (window.opener) {
        const code = searchParams.get("code");
        if (!code) {
          window.close();
          return;
        }

        const response = await authService.intraCallback(code);
        if (!response.success) {
          window.opener.postMessage({ type: "intra_auth_failed" }, window.location.origin);
          return;
        }

        const messageType = response.data.isNewUser
          ? "intra_requires_setup"
          : "intra_auth_succeeded";

        window.opener.postMessage(
          { type: messageType, payload: response.data },
          window.location.origin
        );
        window.close();
      }
    };

    handleCallback();
  }, [searchParams]);

  return (
    <div className="w-screen h-screen flex items-center justify-center">auth.oauth.completing</div>
  );
}
