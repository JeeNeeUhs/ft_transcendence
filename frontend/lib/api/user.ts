import { apiClient } from "@/lib/api/client";

export const userService = {
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
