import { useRouter } from "next/navigation";
import { useLocale } from "next-intl";
import { useTransition } from "react";

import { isValidLocale, type Locale, locales } from "@/lib/i18n/config";

interface UseLocaleSwitchReturn {
  locale: Locale;
  locales: readonly Locale[];
  isLoading: boolean;
  changeLocale: (newLocale: Locale) => Promise<void>;
}

export function useLocaleSwitch(): UseLocaleSwitchReturn {
  const currentLocale = useLocale() as Locale;
  const router = useRouter();

  const [isPending, startTransition] = useTransition();

  async function changeLocale(newLocale: Locale): Promise<void> {
    if (newLocale === currentLocale) return;
    if (!isValidLocale(newLocale)) throw new Error(`Unsupported locale: ${newLocale}`);

    try {
      const response = await fetch("/api/locale", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ locale: newLocale })
      });

      if (!response.ok) throw new Error(`Failed to set locale (status ${response.status})`);

      startTransition(() => {
        router.refresh();
      });
    } catch {}
  }

  return {
    locale: currentLocale,
    locales,
    isLoading: isPending,
    changeLocale
  };
}
