"use client";

import { AnimatePresence, motion } from "motion/react";
import { useTranslations } from "next-intl";
import { useState } from "react";

import { AddFriendForm } from "@/components/profile/add-friend-form";
import { FriendRequestPopup } from "@/components/profile/friend-request-popup";
import { FriendRow } from "@/components/profile/friend-row";
import { SectionHeader } from "@/components/section-header";
import { Badge } from "@/components/ui/badge";
import {
  type Friend,
  type FriendRequest,
  mockFriendRequests,
  mockFriends
} from "@/lib/mock/friends";

const newestFirst = (a: FriendRequest, b: FriendRequest) => b.createdAt - a.createdAt;

export function FriendsPanel({ isSelf }: { isSelf: boolean }) {
  const tUsers = useTranslations("users");

  // TODO: every profile shows the same fixture until the backend exposes friendships
  const [friends, setFriends] = useState<Friend[]>(mockFriends);
  const [requests, setRequests] = useState<FriendRequest[]>(() =>
    [...mockFriendRequests].sort(newestFirst)
  );

  const sortedFriends = [...friends].sort((a, b) => {
    if (a.status === b.status) return a.username.localeCompare(b.username);
    return a.status === "online" ? -1 : 1;
  });

  const onlineCount = friends.filter((friend) => friend.status === "online").length;
  const pendingRequests = isSelf ? requests : [];

  // TODO: local only, both of these need an endpoint that does not exist yet
  const acceptRequest = (request: FriendRequest) => {
    setFriends((current) => [
      ...current,
      {
        username: request.username,
        avatarUrl: request.avatarUrl,
        description: request.description,
        status: "offline"
      }
    ]);
    setRequests((current) => current.filter((item) => item.username !== request.username));
  };

  const declineRequest = (request: FriendRequest) => {
    setRequests((current) => current.filter((item) => item.username !== request.username));
  };

  return (
    <div className="my-10 space-y-5">
      {isSelf && <AddFriendForm />}

      <div className="space-y-3">
        <SectionHeader
          title={tUsers("friends.title")}
          description={tUsers("friends.description")}
          action={
            <Badge variant="outline">
              {tUsers("friends.onlineCount", { online: onlineCount, total: friends.length })}
            </Badge>
          }
        />
        {pendingRequests.length > 0 && (
          <div className="space-y-2">
            <AnimatePresence initial={false}>
              {pendingRequests.map((request) => (
                <motion.div
                  key={request.username}
                  initial={{ opacity: 0, y: -8 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, y: -8 }}
                  transition={{ duration: 0.15 }}
                >
                  <FriendRequestPopup
                    request={request}
                    onAccept={() => acceptRequest(request)}
                    onDecline={() => declineRequest(request)}
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
                description={friend.description}
                status={friend.status}
              />
            ))}
          </div>
        ) : (
          <p className="py-10 text-center text-xs/relaxed text-muted-foreground">
            {tUsers("friends.empty")}
          </p>
        )}
      </div>
    </div>
  );
}
