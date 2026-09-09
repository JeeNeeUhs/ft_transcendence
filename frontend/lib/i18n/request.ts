import { getRequestConfig } from "next-intl/server";

import { getLocaleFromCookie } from "@/lib/i18n/cookie";

export default getRequestConfig(async () => {
  const locale = await getLocaleFromCookie();

  return {
    locale,
    messages: (await import(`../../messages/${locale}.json`)).default
  };
});
