"use client";

import { ComputerIcon, SquareLock02Icon, User02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { AnimatePresence, motion } from "motion/react";
import { useTranslations } from "next-intl";
import { useState } from "react";

import { ApiKeySection } from "@/components/settings/api-key-section";
import { PasswordSection } from "@/components/settings/password-section";
import { ProfileSection } from "@/components/settings/profile-section";
import { Button } from "@/components/ui/button";

type SettingsView = "profile" | "password" | "apiKey";

export function SettingsPanel() {
  const tSettings = useTranslations("settings");
  const [view, setView] = useState<SettingsView>("profile");

  const navItems: { value: SettingsView; label: string; icon: typeof User02Icon }[] = [
    { value: "profile", label: tSettings("nav.profile"), icon: User02Icon },
    { value: "password", label: tSettings("nav.password"), icon: SquareLock02Icon },
    { value: "apiKey", label: tSettings("nav.apiKey"), icon: ComputerIcon }
  ];

  const sections = {
    profile: ProfileSection,
    password: PasswordSection,
    apiKey: ApiKeySection
  };

  const ActiveSection = sections[view];

  return (
    <div className="my-10 flex flex-col gap-5 md:flex-row md:gap-10">
      <nav className="flex gap-1 overflow-x-auto md:w-48 md:shrink-0 md:flex-col md:self-start md:overflow-visible">
        {navItems.map((item) => (
          <Button
            key={item.value}
            size="lg"
            variant={view === item.value ? "secondary" : "ghost"}
            className="shrink-0 justify-start md:w-full"
            onClick={() => setView(item.value)}
          >
            <HugeiconsIcon icon={item.icon} />
            {item.label}
          </Button>
        ))}
      </nav>

      <div className="min-w-0 flex-1">
        <AnimatePresence initial={false} mode="wait">
          <motion.div
            key={view}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.1 }}
          >
            <ActiveSection />
          </motion.div>
        </AnimatePresence>
      </div>
    </div>
  );
}
