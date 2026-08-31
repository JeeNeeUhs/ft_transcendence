"use client";

import Link from "next/link";
import { useLocale, useTranslations } from "next-intl";

import { UserAvatar } from "@/components/profile/user-avatar";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import type { UserProfile } from "@/lib/api/user";

export function ProfileHeader({ profile, isSelf }: { profile: UserProfile; isSelf: boolean }) {
  const tUsers = useTranslations("users");
  const locale = useLocale();

  const memberSince = new Intl.DateTimeFormat(locale, { dateStyle: "long" }).format(
    new Date(profile.createdAt)
  );

  return (
    <div className="mt-20 flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
      <div className="flex items-start gap-4">
        <UserAvatar
          username={profile.username}
          avatarUrl={profile.avatarUrl}
          status={profile.status}
          size="lg"
        />
        <div className="space-y-2 pt-1">
          <div>
            <h1 className="text-3xl">{profile.username}</h1>
            <p className="mt-1 text-xs/relaxed text-muted-foreground">
              {profile.description || tUsers("noBio")}
            </p>
          </div>
          <div className="flex flex-wrap items-center gap-1">
            <Badge variant="secondary">
              {profile.status === "online" ? tUsers("status.online") : tUsers("status.offline")}
            </Badge>
            <Badge variant="outline">{tUsers("memberSince", { date: memberSince })}</Badge>
          </div>
        </div>
      </div>

      {isSelf && (
        <Link href="/settings">
          <Button variant="secondary" size="lg">
            {tUsers("editProfile")}
          </Button>
        </Link>
      )}
    </div>
  );
}
