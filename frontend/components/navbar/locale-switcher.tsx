"use client";

import { Globe02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";

import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuTrigger
} from "@/components/ui/dropdown-menu";
import { useLocaleSwitch } from "@/lib/i18n/use-locale";

const localeNames = {
  tr: "Türkçe",
  en: "English",
  es: "Español"
};

export function LocaleSwitcher() {
  const { locale, locales, isLoading, changeLocale } = useLocaleSwitch();

  return (
    <DropdownMenu>
      <DropdownMenuTrigger render={<Button variant="outline" size="icon" disabled={isLoading} />}>
        <HugeiconsIcon icon={Globe02Icon} />
      </DropdownMenuTrigger>
      <DropdownMenuContent>
        <DropdownMenuGroup>
          {locales.map((loc) => (
            <DropdownMenuItem key={loc} onClick={() => changeLocale(loc)} disabled={loc === locale}>
              {localeNames[loc]}
            </DropdownMenuItem>
          ))}
        </DropdownMenuGroup>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
