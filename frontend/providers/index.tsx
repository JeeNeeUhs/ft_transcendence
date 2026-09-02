import { NextIntlClientProvider } from "next-intl";
import { getLocale, getMessages } from "next-intl/server";

import { Toaster } from "@/components/ui/toast";
import { TooltipProvider } from "@/components/ui/tooltip";
import { ThemeProvider } from "@/providers/theme";
import { UserStoreProvider } from "@/providers/user";

export async function Providers({ children }: { children: React.ReactNode }) {
  const locale = await getLocale();
  const messages = await getMessages();

  return (
    <NextIntlClientProvider locale={locale} messages={messages}>
      <ThemeProvider attribute="class" defaultTheme="system" enableSystem disableTransitionOnChange>
        <UserStoreProvider>
          <TooltipProvider>{children}</TooltipProvider>
        </UserStoreProvider>
      </ThemeProvider>
      <Toaster />
    </NextIntlClientProvider>
  );
}
