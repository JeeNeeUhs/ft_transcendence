import { Toaster } from "@/components/ui/toast";
import { ThemeProvider } from "@/providers/theme";
import { UserStoreProvider } from "@/providers/user";

export async function Providers({ children }: { children: React.ReactNode }) {
  return (
    <>
      <ThemeProvider attribute="class" defaultTheme="system" enableSystem disableTransitionOnChange>
        <UserStoreProvider>{children}</UserStoreProvider>
      </ThemeProvider>
      <Toaster />
    </>
  );
}
