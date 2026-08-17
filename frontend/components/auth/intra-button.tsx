"use client";

import { useTranslations } from "next-intl";
import Image from "next/image";
import { useEffect, useRef, useState } from "react";

import { Button } from "@/components/ui/button";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { authService, type IntraResponse } from "@/lib/api/auth";

interface IntraButtonProps {
  onSuccess: (accessToken: string) => void;
  onIntraSetup: (response: IntraResponse) => void;
}

export function IntraButton({ onSuccess, onIntraSetup }: IntraButtonProps) {
  const tAuth = useTranslations("auth");
  const tError = useTranslations("error");
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const popupTimerRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    const handlePopupMessage = (event: MessageEvent) => {
      if (event.origin !== window.location.origin) return;

      const data = event.data;

      if (data?.type === "intra_auth_failed") {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: tAuth("oauth.failed")
        });
      } else if (data?.type === "intra_requires_setup") onIntraSetup(data.payload);
      else if (data?.type === "intra_auth_succeeded") onSuccess(data.payload?.accessToken);

      setIsLoading(false);
      if (popupTimerRef.current !== null) {
        clearInterval(popupTimerRef.current);
        popupTimerRef.current = null;
      }
    };

    window.addEventListener("message", handlePopupMessage);

    return () => {
      window.removeEventListener("message", handlePopupMessage);
      if (popupTimerRef.current !== null) clearInterval(popupTimerRef.current);
    };
  }, [onSuccess, onIntraSetup, tAuth, tError]);

  const handleIntraPopup = async () => {
    setIsLoading(true);

    const response = await authService.intraLogin();
    if (!response.success) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: `error.code-${response.errorCode}`
      });
      setIsLoading(false);
      return;
    }

    const popup = window.open(response.data.url, "intra_oauth", "width=500,height=700");
    if (!popup) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tError("popupBlocked")
      });
      setIsLoading(false);
      return;
    }

    popupTimerRef.current = setInterval(() => {
      if (popup.closed) {
        if (popupTimerRef.current !== null) {
          clearInterval(popupTimerRef.current);
          popupTimerRef.current = null;
        }

        setIsLoading(false);
      }
    }, 500);
  };

  return (
    <Button
      variant="outline"
      className="flex items-center gap-x-2"
      onClick={handleIntraPopup}
      disabled={isLoading}
    >
      {isLoading && <Spinner />}
      <Image src="/42_Logo.svg" width={16} height={16} alt="42 Logo" className="dark:invert" />
      <p>{tAuth("signInWithIntra")}</p>
    </Button>
  );
}
