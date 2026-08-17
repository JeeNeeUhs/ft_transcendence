import { cookies } from "next/headers";
import { getRequestConfig } from "next-intl/server";

import {
  LOCALE_COOKIE_NAME,
  type Locale,
  defaultLocale,
  isValidLocale
} from "@/i18n/config";

async function getLocaleFromRequest(): Promise<Locale> {
  const cookieStore = await cookies();
  const cookieValue = cookieStore.get(LOCALE_COOKIE_NAME)?.value;

  if (isValidLocale(cookieValue)) {
    return cookieValue;
  }

  return defaultLocale;
}

export default getRequestConfig(async () => {
  const locale = await getLocaleFromRequest();

  return {
    locale,
    messages: (await import(`../messages/${locale}.json`)).default
  };
});
