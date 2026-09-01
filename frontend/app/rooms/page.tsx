"use client";

import { useLocale, useTranslations } from "next-intl";
import { useEffect, useState } from "react";

import { SignedIn } from "@/components/auth/auth-guard";
import { CreateRoomDialog } from "@/components/rooms/create-room-dialog";
import { RoomBrowser } from "@/components/rooms/room-browser";
import { toast } from "@/components/ui/toast";
import { type Category, roomService } from "@/lib/api/room";

export default function RoomsPage() {
  const tRooms = useTranslations("rooms");
  const tError = useTranslations("error");
  const locale = useLocale();

  const [categories, setCategories] = useState<Category[]>([]);

  useEffect(() => {
    const fetchCategories = async () => {
      const response = await roomService.categories(locale);
      if (!response.success) {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: tError("fetchError")
        });

        return;
      }

      setCategories(response.data.categories);
    };

    fetchCategories();
  }, [locale, tError]);

  return (
    <div className="w-full px-5 max-w-6xl mx-auto">
      <div className="mt-20 flex justify-between items-start">
        <div>
          <h1 className="text-3xl">{tRooms("title")}</h1>
          <p className="text-muted-foreground mt-2">{tRooms("description")}</p>
        </div>
        <SignedIn>
          <div className="flex items-center gap-x-1">
            <CreateRoomDialog categories={categories} locale={locale} />
          </div>
        </SignedIn>
      </div>
      <RoomBrowser categories={categories} locale={locale} />
    </div>
  );
}
