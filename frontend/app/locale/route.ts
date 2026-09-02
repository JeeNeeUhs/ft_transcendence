import { NextResponse } from "next/server";

import { isValidLocale, type Locale, locales } from "@/lib/i18n/config";
import { setLocaleCookie } from "@/lib/i18n/cookie";

export async function POST(request: Request): Promise<NextResponse> {
  let body: unknown;

  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON body" }, { status: 400 });
  }

  const rawLocale = (body as { locale?: unknown })?.locale;
  const localeCandidate = typeof rawLocale === "string" ? rawLocale : undefined;

  if (!isValidLocale(localeCandidate)) {
    return NextResponse.json(
      {
        error: `Unsupported locale. Supported locales: ${locales.join(", ")}`
      },
      { status: 400 }
    );
  }

  const locale: Locale = localeCandidate;

  await setLocaleCookie(locale);

  return NextResponse.json({ locale }, { status: 200 });
}
