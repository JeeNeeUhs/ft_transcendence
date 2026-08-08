"use client";

import { User02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";

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
          <DropdownMenuItem>profile.myAccount</DropdownMenuItem>
          <DropdownMenuItem>profile.settings</DropdownMenuItem>
          <DropdownMenuSeparator />
          <DropdownMenuItem onClick={onSignOut}>auth.signOut</DropdownMenuItem>
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
