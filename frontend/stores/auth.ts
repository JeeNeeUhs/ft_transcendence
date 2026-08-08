import { createStore } from "zustand/vanilla";
import type { User } from "@/lib/api/auth";

export type UserState = {
  user: User | null;
  isloading: boolean;
};

export type UserStateActions = {
  setUser: (user: User) => void;
  clearUser: () => void;
};

export type UserStore = UserState & UserStateActions;

export const defaultInitState: UserState = {
  user: null,
  isloading: true
};

export function createUserStore(initState: UserState = defaultInitState) {
  return createStore<UserStore>()((set) => ({
    ...initState,
    setUser: (user: User) => set({ user, isloading: false }),
    clearUser: () => set({ user: null, isloading: false })
  }));
}
