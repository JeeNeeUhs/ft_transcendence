import { ThemeSwitcher } from "@/components/theme-switcher";

export default function Home() {
  return (
    <div className="px-5">
      <div className="w-full flex justify-between my-5">
        <h1>quiz sekli</h1>
        <ThemeSwitcher />
      </div>
    </div>
  );
}
