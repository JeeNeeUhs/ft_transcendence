import { create } from "zustand";
import type { RoomState } from "@/lib/api/room";

type RoomStore = {
  ws: WebSocket | null;
  room: RoomState | null;
  setWs: (ws: WebSocket | null, room?: RoomState | null) => void;
  clearWs: () => void;
};

export const useRoomStore = create<RoomStore>((set) => ({
  ws: null,
  room: null,
  setWs: (ws, room = null) => set({ ws, room }),
  clearWs: () => set({ ws: null, room: null })
}));
