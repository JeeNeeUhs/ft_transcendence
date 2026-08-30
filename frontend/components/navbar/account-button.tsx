"use client";

import { User02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import Link from "next/link";
import { useTranslations } from "next-intl";

import { AuthDialog } from "@/components/auth/dialog";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger
} from "@/components/ui/dropdown-menu";
import { authService, type User } from "@/lib/api/auth";
import { useUserStore } from "@/providers/user";

function AccountDropdown({ user, onSignOut }: { user: User; onSignOut: () => void }) {
  const tProfile = useTranslations("profile");
  const tAuth = useTranslations("auth");

  return (
    <DropdownMenu>
      <DropdownMenuTrigger
        render={
          <Button size="lg">
            <HugeiconsIcon icon={User02Icon} />
            {user.username}
          </Button>
        }
      ></DropdownMenuTrigger>
      <DropdownMenuContent>
        <DropdownMenuGroup>
          <DropdownMenuItem>{tProfile("myAccount")}</DropdownMenuItem>
          <DropdownMenuItem render={<Link href="/settings" />}>
            {tProfile("settings")}
          </DropdownMenuItem>
          <DropdownMenuSeparator />
          <DropdownMenuItem onClick={onSignOut}>{tAuth("signOut")}</DropdownMenuItem>
        </DropdownMenuGroup>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}

export function AccountButton() {
  const { user, clearUser } = useUserStore((state) => state);

  const handleSignOut = async () => {
    await authService.signOut();

    localStorage.removeItem("access_token");
    clearUser();
  };

  return user ? <AccountDropdown user={user} onSignOut={handleSignOut} /> : <AuthDialog />;
}
