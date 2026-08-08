import { apiClient } from "@/lib/api/client";

export interface IntraResponse {
  isNewUser: boolean;
  accessToken: string;
  name: string;
}

export type User = {
  username: string;
  isIntra: boolean;
  avatarUrl: string;
  createdAt: Date;
};

export const authService = {
  signUp: (username: string, password: string) => {
    return apiClient<{ accessToken: string }>("/auth/register", {
      method: "POST",
      body: { username, password }
    });
  },

  signIn: (username: string, password: string) => {
    return apiClient<{ accessToken: string }>("/auth/login", {
      method: "POST",
      body: { username, password }
    });
  },

  signOut: () => {
    return apiClient("/auth/logout", {
      method: "POST"
    });
  },

  intraLogin: () => {
    return apiClient<{ url: string }>("/auth/42/login", {
      method: "GET"
    });
  },

  intraCallback: (code: string) => {
    return apiClient<IntraResponse>("/auth/42/callback", {
      method: "POST",
      body: { code }
    });
  },

  intraComplete: (accessToken: string, username: string) => {
    return apiClient<{ accessToken: string }>("/auth/42/register", {
      method: "POST",
      body: { accessToken, username }
    });
  },

  getUser: () => {
    return apiClient<User>("/auth/me", {
      method: "GET"
    });
  }
};
