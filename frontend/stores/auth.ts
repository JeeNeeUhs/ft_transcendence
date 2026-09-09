import { createStore } from "zustand/vanilla";
import type { User } from "@/lib/api/auth";

type UserState = {
  user: User | null;
  isloading: boolean;
};

type UserStateActions = {
  setUser: (user: User) => void;
  clearUser: () => void;
};

const defaultInitState: UserState = {
  user: null,
  isloading: true
};

export type UserStore = UserState & UserStateActions;

export function createUserStore(initState: UserState = defaultInitState) {
  return createStore<UserStore>()((set) => ({
    ...initState,
    setUser: (user: User) => set({ user, isloading: false }),
    clearUser: () => set({ user: null, isloading: false })
  }));
}
