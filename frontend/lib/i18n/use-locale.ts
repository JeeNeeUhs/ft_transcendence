import { useLocale } from "next-intl";
import { useState } from "react";

import { locales, type Locale, isValidLocale } from "@/i18n/config";

interface UseLocaleSwitchReturn {
  locale: Locale;
  locales: readonly Locale[];
  isLoading: boolean;
  changeLocale: (newLocale: Locale) => Promise<void>;
}

export function useLocaleSwitch(): UseLocaleSwitchReturn {
  const currentLocale = useLocale() as Locale;
  const [isLoading, setIsLoading] = useState(false);

  async function changeLocale(newLocale: Locale): Promise<void> {
    if (newLocale === currentLocale) {
      return;
    }

    if (!isValidLocale(newLocale)) {
      throw new Error(`Unsupported locale: ${newLocale}`);
    }

    setIsLoading(true);

    try {
      const response = await fetch("/api/locale", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ locale: newLocale })
      });

      if (!response.ok) {
        throw new Error(`Failed to set locale (status ${response.status})`);
      }

      window.location.reload();
    } finally {
      setIsLoading(false);
    }
  }

  return {
    locale: currentLocale,
    locales,
    isLoading,
    changeLocale
  };
}
