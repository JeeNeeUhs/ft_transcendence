import { apiClient, getAccessToken } from "@/lib/api/client";

export interface Room {
  id: string;
  name: string;
  creator: string;
  userCount: number;
  categoryIds: number[];
  lang: string;
  createdAt: number;
  hasPassword: boolean;
  started: boolean;
}

export interface Category {
  id: number;
  name: string;
}

async function connectSocket(
  endpoint: string,
  payload: Record<string, string | number | number[] | undefined>
): Promise<WebSocket> {
  return new Promise((resolve, reject) => {
    const baseurl = process.env.NEXT_PUBLIC_API_URL || "";
    const wsurl = baseurl.replace(/^http/, "ws");

    const params = new URLSearchParams();

    for (const [key, value] of Object.entries(payload)) {
      if (value === undefined || value === "") continue;

      if (Array.isArray(value))
        value.forEach((v) => {
          params.append(key, v.toString());
        });
      else params.append(key, value.toString());
    }

    const accessToken = getAccessToken() || "";
    const ws = new WebSocket(
      `${wsurl}/api${endpoint}?${params.toString().replace(/\+/g, "%20")}`,
      accessToken
    );

    ws.onopen = () => {
      resolve(ws);
    };

    ws.onerror = () => {
      reject();
    };

    // ws.onclose = (event) => {};
  });
}

export const roomService = {
  categories: (lang: string) => {
    return apiClient<{ categories: Category[] }>(`/room/categories?lang=${lang}`, {
      method: "GET"
    });
  },

  list: () => {
    return apiClient<{ rooms: Room[] }>("/room/list", {
      method: "GET"
    });
  },

  create: (name: string, password: string | undefined, categories: number[], locale: string) => {
    return connectSocket("/room/create", {
      name: name,
      password: password,
      category_ids: categories,
      lang: locale
    });
  },

  join: (id: string, password: string | undefined) => {
    return connectSocket("/room/join", {
      room_id: id,
      password: password
    });
  }
};
