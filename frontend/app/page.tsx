import { getTranslations } from "next-intl/server";
import { Navbar } from "@/components/navbar";

export default async function Home() {
  const t = await getTranslations("home");

  return (
    <div className="w-full px-5 max-w-6xl mx-auto">
      <Navbar />
      <div className="mt-20">
        <div className="text-3xl">{t("welcome")}</div>
        <div className="text-sm text-muted-foreground mt-2">{t("description")}</div>
      </div>
    </div>
  );
}
