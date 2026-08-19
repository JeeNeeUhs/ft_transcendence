import { cookies } from "next/headers";

import {
  defaultLocale,
  isValidLocale,
  LOCALE_COOKIE_MAX_AGE,
  LOCALE_COOKIE_NAME,
  type Locale
} from "@/lib/i18n/config";

export async function getLocaleFromCookie(): Promise<Locale> {
  const cookieStore = await cookies();
  const cookieValue = cookieStore.get(LOCALE_COOKIE_NAME)?.value;

  if (isValidLocale(cookieValue)) return cookieValue;

  return defaultLocale;
}

export async function setLocaleCookie(locale: Locale): Promise<void> {
  const cookieStore = await cookies();

  cookieStore.set(LOCALE_COOKIE_NAME, locale, {
    maxAge: LOCALE_COOKIE_MAX_AGE,
    path: "/",
    sameSite: "lax"
  });
}
