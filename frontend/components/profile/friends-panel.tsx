"use client";

import { AnimatePresence, motion } from "motion/react";
import { useTranslations } from "next-intl";
import { useEffect, useState } from "react";

import { AddFriendForm } from "@/components/profile/add-friend-form";
import { FriendRequestPopup } from "@/components/profile/friend-request-popup";
import { FriendRow } from "@/components/profile/friend-row";
import { SectionHeader } from "@/components/section-header";
import { Badge } from "@/components/ui/badge";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { type Friend, friendService } from "@/lib/api/friend";
import { type Presence, presenceStatus } from "@/lib/utils";

const presenceOrder: Record<Presence, number> = {
  online: 0,
  lobby: 1,
  offline: 2
};

export function FriendsPanel({ username, isSelf }: { username: string; isSelf: boolean }) {
  const tUsers = useTranslations("users");
  const tError = useTranslations("error");

  const [friends, setFriends] = useState<Friend[]>([]);
  const [requests, setRequests] = useState<Friend[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [acceptingUsername, setAcceptingUsername] = useState<string | null>(null);
  const [removingUsername, setRemovingUsername] = useState<string | null>(null);

  useEffect(() => {
    const fetchFriends = async () => {
      setIsLoading(true);
      setRequests([]);

      // pending requests are always the caller's own, there is nothing to show on someone else
      const [listResponse, requestsResponse] = await Promise.all([
        friendService.userList(username),
        isSelf ? friendService.requests() : null
      ]);

      if (!listResponse.success || (requestsResponse !== null && !requestsResponse.success)) {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: tError("fetchError")
        });

        setIsLoading(false);
        return;
      }

      setFriends(listResponse.data);
      if (requestsResponse?.success) setRequests(requestsResponse.data);
      setIsLoading(false);
    };

    fetchFriends();
  }, [username, isSelf, tError]);

  const acceptRequest = async (request: Friend) => {
    setAcceptingUsername(request.username);
    const response = await friendService.accept(request.username);
    setAcceptingUsername(null);

    if (!response.success) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tError(`codes.${response.errorCode}`)
      });

      return;
    }

    setRequests((current) => current.filter((item) => item.username !== request.username));
    setFriends((current) => [...current, request]);
  };

  const removeFriend = async (friend: Friend) => {
    setRemovingUsername(friend.username);
    const response = await friendService.remove(friend.username);
    setRemovingUsername(null);

    if (!response.success) {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tError("fetchError")
      });
      return;
    }

    setFriends((current) => current.filter((item) => item.username !== friend.username));
    toast.add({
      type: "success",
      title: tUsers("friends.removed", { username: friend.username })
    });
  };

  const sortedFriends = friends
    .map((friend) => ({ ...friend, presence: presenceStatus(friend.status) }))
    .sort((a, b) => {
      if (a.presence === b.presence) return a.username.localeCompare(b.username);
      return presenceOrder[a.presence] - presenceOrder[b.presence];
    });

  const onlineCount = sortedFriends.filter((friend) => friend.presence !== "offline").length;

  return (
    <div className="my-10 space-y-5">
      {isSelf && <AddFriendForm />}

      <div className="space-y-3">
        <SectionHeader
          title={tUsers("friends.title")}
          action={
            <Badge variant="outline">
              {tUsers("friends.onlineCount", { online: onlineCount, total: friends.length })}
            </Badge>
          }
        />
        {isLoading ? (
          <div className="flex items-center justify-center gap-x-2 py-10 text-xs/relaxed text-muted-foreground">
            <Spinner />
            {tUsers("friends.loading")}
          </div>
        ) : (
          <>
            {requests.length > 0 && (
              <div className="space-y-2">
                <AnimatePresence initial={false}>
                  {requests.map((request) => (
                    <motion.div
                      key={request.username}
                      initial={{ opacity: 0, y: -8 }}
                      animate={{ opacity: 1, y: 0 }}
                      exit={{ opacity: 0, y: -8 }}
                      transition={{ duration: 0.15 }}
                    >
                      <FriendRequestPopup
                        request={request}
                        isAccepting={acceptingUsername === request.username}
                        onAccept={() => acceptRequest(request)}
                      />
                    </motion.div>
                  ))}
                </AnimatePresence>
              </div>
            )}
            {sortedFriends.length > 0 ? (
              <div className="space-y-1">
                {sortedFriends.map((friend) => (
                  <FriendRow
                    key={friend.username}
                    username={friend.username}
                    avatarUrl={friend.avatarUrl}
                    status={friend.status}
                    onRemove={isSelf ? () => removeFriend(friend) : undefined}
                    isRemoving={removingUsername === friend.username}
                  />
                ))}
              </div>
            ) : (
              <p className="py-10 text-center text-xs/relaxed text-muted-foreground">
                {isSelf ? tUsers("friends.empty") : tUsers("friends.emptyUser", { username })}
              </p>
            )}
          </>
        )}
      </div>
    </div>
  );
}
