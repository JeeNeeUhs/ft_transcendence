import { apiClient, getAccessToken } from "@/lib/api/client";
import { convertKeysToCamelCase } from "@/lib/utils";

export interface Category {
  id: number;
  name: string;
}

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

export interface RoomUser {
  username: string;
  ready: boolean;
}

export type RoomState = Omit<Room, "userCount"> & {
  users: RoomUser[];
};

export type AnswerOption = "A" | "B" | "C" | "D";

export interface QuizQuestion {
  id: number;
  categoryId: number;
  questionText: string;
  optionA: string;
  optionB: string;
  optionC: string;
  optionD: string;
  difficulty: string;
  language: string;
}

export interface ScoreEntry {
  username: string;
  score: number;
  rank: number;
}

export interface QuestionResult {
  username: string;
  option: AnswerOption | null;
  correct: boolean;
  points: number;
  ms: number | null;
}

function connectSocket(
  endpoint: string,
  payload: Record<string, string | number | number[] | undefined>
): Promise<{ ws: WebSocket; room: RoomState }> {
  return new Promise((resolve, reject) => {
    const wsProtocol = window.location.protocol === "https:" ? "wss:" : "ws:";
    const wsurl = `${wsProtocol}//${window.location.host}`;

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
    if (!accessToken) {
      reject(new Error("Unauthorized: Access token is missing"));
      return;
    }

    const ws = new WebSocket(
      `${wsurl}/api${endpoint}?${params.toString().replace(/\+/g, "%20")}`,
      accessToken
    );

    let isHandshakeDone = false;

    const cleanup = () => {
      ws.removeEventListener("message", handleInitialMessage);
      ws.removeEventListener("error", handleInitialError);
      ws.removeEventListener("close", handleInitialClose);
    };

    const handleInitialMessage = (event: MessageEvent) => {
      try {
        const raw = JSON.parse(event.data);
        if (raw.type === "error") {
          isHandshakeDone = true;
          cleanup();
          try {
            ws.close();
          } catch {}
          reject(new Error(raw.message || `Error code: ${raw.code}`));
          return;
        }

        if (raw.type === "room_state" && raw.room) {
          isHandshakeDone = true;
          cleanup();
          const room = convertKeysToCamelCase<RoomState>(raw.room);
          resolve({ ws, room });
        }
      } catch {}
    };

    const handleInitialError = () => {
      if (!isHandshakeDone) {
        cleanup();
        reject(new Error("Failed to connect to room server"));
      }
    };

    const handleInitialClose = (event: CloseEvent) => {
      if (!isHandshakeDone) {
        cleanup();
        reject(new Error(event.reason || "Connection closed"));
      }
    };

    ws.addEventListener("message", handleInitialMessage);
    ws.addEventListener("error", handleInitialError);
    ws.addEventListener("close", handleInitialClose);
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
