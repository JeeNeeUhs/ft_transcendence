import { AuthDialog } from "@/components/auth/dialog";
import { ThemeSwitcher } from "@/components/theme-switcher";

export default function Home() {
  return (
    <div className="w-full px-5 max-w-6xl mx-auto">
      <div className="flex justify-between my-5 items-center">
        <h1>Quizinyo</h1>
        <div className="flex items-center gap-x-2">
          <ThemeSwitcher />
          <AuthDialog />
        </div>
      </div>
    </div>
  );
}
