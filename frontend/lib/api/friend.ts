import { apiClient } from "@/lib/api/client";

export interface Friend {
  username: string;
  avatarUrl: string;
  status: number;
}

export const friendService = {
  list: () => {
    return apiClient<Friend[]>("/friend/list", {
      method: "GET"
    });
  },

  requests: () => {
    return apiClient<Friend[]>("/friend/requests", {
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
