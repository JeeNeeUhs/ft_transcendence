"use client";

import { useTranslations } from "next-intl";

import { Button } from "@/components/ui/button";

export default function OfflinePage() {
  const t = useTranslations("offline");

  const handleRetry = () => {
    window.location.reload();
  };

  return (
    <div className="flex min-h-[calc(100vh-4rem)] items-center justify-center p-4">
      <div className="flex max-w-md flex-col items-center rounded-2xl border border-border/40 bg-card/60 p-8 text-center shadow-xl backdrop-blur-md">
        <div className="mb-6 flex size-20 items-center justify-center rounded-full bg-primary/10 text-primary">
          <svg
            className="size-10 text-primary"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg"
            aria-label="Offline icon"
          >
            <title>Offline Icon</title>
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M12 19.5v.01M2.25 8.25a16.5 16.5 0 0 1 19.5 0M4.875 11.625a12.75 12.75 0 0 1 14.25 0M7.5 15a8.25 8.25 0 0 1 9 0M2 2l20 20"
            />
          </svg>
        </div>

        <h1 className="mb-2 text-2xl font-bold tracking-tight text-foreground">{t("title")}</h1>
        <p className="mb-6 text-sm text-muted-foreground">{t("description")}</p>

        <Button onClick={handleRetry} size="lg" className="w-full px-6 sm:w-auto">
          <svg
            className="mr-2 size-4"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg"
            aria-label="Retry icon"
          >
            <title>Retry Icon</title>
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M160 80v48M128 80h32M160 160v-48M192 160h-32"
            />
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M4 12a8 8 0 0 1 14.93-4M20 12a8 8 0 0 1-14.93 4"
            />
          </svg>
          {t("retry")}
        </Button>
      </div>
    </div>
  );
}
