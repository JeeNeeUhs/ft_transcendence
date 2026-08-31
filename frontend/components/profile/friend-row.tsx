"use client";

import Link from "next/link";
import { useTranslations } from "next-intl";

import { UserAvatar } from "@/components/profile/user-avatar";

export function FriendRow({
  username,
  avatarUrl,
  description,
  status
}: {
  username: string;
  avatarUrl?: string;
  description?: string;
  status?: string;
}) {
  const tUsers = useTranslations("users");

  const subtitle =
    description || (status === "online" ? tUsers("status.online") : tUsers("status.offline"));

  return (
    <Link
      href={`/users/${username}`}
      className="flex items-center gap-3 rounded-lg px-2 py-2 transition-colors hover:bg-muted/50"
    >
      <UserAvatar username={username} avatarUrl={avatarUrl} status={status} />
      <div className="min-w-0 flex-1">
        <div className="truncate text-xs/relaxed font-medium">{username}</div>
        <div className="truncate text-xs/relaxed text-muted-foreground">{subtitle}</div>
      </div>
    </Link>
  );
}
