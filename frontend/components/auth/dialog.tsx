"use client";

import { User02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { AnimatePresence, motion } from "motion/react";
import Image from "next/image";
import { useCallback, useState } from "react";

import { IntraButton } from "@/components/auth/intra-button";
import { IntraSetupForm } from "@/components/auth/intra-setup-form";
import { SignInForm } from "@/components/auth/sign-in-form";
import { SignUpForm } from "@/components/auth/sign-up-form";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger
} from "@/components/ui/dialog";
import { FieldSeparator } from "@/components/ui/field";
import { authService, type IntraResponse } from "@/lib/api/auth";
import { useUserStore } from "@/providers/user";

export type AuthView = "signIn" | "signUp" | "intraSetup";

function AuthDialogContent({ onSuccess }: { onSuccess: (accessToken: string) => void }) {
  const [formView, setFormView] = useState<AuthView>("signIn");
  const [intraResponse, setIntraResponse] = useState<IntraResponse | null>(null);

  const ActiveForm = formView === "signIn" ? SignInForm : SignUpForm;

  const toggleFormView = () => setFormView(formView === "signIn" ? "signUp" : "signIn");
  const handleIntraSetup = useCallback((response: IntraResponse) => {
    setIntraResponse(response);
    setFormView("intraSetup");
  }, []);

  return (
    <div className="flex">
      <AnimatePresence initial={false} mode="wait">
        <motion.div
          key={formView}
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          exit={{ opacity: 0, x: -20 }}
          transition={{ duration: 0.1 }}
          className="flex flex-1 flex-col justify-center gap-5 p-6 md:p-10"
        >
          {formView === "intraSetup" && intraResponse ? (
            <>
              <DialogHeader>
                <DialogTitle>auth.$formView.title</DialogTitle>
                <DialogDescription>auth.$formView.desc</DialogDescription>
              </DialogHeader>
              <IntraSetupForm response={intraResponse} onSuccess={onSuccess} />
            </>
          ) : (
            <>
              <DialogHeader>
                <DialogTitle>auth.$formView.title</DialogTitle>
                <DialogDescription>auth.$formView.desc</DialogDescription>
              </DialogHeader>
              <IntraButton onSuccess={onSuccess} onIntraSetup={handleIntraSetup} />
              <FieldSeparator className="mt-0.5 *:data-[slot=field-separator-content]:bg-card">
                auth.separator
              </FieldSeparator>

              <ActiveForm onSuccess={onSuccess} />
              <div className="text-center text-muted-foreground">
                auth.$formView.footer{" "}
                <button type="button" className="underline cursor-pointer" onClick={toggleFormView}>
                  auth.$formView.action
                </button>
              </div>
            </>
          )}
        </motion.div>
      </AnimatePresence>
      <div className="hidden md:flex flex-1 p-10 relative">
        <Image
          src="/placeholder.jpg"
          alt="Placeholder Image"
          fill
          sizes="(max-width: 768px) 0vw, 50vw"
          className="object-cover"
        />
      </div>
    </div>
  );
}

export function AuthDialog() {
  const [open, setOpen] = useState<boolean>(false);
  const setUser = useUserStore((state) => state.setUser);

  const handleAuthSuccess = useCallback(
    async (accessToken: string) => {
      localStorage.setItem("access_token", accessToken);

      const response = await authService.getUser();
      if (!response.success) return;

      setOpen(false);

      // delay global state update to allow exit animation to finish
      setTimeout(() => {
        setUser(response.data);
      }, 300);
    },
    [setUser]
  );

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger
        render={
          <Button size="lg">
            <HugeiconsIcon icon={User02Icon} /> auth.signIn
          </Button>
        }
      />
      <DialogContent className="sm:max-w-4xl w-[95vw] h-150 p-0 overflow-hidden">
        <AuthDialogContent onSuccess={handleAuthSuccess} />
      </DialogContent>
    </Dialog>
  );
}
