import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";

import { LegalDocument, type LegalSection } from "@/components/legal-document";

const sectionKeys = ["data", "use", "sharing", "storage", "choices", "changes"] as const;

export async function generateMetadata(): Promise<Metadata> {
  const t = await getTranslations("privacy");

  return {
    title: `${t("title")} | Quizinyo`,
    description: t("description")
  };
}

export default async function PrivacyPage() {
  const t = await getTranslations("privacy");
  const sections: LegalSection[] = sectionKeys.map((key) => ({
    title: t(`sections.${key}.title`),
    paragraphs: [t(`sections.${key}.body`)]
  }));

  return <LegalDocument title={t("title")} description={t("description")} sections={sections} />;
}
