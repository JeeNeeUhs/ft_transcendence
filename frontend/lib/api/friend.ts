import { apiClient } from "@/lib/api/client";

export interface Friend {
  username: string;
  avatarUrl: string;
  status: number;
}

export type FriendshipStatus = "none" | "pending_sent" | "pending_received" | "accepted" | "self";

export const friendService = {
  list: () => {
    return apiClient<Friend[]>("/friend/list", {
      method: "GET"
    });
  },

  userList: (username: string) => {
    return apiClient<Friend[]>(`/friend/list/${encodeURIComponent(username)}`, {
      method: "GET"
    });
  },

  requests: () => {
    return apiClient<Friend[]>("/friend/requests", {
      method: "GET"
    });
  },

  status: (username: string) => {
    return apiClient<{ status: FriendshipStatus }>(`/friend/status/${username}`, {
      method: "GET"
    });
  },

  send: (username: string) => {
    return apiClient<{ message: string }>("/friend/request", {
      method: "POST",
      body: { username }
    });
  },

  accept: (username: string) => {
    return apiClient<{ message: string }>("/friend/accept", {
      method: "POST",
      body: { username }
    });
  }
};
