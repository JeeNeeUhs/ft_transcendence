"use client";

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
  const [isLoading, setIsLoading] = useState<boolean>(false);

  // ref to store the interval id, used to clear the polling interval
  // if the component unmounts unexpectedly, preventing memory leaks.
  const popupTimerRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    const handlePopupMessage = (event: MessageEvent) => {
      if (event.origin !== window.location.origin) return;

      const data = event.data;

      if (data?.type === "intra_auth_failed") {
        toast.add({
          type: "error",
          title: "error.genericTitle",
          description: "auth.oauth.failed"
        });
      } else if (data?.type === "intra_requires_setup") onIntraSetup(data.payload);
      else if (data?.type === "intra_auth_succeeded") onSuccess(data.payload?.accessToken);

      // cleanup the polling timer since the auth flow is completed
      setIsLoading(false);
      if (popupTimerRef.current !== null) {
        clearInterval(popupTimerRef.current);
        popupTimerRef.current = null;
      }
    };

    window.addEventListener("message", handlePopupMessage);

    // runs when the component unmounts. removes the listener and stops the timer
    // to prevent memory leaks if the user closes the modal while the popup is still open.
    return () => {
      window.removeEventListener("message", handlePopupMessage);
      if (popupTimerRef.current !== null) clearInterval(popupTimerRef.current);
    };
  }, [onSuccess, onIntraSetup]);

  const handleIntraPopup = async () => {
    setIsLoading(true);

    const response = await authService.intraLogin();
    if (!response.success) {
      toast.add({
        type: "error",
        title: "error.genericTitle",
        description: `error.code-${response.errorCode}`
      });
      setIsLoading(false);
      return;
    }

    const popup = window.open(response.data.url, "intra_oauth", "width=500,height=700");
    if (!popup) {
      toast.add({
        type: "error",
        title: "error.genericTitle",
        description: "error.popupBlocked"
      });
      setIsLoading(false);
      return;
    }

    // browsers dont fire an event when a popup closes. we must manually check 'popup.closed'
    // on an interval to reset the loading state if the user manually closes the window.
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
      <p>auth.signInWithIntra</p>
    </Button>
  );
}
