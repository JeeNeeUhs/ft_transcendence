"use client";

import { AnimatePresence, motion } from "motion/react";
import { usePathname } from "next/navigation";
import { createContext, useContext, useEffect, useState } from "react";
import { useStore } from "zustand";

import { authService } from "@/lib/api/auth";
import { createUserStore, type UserStore } from "@/stores/auth";

export type UserStoreApi = ReturnType<typeof createUserStore>;

export const UserStoreContext = createContext<UserStoreApi | undefined>(undefined);

export function UserStoreProvider({ children }: { children: React.ReactNode }) {
  const [store] = useState(() => createUserStore());
  const isloading = useStore(store, (state) => state.isloading);
  const pathname = usePathname();

  const isCallbackPage = pathname?.includes("/oauth");

  useEffect(() => {
    if (isCallbackPage) {
      store.getState().clearUser();
      return;
    }

    const initUser = async () => {
      const token = localStorage.getItem("access_token");

      if (!token) {
        store.getState().clearUser();
        return;
      }

      const response = await authService.getUser();
      if (response.success) {
        store.getState().setUser(response.data);
      } else {
        localStorage.removeItem("access_token");
        store.getState().clearUser();
      }
    };

    initUser();
  }, [store, isCallbackPage]);

  if (isCallbackPage)
    return <UserStoreContext.Provider value={store}>{children}</UserStoreContext.Provider>;

  return (
    <UserStoreContext.Provider value={store}>
      <AnimatePresence mode="wait">
        {isloading && !isCallbackPage ? (
          <motion.div
            key="loader"
            exit={{ opacity: 0 }}
            transition={{ duration: 0.3 }}
            className="w-screen h-screen flex items-center justify-center"
          >
            <div className="text-2xl">Quizinyo</div>
          </motion.div>
        ) : (
          <motion.div
            key="content"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.3 }}
            className="h-full w-full"
          >
            {children}
          </motion.div>
        )}
      </AnimatePresence>
    </UserStoreContext.Provider>
  );
}

export function useUserStore<T>(selector: (store: UserStore) => T): T {
  const userStoreContext = useContext(UserStoreContext);
  if (!userStoreContext) throw new Error("useUserStore must be used within UserStoreProvider");

  return useStore(userStoreContext, selector);
}
