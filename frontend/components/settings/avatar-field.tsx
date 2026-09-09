"use client";

import { User02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import Image from "next/image";
import { useTranslations } from "next-intl";
import { useRef, useState } from "react";

import { Button } from "@/components/ui/button";
import { Field, FieldDescription, FieldTitle } from "@/components/ui/field";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { avatarTypes, maxAvatarSize, userService } from "@/lib/api/user";
import { useUserStore } from "@/providers/user";

export function AvatarField() {
  const tSettings = useTranslations("settings");
  const tError = useTranslations("error");

  const user = useUserStore((state) => state.user);
  const setUser = useUserStore((state) => state.setUser);
  const [isUploading, setIsUploading] = useState<boolean>(false);

  const inputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];

    // reset the input so picking the same file again still fires a change event
    event.target.value = "";
    if (!file || !user) return;

    if (!avatarTypes.includes(file.type)) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tSettings("profile.avatarUnsupported")
      });

      return;
    }

    if (file.size > maxAvatarSize) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tSettings("profile.avatarTooLarge")
      });

      return;
    }

    setIsUploading(true);

    const response = await userService.uploadAvatar(file);
    if (!response.success) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tError(`codes.${response.errorCode}`)
      });

      setIsUploading(false);
      return;
    }

    setUser({ ...user, avatarUrl: response.data.avatarUrl });
    setIsUploading(false);

    toast.add({
      type: "success",
      title: tSettings("profile.avatarUpdated")
    });
  };

  if (!user) return null;

  return (
    <Field>
      <FieldTitle>{tSettings("profile.avatar")}</FieldTitle>
      <div className="flex items-center gap-4">
        <div className="relative size-20 shrink-0 overflow-hidden rounded-full bg-muted">
          {user.avatarUrl ? (
            <Image
              src={user.avatarUrl}
              alt={user.username}
              fill
              sizes="80px"
              // avatars are served from the api host, which the next server cannot reach in docker
              unoptimized
              className="object-cover"
            />
          ) : (
            <div className="flex size-full items-center justify-center text-muted-foreground">
              <HugeiconsIcon icon={User02Icon} size={28} />
            </div>
          )}
          {isUploading && (
            <div className="absolute inset-0 flex items-center justify-center bg-background/70">
              <Spinner />
            </div>
          )}
        </div>

        <div className="flex flex-col items-start gap-2">
          <input
            ref={inputRef}
            type="file"
            accept={avatarTypes.join(",")}
            className="hidden"
            onChange={handleFileChange}
          />
          <Button
            variant="outline"
            disabled={isUploading}
            onClick={() => inputRef.current?.click()}
          >
            {tSettings("profile.changeAvatar")}
          </Button>
          <FieldDescription>{tSettings("profile.avatarHint")}</FieldDescription>
        </div>
      </div>
    </Field>
  );
}
