import { apiClient } from "@/lib/api/client";

export const maxAvatarSize = 5 * 1024 * 1024;
export const avatarTypes = ["image/jpeg", "image/png"];

export interface UserProfile {
  username: string;
  avatarUrl: string;
  description: string;
  status: number;
  createdAt: string;
}

export const userService = {
  profile: (username: string) => {
    return apiClient<UserProfile>(`/user/${encodeURIComponent(username)}`, {
      method: "GET"
    });
  },

  uploadAvatar: (file: File) => {
    const body = new FormData();
    body.append("avatar", file);

    return apiClient<{ avatarUrl: string }>("/user/avatar", {
      method: "POST",
      body
    });
  },

  updateDescription: (description: string) => {
    return apiClient<{ description: string }>("/user/me", {
      method: "PATCH",
      body: { description }
    });
  },

  updatePassword: (currentPassword: string, newPassword: string) => {
    return apiClient<{ accessToken: string }>("/user/me/password", {
      method: "PUT",
      body: { currentPassword, newPassword }
    });
  }
};
