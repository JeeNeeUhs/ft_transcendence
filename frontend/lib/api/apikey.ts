import { apiClient } from "@/lib/api/client";

export interface ApiKey {
  key: string;
  isActive: boolean;
  createdAt: string;
}

// the backend answers with code 50 when the account has no key yet
export const API_KEY_NOT_FOUND = 50;

export const apiKeyService = {
  get: () => {
    return apiClient<ApiKey>("/apikey", {
      method: "GET"
    });
  },

  create: () => {
    return apiClient<{ message: string; key: string }>("/apikey", {
      method: "POST"
    });
  },

  remove: () => {
    return apiClient<{ message: string }>("/apikey", {
      method: "DELETE"
    });
  }
};
