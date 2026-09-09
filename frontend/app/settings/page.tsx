"use client";

import { useTranslations } from "next-intl";

import { SignedIn, SignedOut } from "@/components/auth/auth-guard";
import { ProtectedRoute } from "@/components/auth/protected-route";
import { SettingsPanel } from "@/components/settings/settings-panel";

export default function SettingPage() {
  const tSettings = useTranslations("settings");

  return (
    <div className="w-full px-5 max-w-6xl mx-auto">
      <SignedOut>
        <div className="mt-20 text-xs/relaxed text-muted-foreground">
          {tSettings("signInRequired")}
        </div>
      </SignedOut>
      <ProtectedRoute>
        <SignedIn>
          <div className="mt-20">
            <h1 className="text-3xl">{tSettings("title")}</h1>
            <p className="text-muted-foreground mt-2">{tSettings("description")}</p>
          </div>
          <SettingsPanel />
        </SignedIn>
      </ProtectedRoute>
    </div>
  );
}
