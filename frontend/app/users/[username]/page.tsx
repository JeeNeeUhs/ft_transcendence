"use client";

import { useParams } from "next/navigation";
import { useTranslations } from "next-intl";
import { useEffect, useState } from "react";

import { SignedIn, SignedOut } from "@/components/auth/auth-guard";
import { ProtectedRoute } from "@/components/auth/protected-route";
import { FriendsPanel } from "@/components/profile/friends-panel";
import { ProfileHeader } from "@/components/profile/profile-header";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { type UserProfile, userService } from "@/lib/api/user";
import { useUserStore } from "@/providers/user";

const userNotFound = 46;

function UserProfileContent({ username }: { username: string }) {
  const tUsers = useTranslations("users");
  const tError = useTranslations("error");

  const currentUser = useUserStore((state) => state.user);

  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  useEffect(() => {
    const fetchProfile = async () => {
      setIsLoading(true);

      const response = await userService.profile(username);
      if (!response.success) {
        if (response.errorCode !== userNotFound) {
          toast.add({
            type: "error",
            title: tError("genericTitle"),
            description: tError("fetchError")
          });
        }

        setProfile(null);
        setIsLoading(false);
        return;
      }

      setProfile(response.data);
      setIsLoading(false);
    };

    fetchProfile();
  }, [username, tError]);

  if (isLoading)
    return (
      <div className="mt-20 flex items-center gap-x-2 text-xs/relaxed text-muted-foreground">
        <Spinner />
        {tUsers("loading")}
      </div>
    );

  if (!profile)
    return (
      <div className="mt-20 space-y-2">
        <h1 className="text-3xl">{tUsers("notFound")}</h1>
        <p className="text-muted-foreground">{tUsers("notFoundDescription", { username })}</p>
      </div>
    );

  const isSelf = currentUser?.username === profile.username;

  return (
    <>
      <ProfileHeader profile={profile} isSelf={isSelf} />
      {isSelf && <FriendsPanel />}
    </>
  );
}

export default function UserProfilePage() {
  const tUsers = useTranslations("users");
  const params = useParams<{ username: string }>();

  return (
    <div className="w-full px-5 max-w-6xl mx-auto">
      <SignedOut>
        <div className="mt-20 text-xs/relaxed text-muted-foreground">
          {tUsers("signInRequired")}
        </div>
      </SignedOut>
      <ProtectedRoute>
        <SignedIn>
          <UserProfileContent username={params.username} />
        </SignedIn>
      </ProtectedRoute>
    </div>
  );
}
