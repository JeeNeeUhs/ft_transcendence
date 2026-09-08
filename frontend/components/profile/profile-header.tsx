"use client";

import Link from "next/link";
import { useLocale, useTranslations } from "next-intl";
import { useEffect, useState } from "react";

import { UserAvatar } from "@/components/profile/user-avatar";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { type FriendshipStatus, friendService } from "@/lib/api/friend";
import type { UserProfile } from "@/lib/api/user";
import { presenceStatus } from "@/lib/utils";

type RequestState = FriendshipStatus | "loading" | "sending";

export function ProfileHeader({ profile, isSelf }: { profile: UserProfile; isSelf: boolean }) {
  const tUsers = useTranslations("users");
  const tError = useTranslations("error");
  const locale = useLocale();
  const [requestState, setRequestState] = useState<RequestState>("loading");

  const memberSince = new Intl.DateTimeFormat(locale, { dateStyle: "long" }).format(
    new Date(profile.createdAt)
  );

  useEffect(() => {
    if (isSelf) return;

    let cancelled = false;
    setRequestState("loading");

    const loadStatus = async () => {
      const response = await friendService.status(profile.username);
      if (!cancelled) setRequestState(response.success ? response.data.status : "none");
    };

    loadStatus();
    return () => {
      cancelled = true;
    };
  }, [isSelf, profile.username]);

  const sendFriendRequest = async () => {
    const previousState = requestState;
    setRequestState("sending");
    const response = await friendService.send(profile.username);

    if (!response.success) {
      const statusResponse = await friendService.status(profile.username);
      setRequestState(statusResponse.success ? statusResponse.data.status : "none");
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: response.status === 409 ? tUsers("add.alreadySent") : tError("fetchError")
      });
      return;
    }

    const accepted = previousState === "pending_received";
    setRequestState(accepted ? "accepted" : "pending_sent");
    toast.add({
      type: "success",
      title: accepted
        ? tUsers("add.accepted", { username: profile.username })
        : tUsers("add.sent", { username: profile.username })
    });
  };

  const buttonText =
    requestState === "accepted"
      ? tUsers("add.alreadyFriends")
      : requestState === "pending_sent"
        ? tUsers("add.requestSent")
        : requestState === "pending_received"
          ? tUsers("requests.accept")
          : tUsers("add.profileButton");

  return (
    <div className="mt-20 flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
      <div className="flex items-start gap-4">
        <UserAvatar
          username={profile.username}
          avatarUrl={profile.avatarUrl}
          status={presenceStatus(profile.status)}
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
            <Badge variant="outline">{tUsers("memberSince", { date: memberSince })}</Badge>
          </div>
        </div>
      </div>

      {isSelf ? (
        <Link href="/settings">
          <Button variant="secondary" size="lg">
            {tUsers("editProfile")}
          </Button>
        </Link>
      ) : (
        <Button
          size="lg"
          variant={requestState === "accepted" ? "secondary" : "default"}
          onClick={sendFriendRequest}
          disabled={
            requestState === "loading" ||
            requestState === "sending" ||
            requestState === "pending_sent" ||
            requestState === "accepted"
          }
        >
          {(requestState === "loading" || requestState === "sending") && <Spinner />}
          {buttonText}
        </Button>
      )}
    </div>
  );
}
