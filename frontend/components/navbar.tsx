import { useTranslations } from "next-intl";
import { AccountButton } from "@/components/auth/account-button";
import { ThemeSwitcher } from "@/components/theme-switcher";

export function Navbar() {
  const t = useTranslations("common");

  return (
    <div className="flex justify-between my-5 items-center">
      <h1 className="font-black">{t("appName")}</h1>
      <div className="flex items-center gap-x-2">
        <ThemeSwitcher />
        <AccountButton />
      </div>
    </div>
  );
}
