import type { Metadata } from "next";
import Link from "next/link";
import { getTranslations } from "next-intl/server";

import { LegalDocument, type LegalSection } from "@/components/legal-document";

const sectionKeys = [
  "acceptance",
  "accounts",
  "conduct",
  "content",
  "availability",
  "changes"
] as const;

export async function generateMetadata(): Promise<Metadata> {
  const t = await getTranslations("terms");

  return {
    title: `${t("title")} | Quizinyo`,
    description: t("description")
  };
}

export default async function TermsPage() {
  const t = await getTranslations("terms");
  const tFooter = await getTranslations("footer");
  const sections: LegalSection[] = sectionKeys.map((key) => ({
    title: t(`sections.${key}.title`),
    paragraphs: [t(`sections.${key}.body`)]
  }));

  return (
    <>
      <LegalDocument title={t("title")} description={t("description")} sections={sections} />
      <footer className="mx-auto w-full max-w-6xl px-5">
        <div className="flex flex-col gap-5 border-t py-8 text-xs text-muted-foreground sm:flex-row sm:items-center sm:justify-between">
          <p>{tFooter("copyright")}</p>
          <nav className="flex items-center gap-5">
            <Link className="transition-colors hover:text-foreground" href="/privacy">
              {tFooter("privacy")}
            </Link>
            <Link className="transition-colors hover:text-foreground" href="/terms">
              {tFooter("terms")}
            </Link>
          </nav>
        </div>
      </footer>
    </>
  );
}
