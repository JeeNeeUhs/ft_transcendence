"use client";

import { CrownIcon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { useTranslations } from "next-intl";

import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import type { RoomUser, ScoreEntry } from "@/lib/api/room";
import { cn } from "@/lib/utils";
import { useUserStore } from "@/providers/user";

interface RoomUsersProps {
  users: RoomUser[];
  creator?: string;
  scoreboard?: ScoreEntry[];
  showScores?: boolean;
}

export function RoomUsers({ users, creator, scoreboard = [], showScores = false }: RoomUsersProps) {
  const t = useTranslations("rooms.detail");
  const currentUser = useUserStore((state) => state.user);
  const orderedUsers = showScores
    ? [...users].sort((a, b) => {
        const aScore = scoreboard.find((entry) => entry.username === a.username)?.score ?? 0;
        const bScore = scoreboard.find((entry) => entry.username === b.username)?.score ?? 0;
        return bScore - aScore || a.username.localeCompare(b.username);
      })
    : users;

  return (
    <Card className="flex max-h-96 flex-col lg:min-h-0 lg:max-h-none">
      <CardHeader className="border-b">
        <CardTitle className="flex items-center justify-between text-base">
          <span>{t("players.title")}</span>
          <Badge variant="secondary">{users.length}/20</Badge>
        </CardTitle>
      </CardHeader>
      <CardContent className="min-h-0 flex-1 space-y-2 overflow-y-auto">
        {orderedUsers.map((user) => {
          const isMe = currentUser?.username === user.username;
          const score = scoreboard.find((entry) => entry.username === user.username);
          return (
            <div
              key={user.username}
              className={cn(
                "flex items-center justify-between gap-2 rounded-md border border-transparent bg-muted/50 px-3 py-2.5 text-sm",
                isMe && "border-primary/20 bg-primary/5"
              )}
            >
              <span className="flex min-w-0 items-center gap-1 font-medium">
                <span className="truncate">{user.username}</span>
                {user.username === creator && (
                  <HugeiconsIcon
                    icon={CrownIcon}
                    className="size-3.5 shrink-0 text-muted-foreground"
                    aria-label={t("players.host")}
                  />
                )}
                {isMe && (
                  <span className="text-xs font-normal text-muted-foreground">{t("you")}</span>
                )}
              </span>
              {showScores ? (
                <span className="shrink-0 font-mono text-xs font-semibold tabular-nums">
                  {t("game.score", { score: score?.score ?? 0 })}
                </span>
              ) : (
                <Badge variant={user.ready ? "default" : "outline"}>
                  {user.ready ? t("players.ready") : t("players.notReady")}
                </Badge>
              )}
            </div>
          );
        })}
      </CardContent>
    </Card>
  );
}
