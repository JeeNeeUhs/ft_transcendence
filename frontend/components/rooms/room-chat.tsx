"use client";

import { useTranslations } from "next-intl";
import { type SubmitEvent, useEffect, useRef, useState } from "react";

import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { cn } from "@/lib/utils";
import { useUserStore } from "@/providers/user";
import { useRoomStore } from "@/stores/socket";

export interface ChatMsg {
  id: string;
  user: string;
  message: string;
  isSystem?: boolean;
  time: string;
}

interface RoomChatProps {
  messages: ChatMsg[];
  isConnected: boolean;
}

export function RoomChat({ messages, isConnected }: RoomChatProps) {
  const t = useTranslations("rooms.detail");
  const ws = useRoomStore((state) => state.ws);
  const currentUser = useUserStore((state) => state.user);
  const [inputMessage, setInputMessage] = useState("");
  const messagesEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (messages.length > 0) messagesEndRef.current?.scrollIntoView();
  }, [messages.length]);

  const handleSendMessage = (event: SubmitEvent<HTMLFormElement>) => {
    event.preventDefault();
    const trimmed = inputMessage.trim();
    if (!trimmed || !ws || ws.readyState !== WebSocket.OPEN) return;

    ws.send(JSON.stringify({ type: "chat", message: trimmed }));
    setInputMessage("");
  };

  return (
    <Card className="flex h-96 flex-col lg:h-auto lg:min-h-0 lg:flex-1">
      <CardHeader className="border-b">
        <CardTitle className="text-base">{t("chat.title")}</CardTitle>
      </CardHeader>

      <CardContent className="min-h-0 flex-1 space-y-4 overflow-y-auto" aria-live="polite">
        {messages.length === 0 ? (
          <div className="flex h-full items-center justify-center px-6 text-center text-xs text-muted-foreground">
            {t("chat.empty")}
          </div>
        ) : (
          messages.map((message) => {
            const isMe = currentUser?.username === message.user;

            if (message.isSystem) {
              return (
                <div key={message.id} className="flex justify-center">
                  <span className="rounded-full bg-muted px-2.5 py-1 text-[0.625rem] text-muted-foreground">
                    {message.message}
                  </span>
                </div>
              );
            }

            return (
              <div
                key={message.id}
                className={cn(
                  "flex max-w-[88%] flex-col",
                  isMe ? "ml-auto items-end" : "mr-auto items-start"
                )}
              >
                <div className="mb-1 flex items-baseline gap-2 px-1">
                  <span className="text-xs font-semibold text-foreground/80">{message.user}</span>
                  <span className="text-[0.625rem] text-muted-foreground">{message.time}</span>
                </div>
                <div
                  className={cn(
                    "break-words rounded-xl px-3.5 py-2 text-sm",
                    isMe
                      ? "rounded-tr-sm bg-primary text-primary-foreground"
                      : "rounded-tl-sm bg-muted text-foreground"
                  )}
                >
                  {message.message}
                </div>
              </div>
            );
          })
        )}
        <div ref={messagesEndRef} />
      </CardContent>

      <CardFooter className="border-t">
        <form onSubmit={handleSendMessage} className="flex w-full items-center gap-2">
          <Input
            aria-label={t("chat.message")}
            placeholder={isConnected ? t("chat.placeholder") : t("chat.connecting")}
            value={inputMessage}
            maxLength={500}
            onChange={(event) => setInputMessage(event.target.value)}
            disabled={!isConnected}
            autoComplete="off"
            className="flex-1"
          />
          <Button type="submit" disabled={!isConnected || !inputMessage.trim()}>
            {t("chat.send")}
          </Button>
        </form>
      </CardFooter>
    </Card>
  );
}
