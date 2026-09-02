"use client";

import { CheckmarkCircle02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { useTranslations } from "next-intl";

import { UserAvatar } from "@/components/profile/user-avatar";
import { Button } from "@/components/ui/button";
import { Spinner } from "@/components/ui/spinner";
import type { Friend } from "@/lib/api/friend";

export function FriendRequestPopup({
  request,
  isAccepting,
  onAccept
}: {
  request: Friend;
  isAccepting: boolean;
  onAccept: () => void;
}) {
  const tUsers = useTranslations("users");

  return (
    <div className="flex flex-col gap-3 rounded-lg bg-card px-3 py-3 shadow-lg ring-1 ring-foreground/10 sm:flex-row sm:items-center">
      <UserAvatar username={request.username} avatarUrl={request.avatarUrl} />
      <div className="min-w-0 flex-1">
        <div className="truncate text-xs/relaxed font-medium">{request.username}</div>
        <div className="truncate text-xs/relaxed text-muted-foreground">
          {tUsers("requests.incoming")}
        </div>
      </div>
      <div className="flex shrink-0 items-center gap-1">
        <Button onClick={onAccept} disabled={isAccepting}>
          {isAccepting ? <Spinner /> : <HugeiconsIcon icon={CheckmarkCircle02Icon} />}
          {tUsers("requests.accept")}
        </Button>
      </div>
    </div>
  );
}
