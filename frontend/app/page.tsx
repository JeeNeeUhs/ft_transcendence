import Link from "next/link";
import { getTranslations } from "next-intl/server";

import { Button } from "@/components/ui/button";

export default async function Home() {
  const t = await getTranslations("home");
  const steps = ["room", "invite", "play"] as const;

  return (
    <main className="mx-auto w-full max-w-6xl px-5">
      <section className="grid items-center gap-12 py-16 md:py-24 lg:grid-cols-[1.05fr_0.95fr] lg:gap-20 lg:py-28">
        <div className="max-w-2xl">
          <p className="mb-5 text-xs font-medium tracking-[0.16em] text-muted-foreground uppercase">
            {t("eyebrow")}
          </p>
          <h1 className="text-4xl leading-[1.08] font-medium tracking-[-0.04em] text-balance sm:text-5xl lg:text-6xl">
            {t("title")}
          </h1>
          <p className="mt-6 max-w-xl text-base leading-7 text-muted-foreground sm:text-lg">
            {t("description")}
          </p>

          <div className="mt-8 flex flex-wrap items-center gap-2">
            <Link href="/rooms">
              <Button size="lg">{t("primaryAction")}</Button>
            </Link>
          </div>
        </div>
      </section>

      <section id="how-it-works" className="scroll-mt-8 border-t py-12 md:py-16">
        <div className="grid gap-10 md:grid-cols-[0.8fr_2fr] md:gap-16">
          <div>
            <p className="text-xs font-medium tracking-[0.16em] text-muted-foreground uppercase">
              {t("howItWorks.eyebrow")}
            </p>
            <h2 className="mt-3 text-2xl font-medium tracking-tight">{t("howItWorks.title")}</h2>
          </div>

          <div className="grid gap-8 sm:grid-cols-3 sm:gap-6">
            {steps.map((step, index) => (
              <div key={step}>
                <p className="font-mono text-xs text-muted-foreground">
                  {String(index + 1).padStart(2, "0")}
                </p>
                <h3 className="mt-4 text-sm font-medium">{t(`steps.${step}.title`)}</h3>
                <p className="mt-2 text-xs leading-5 text-muted-foreground">
                  {t(`steps.${step}.description`)}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </main>
  );
}
