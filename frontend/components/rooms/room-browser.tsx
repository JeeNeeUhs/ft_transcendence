"use client";

import {
  AmericanFootballIcon,
  Atom02Icon,
  Book02Icon,
  BookOpen02Icon,
  ComputerIcon,
  DashboardSquare02Icon,
  FlimSlateIcon,
  GameController03Icon,
  MapingIcon,
  MusicNote03Icon,
  PaintBoardIcon,
  SquareLock02Icon,
  UserMultiple02Icon
} from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import Image from "next/image";
import Link from "next/link";
import { useTranslations } from "next-intl";
import { useEffect, useState } from "react";

import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from "@/components/ui/select";
import { toast } from "@/components/ui/toast";
import { type Category, type Room, roomService } from "@/lib/api/room";
import { timeAgo } from "@/lib/utils";

export function RoomBrowser({ categories, locale }: { categories: Category[]; locale: string }) {
  const tLang = useTranslations("languages");
  const tRooms = useTranslations("rooms");
  const tError = useTranslations("error");

  const [searchQuery, setSearchQuery] = useState("");
  const [categoryFilter, setCategoryFilter] = useState("all");
  const [langFilter, setLangFilter] = useState(locale);

  const [rooms, setRooms] = useState<Room[]>([]);

  useEffect(() => {
    const fetchRooms = async () => {
      const response = await roomService.list();
      if (!response.success) {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: tError("fetchError")
        });

        return;
      }

      setRooms(response.data.rooms);
    };

    fetchRooms();
  }, [tError]);

  // biome-ignore lint/suspicious/noExplicitAny: the icon type is not exported by library
  const categoryIcons: Record<number, any> = {
    1: Atom02Icon,
    2: Book02Icon,
    3: MapingIcon,
    4: AmericanFootballIcon,
    5: PaintBoardIcon,
    6: ComputerIcon,
    7: BookOpen02Icon,
    8: MusicNote03Icon,
    9: FlimSlateIcon,
    10: GameController03Icon
  };

  const categoryItems = [
    {
      label: tRooms("allFilter"),
      icon: DashboardSquare02Icon,
      value: "all"
    },
    ...categories.map((category) => ({
      label: category.name,
      icon: categoryIcons[category.id] || DashboardSquare02Icon,
      value: category.id.toString()
    }))
  ];

  const selectedCategory = categoryItems.find((item) => item.value === categoryFilter);
  const filteredRooms = rooms.filter((room) => {
    const matchesSearch = room.name.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCategory =
      categoryFilter === "all" || room.categoryIds.includes(parseInt(categoryFilter, 10));
    const matchesLang = langFilter === "all" || room.lang === langFilter;

    return matchesSearch && matchesCategory && matchesLang;
  });

  return (
    <div className="my-10 space-y-5">
      <div className="flex gap-x-2 justify-between">
        <Input
          placeholder={tRooms("search")}
          className="max-w-70"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        <div className="flex gap-2">
          <Select value={langFilter} onValueChange={(value) => setLangFilter(value ?? "all")}>
            <SelectTrigger className="w-fit">
              <SelectValue>
                <div className="flex items-center gap-x-2">
                  <Image
                    src={`/flags/${langFilter}.svg`}
                    width={16}
                    height={12}
                    alt={langFilter}
                    className="w-[16px] h-[12px] object-cover"
                  />
                  <span>{tLang(langFilter)}</span>
                </div>
              </SelectValue>
            </SelectTrigger>
            <SelectContent>
              {["all", "tr", "en", "es"].map((lang) => (
                <SelectItem key={lang} value={lang}>
                  <span>{tLang(lang)}</span>
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          <Select
            value={categoryFilter}
            onValueChange={(value) => setCategoryFilter(value ?? "all")}
          >
            <SelectTrigger className="w-fit">
              <SelectValue>
                {selectedCategory ? (
                  <div className="flex items-center gap-x-2">
                    <HugeiconsIcon icon={selectedCategory.icon} size={16} />
                    <span>{selectedCategory.label}</span>
                  </div>
                ) : (
                  "Select"
                )}
              </SelectValue>
            </SelectTrigger>
            <SelectContent>
              {categoryItems.map((item) => (
                <SelectItem key={item.value} value={item.value}>
                  <span>{item.label}</span>
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-2">
        {filteredRooms.length > 0 ? (
          filteredRooms.map((room) => (
            <Card key={room.id}>
              <CardHeader>
                <CardTitle className="flex gap-x-1 items-center">
                  {room.hasPassword && (
                    <HugeiconsIcon icon={SquareLock02Icon} size={12} className="shrink-0" />
                  )}
                  {room.name.length > 25 ? `${room.name.slice(0, 25)}...` : room.name}
                </CardTitle>
                <CardDescription className="flex gap-x-1">
                  <Badge variant="outline">
                    <HugeiconsIcon icon={UserMultiple02Icon} /> {room.userCount}/20
                  </Badge>
                  <Badge variant="outline" className="flex items-center gap-1">
                    <Image src={`/flags/${room.lang}.svg`} width={12} height={12} alt={room.lang} />
                    {tLang(room.lang)}
                  </Badge>
                </CardDescription>
                <CardAction>
                  <Link href={`/rooms/${room.id}`}>
                    <Button variant={"secondary"}>Join</Button>
                  </Link>
                </CardAction>
              </CardHeader>
              <CardContent className="flex flex-wrap gap-1 items-center">
                <div>{tRooms("card.categories")}:</div>
                {room.categoryIds.map((catId) => {
                  const category = categoryItems.find((item) => item.value === catId.toString());
                  if (!category) return null;
                  return (
                    <Badge key={catId} variant="secondary" className="flex gap-1 items-center">
                      <HugeiconsIcon icon={category.icon} size={12} /> {category.label}
                    </Badge>
                  );
                })}
              </CardContent>
              <CardFooter className="text-muted-foreground mt-auto">
                {tRooms("card.footer", {
                  time: timeAgo(room.createdAt, locale),
                  user: room.creator
                })}
              </CardFooter>
            </Card>
          ))
        ) : (
          <div className="col-span-full text-sm text-center py-10 text-muted-foreground">
            {tRooms("emptyList")}
          </div>
        )}
      </div>
    </div>
  );
}
