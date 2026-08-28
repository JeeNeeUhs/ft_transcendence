import { AccountButton } from "@/components/navbar/account-button";
import { LocaleSwitcher } from "@/components/navbar/locale-switcher";
import { ThemeSwitcher } from "@/components/navbar/theme-switcher";

export function Navbar() {
  return (
    <div className="flex justify-between items-center my-5 w-full px-5 max-w-6xl mx-auto">
      <h1>Quizinyo</h1>
      <div className="flex items-center gap-x-2">
        <LocaleSwitcher />
        <ThemeSwitcher />
        <AccountButton />
      </div>
    </div>
  );
}
