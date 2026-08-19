export const locales = ["en", "tr", "es"] as const;
export const defaultLocale: Locale = "tr";

export type Locale = (typeof locales)[number];

export const LOCALE_COOKIE_NAME = "user-locale";
export const LOCALE_COOKIE_MAX_AGE = 60 * 60 * 24 * 365;

export function isValidLocale(value: string | undefined | null): value is Locale {
  return typeof value === "string" && (locales as readonly string[]).includes(value);
}
