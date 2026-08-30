"use client";

import { Alert02Icon, CheckmarkCircle02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { useLocale, useTranslations } from "next-intl";
import { useEffect, useRef, useState } from "react";

import { SectionHeader } from "@/components/settings/section-header";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger
} from "@/components/ui/dialog";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { API_KEY_NOT_FOUND, type ApiKey, apiKeyService } from "@/lib/api/apikey";

function maskKey(key: string) {
  return `${key.slice(0, 7)}${"•".repeat(32)}`;
}

export function ApiKeySection() {
  const tSettings = useTranslations("settings");
  const tError = useTranslations("error");
  const locale = useLocale();

  const [apiKey, setApiKey] = useState<ApiKey | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isMutating, setIsMutating] = useState<boolean>(false);
  const [isRevealed, setIsRevealed] = useState<boolean>(false);
  const [isCopied, setIsCopied] = useState<boolean>(false);

  // the "copied" label resets itself, so the timer has to be cleared on unmount
  const copyTimerRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    const fetchKey = async () => {
      const response = await apiKeyService.get();
      if (!response.success) {
        if (response.errorCode !== API_KEY_NOT_FOUND) {
          toast.add({
            type: "error",
            title: tError("genericTitle"),
            description: tError("fetchError")
          });
        }

        setApiKey(null);
        setIsLoading(false);
        return;
      }

      setApiKey(response.data);
      setIsLoading(false);
    };

    fetchKey();
  }, [tError]);

  useEffect(() => {
    return () => {
      if (copyTimerRef.current !== null) clearTimeout(copyTimerRef.current);
    };
  }, []);

  const handleCreate = async () => {
    setIsMutating(true);

    const response = await apiKeyService.create();
    if (!response.success) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tError(`codes.${response.errorCode}`)
      });

      setIsMutating(false);
      return;
    }

    setApiKey({ key: response.data.key, isActive: true, createdAt: new Date().toISOString() });
    setIsRevealed(true);
    setIsMutating(false);

    toast.add({
      type: "success",
      title: tSettings("apiKey.created"),
      description: tSettings("apiKey.createdDescription")
    });
  };

  const handleDelete = async () => {
    setIsMutating(true);

    const response = await apiKeyService.remove();
    if (!response.success) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tError(`codes.${response.errorCode}`)
      });

      setIsMutating(false);
      return;
    }

    setApiKey(null);
    setIsRevealed(false);
    setIsMutating(false);

    toast.add({
      type: "success",
      title: tSettings("apiKey.deleted")
    });
  };

  const handleCopy = async () => {
    if (!apiKey) return;

    await navigator.clipboard.writeText(apiKey.key);
    setIsCopied(true);

    if (copyTimerRef.current !== null) clearTimeout(copyTimerRef.current);
    copyTimerRef.current = setTimeout(() => {
      setIsCopied(false);
      copyTimerRef.current = null;
    }, 2000);
  };

  return (
    <div className="space-y-5">
      <SectionHeader
        title={tSettings("apiKey.title")}
        description={tSettings("apiKey.description")}
      />

      {isLoading ? (
        <div className="flex items-center gap-x-2 text-xs/relaxed text-muted-foreground">
          <Spinner />
          {tSettings("apiKey.loading")}
        </div>
      ) : apiKey ? (
        <div className="space-y-3">
          <div className="space-y-3 rounded-lg bg-card px-3 py-3 ring-1 ring-foreground/10">
            <div className="flex items-center gap-1">
              <Badge variant={apiKey.isActive ? "secondary" : "outline"}>
                {apiKey.isActive ? tSettings("apiKey.active") : tSettings("apiKey.inactive")}
              </Badge>
              <Badge variant="outline">
                {tSettings("apiKey.createdAt", {
                  date: new Intl.DateTimeFormat(locale, { dateStyle: "long" }).format(
                    new Date(apiKey.createdAt)
                  )
                })}
              </Badge>
            </div>

            <code className="block overflow-x-auto rounded-md bg-muted px-2 py-2 font-mono text-xs/relaxed break-all whitespace-pre-wrap">
              {isRevealed ? apiKey.key : maskKey(apiKey.key)}
            </code>

            <div className="flex flex-wrap items-center gap-1">
              <Button variant="outline" onClick={() => setIsRevealed(!isRevealed)}>
                {isRevealed ? tSettings("apiKey.hide") : tSettings("apiKey.reveal")}
              </Button>
              <Button variant="outline" onClick={handleCopy}>
                {isCopied && <HugeiconsIcon icon={CheckmarkCircle02Icon} />}
                {isCopied ? tSettings("apiKey.copied") : tSettings("apiKey.copy")}
              </Button>

              <Dialog>
                <DialogTrigger render={<Button variant="destructive" disabled={isMutating} />}>
                  {isMutating && <Spinner />}
                  {tSettings("apiKey.delete")}
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle>{tSettings("apiKey.deleteTitle")}</DialogTitle>
                    <DialogDescription>{tSettings("apiKey.deleteDescription")}</DialogDescription>
                  </DialogHeader>
                  <DialogFooter>
                    <DialogClose render={<Button variant="outline" />}>
                      {tSettings("apiKey.cancel")}
                    </DialogClose>
                    <DialogClose render={<Button variant="destructive" onClick={handleDelete} />}>
                      {tSettings("apiKey.deleteConfirm")}
                    </DialogClose>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </div>
          </div>

          <div className="flex items-start gap-2 text-xs/relaxed text-muted-foreground">
            <HugeiconsIcon icon={Alert02Icon} size={16} className="mt-px shrink-0" />
            <p>{tSettings("apiKey.warning")}</p>
          </div>
        </div>
      ) : (
        <div className="space-y-3">
          <p className="text-xs/relaxed text-muted-foreground">{tSettings("apiKey.empty")}</p>
          <Button onClick={handleCreate} disabled={isMutating} className="flex items-center gap-x-2">
            {isMutating && <Spinner />}
            {tSettings("apiKey.create")}
          </Button>
        </div>
      )}
    </div>
  );
}
