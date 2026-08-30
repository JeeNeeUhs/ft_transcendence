import type { Metadata, Viewport } from "next";
import { Geist } from "next/font/google";
import { getLocale } from "next-intl/server";

import { Navbar } from "@/components/navbar";
import { ServiceWorkerRegister } from "@/components/pwa/sw-register";
import { cn } from "@/lib/utils";
import { Providers } from "@/providers";
import "@/app/globals.css";

const geist = Geist({ subsets: ["latin"], variable: "--font-sans" });

export const metadata: Metadata = {
  title: "ft_transcendence",
  description: "Quizinyo - Trivia & Multiplayer Quiz Game",
  manifest: "/manifest.webmanifest",
  appleWebApp: {
    capable: true,
    statusBarStyle: "default",
    title: "Transcendence"
  },
  icons: {
    icon: "/icons/icon-192x192.png",
    apple: "/icons/icon-192x192.png"
  }
};

export const viewport: Viewport = {
  themeColor: "#000000"
};

export default async function RootLayout({
  children
}: Readonly<{
  children: React.ReactNode;
}>) {
  const locale = await getLocale();

  return (
    <html lang={locale} className={cn("font-sans", geist.variable)} suppressHydrationWarning>
      <body>
        <Providers>
          <ServiceWorkerRegister />
          <Navbar />
          {children}
        </Providers>
      </body>
    </html>
  );
}
