"use client";

import { MoreHorizontalIcon, UserRemove02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import Link from "next/link";
import { useTranslations } from "next-intl";

import { UserAvatar } from "@/components/profile/user-avatar";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger
} from "@/components/ui/dropdown-menu";
import { Spinner } from "@/components/ui/spinner";
import { presenceStatus } from "@/lib/utils";

export function FriendRow({
  username,
  avatarUrl,
  status,
  onRemove,
  isRemoving = false
}: {
  username: string;
  avatarUrl?: string;
  status?: number;
  onRemove?: () => void;
  isRemoving?: boolean;
}) {
  const tUsers = useTranslations("users");

  const presence = presenceStatus(status);
  const subtitle = tUsers(`status.${presence}`);

  return (
    <div className="flex items-center rounded-lg transition-colors hover:bg-muted/50">
      <Link
        href={`/users/${username}`}
        className="flex min-w-0 flex-1 items-center gap-3 px-2 py-2"
      >
        <UserAvatar username={username} avatarUrl={avatarUrl} status={presence} />
        <div className="min-w-0 flex-1">
          <div className="truncate text-xs/relaxed font-medium">{username}</div>
          <div className="truncate text-xs/relaxed text-muted-foreground">{subtitle}</div>
        </div>
      </Link>
      {onRemove && (
        <DropdownMenu>
          <DropdownMenuTrigger
            render={
              <Button
                variant="ghost"
                size="icon"
                disabled={isRemoving}
                aria-label={tUsers("friends.actions", { username })}
                className="mr-1"
              />
            }
          >
            {isRemoving ? <Spinner /> : <HugeiconsIcon icon={MoreHorizontalIcon} />}
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuItem variant="destructive" onClick={onRemove}>
              <HugeiconsIcon icon={UserRemove02Icon} />
              {tUsers("friends.remove")}
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      )}
    </div>
  );
}
