import Image from "next/image";

import { cn, type Presence } from "@/lib/utils";

const avatarSizes = {
  sm: "size-9",
  lg: "size-24"
};

const dotSizes = {
  sm: "size-3",
  lg: "size-6"
};

const dotStyles: Record<Presence, string> = {
  online: "bg-success",
  lobby: "bg-warning",
  offline: "bg-muted-foreground/40"
};

export function UserAvatar({
  username,
  avatarUrl,
  status,
  size = "sm"
}: {
  username: string;
  avatarUrl?: string;
  status?: Presence;
  size?: keyof typeof avatarSizes;
}) {
  return (
    <div className={cn("relative shrink-0", avatarSizes[size])}>
      <div className="relative size-full overflow-hidden rounded-full bg-muted">
        {avatarUrl ? (
          <Image
            src={avatarUrl}
            alt={username}
            fill
            sizes="96px"
            unoptimized
            className="object-cover"
          />
        ) : (
          <div
            className={cn(
              "flex size-full items-center justify-center font-medium text-muted-foreground uppercase",
              size === "lg" ? "text-lg" : "text-[0.625rem]"
            )}
          >
            {username.slice(0, 2)}
          </div>
        )}
      </div>
      {status && (
        <span
          title={status}
          className={cn(
            "absolute right-0 bottom-0 rounded-full ring-2 ring-background",
            dotSizes[size],
            dotStyles[status]
          )}
        />
      )}
    </div>
  );
}
