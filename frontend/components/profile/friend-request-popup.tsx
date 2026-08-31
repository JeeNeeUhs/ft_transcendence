"use client";

import { Cancel01Icon, CheckmarkCircle02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { useLocale, useTranslations } from "next-intl";

import { UserAvatar } from "@/components/profile/user-avatar";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import type { FriendRequest } from "@/lib/mock/friends";
import { timeAgo } from "@/lib/utils";

export function FriendRequestPopup({
  request,
  remaining,
  onAccept,
  onDecline
}: {
  request: FriendRequest;
  remaining: number;
  onAccept: () => void;
  onDecline: () => void;
}) {
  const tUsers = useTranslations("users");
  const locale = useLocale();

  return (
    <div className="flex flex-col gap-3 rounded-lg bg-card px-3 py-3 shadow-lg ring-1 ring-foreground/10 sm:flex-row sm:items-center">
      <UserAvatar username={request.username} avatarUrl={request.avatarUrl} />
      <div className="min-w-0 flex-1">
        <div className="flex items-center gap-2">
          <span className="truncate text-xs/relaxed font-medium">{request.username}</span>
          {remaining > 1 && <Badge variant="secondary">{remaining}</Badge>}
        </div>
        <div className="truncate text-xs/relaxed text-muted-foreground">
          {tUsers("requests.incoming", { time: timeAgo(request.createdAt, locale) })}
        </div>
      </div>
      <div className="flex shrink-0 items-center gap-1">
        <Button variant="outline" onClick={onDecline}>
          <HugeiconsIcon icon={Cancel01Icon} />
          {tUsers("requests.decline")}
        </Button>
        <Button onClick={onAccept}>
          <HugeiconsIcon icon={CheckmarkCircle02Icon} />
          {tUsers("requests.accept")}
        </Button>
      </div>
    </div>
  );
}
