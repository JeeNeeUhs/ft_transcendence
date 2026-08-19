import { useTranslations } from "next-intl";

import { AccountButton } from "@/components/navbar/account-button";
import { LocaleSwitcher } from "@/components/navbar/locale-switcher";
import { ThemeSwitcher } from "@/components/navbar/theme-switcher";

export function Navbar() {
  const t = useTranslations("common");

  return (
    <div className="flex justify-between my-5 items-center">
      <h1 className="font-black">{t("appName")}</h1>
      <div className="flex items-center gap-x-2">
        <LocaleSwitcher />
        <ThemeSwitcher />
        <AccountButton />
      </div>
    </div>
  );
}
