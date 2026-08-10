import { AccountButton } from "@/components/navbar/account-button";
import { ThemeSwitcher } from "@/components/navbar/theme-switcher";

export function Navbar() {
  return (
    <div className="flex justify-between my-5 items-center">
      <h1 className="font-black">Quizinyo</h1>
      <div className="flex items-center gap-x-2">
        <ThemeSwitcher />
        <AccountButton />
      </div>
    </div>
  );
}
