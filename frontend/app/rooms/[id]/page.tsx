"use client";

import { CopyIcon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import Image from "next/image";
import { useParams, useRouter } from "next/navigation";
import { useLocale, useTranslations } from "next-intl";
import { useEffect, useRef, useState } from "react";

import { ProtectedRoute } from "@/components/auth/protected-route";
import { JoinRoomDialog } from "@/components/rooms/join-room-dialog";
import { type ChatMsg, RoomChat } from "@/components/rooms/room-chat";
import { RoomGame, type RoomGameState } from "@/components/rooms/room-game";
import { RoomUsers } from "@/components/rooms/room-users";
import { Button } from "@/components/ui/button";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import {
  type AnswerOption,
  type QuestionResult,
  type QuizQuestion,
  type RoomState,
  roomService,
  type ScoreEntry
} from "@/lib/api/room";
import { convertKeysToCamelCase } from "@/lib/utils";
import { useUserStore } from "@/providers/user";
import { useRoomStore } from "@/stores/socket";

type RoomPageStatus = "loading" | "password" | "ready";

interface RoomSocketEvent {
  type: string;
  user?: string;
  message?: string;
  room?: RoomState;
  value?: number;
  index?: number;
  total?: number;
  duration?: number;
  question?: QuizQuestion;
  answered?: number;
  correctOption?: AnswerOption;
  results?: QuestionResult[];
  scoreboard?: ScoreEntry[];
}

function initialGameState(room: RoomState | null): RoomGameState {
  return {
    phase: "lobby",
    countdown: null,
    question: null,
    questionIndex: 0,
    questionTotal: 0,
    duration: 20,
    timeLeft: 20,
    answeredCount: 0,
    selectedOption: null,
    correctOption: null,
    results: [],
    scoreboard: (room?.users ?? []).map((user) => ({
      username: user.username,
      score: 0,
      rank: 1
    }))
  };
}

function createChatMessage(user: string, message: string, isSystem = false): ChatMsg {
  return {
    id: crypto.randomUUID(),
    user,
    message,
    isSystem,
    time: new Date().toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })
  };
}

export default function RoomPage() {
  const params = useParams();
  const router = useRouter();
  const locale = useLocale();
  const t = useTranslations("rooms.detail");
  const tError = useTranslations("error");
  const currentUser = useUserStore((state) => state.user);
  const roomId = String(params?.id ?? "").toUpperCase();

  const { ws, room: storedRoom, clearWs, setWs } = useRoomStore((state) => state);
  const matchingInitialRoom = storedRoom?.id === roomId ? storedRoom : null;
  const matchingInitialWs = matchingInitialRoom ? ws : null;

  const [pageStatus, setPageStatus] = useState<RoomPageStatus>(
    matchingInitialWs ? "ready" : "loading"
  );
  const [room, setRoom] = useState<RoomState | null>(matchingInitialRoom);
  const [categoryNames, setCategoryNames] = useState<string[]>([]);
  const [messages, setMessages] = useState<ChatMsg[]>([]);
  const [game, setGame] = useState<RoomGameState>(() => initialGameState(matchingInitialRoom));

  const answerDeadlineRef = useRef(0);
  const intentionalLeaveRef = useRef(false);
  const connectionEndedRef = useRef(false);
  const unmountTimerRef = useRef<number | null>(null);

  useEffect(() => {
    if (storedRoom?.id === roomId) setRoom(storedRoom);
  }, [roomId, storedRoom]);

  const categoryIds = room?.categoryIds.join(",") ?? "";

  useEffect(() => {
    if (!categoryIds) return;

    const loadCategories = async () => {
      const response = await roomService.categories(locale);
      if (!response.success) return;

      const ids = categoryIds.split(",").map(Number);
      setCategoryNames(
        response.data.categories
          .filter((category) => ids.includes(category.id))
          .map((category) => category.name)
      );
    };

    loadCategories();
  }, [categoryIds, locale]);

  useEffect(() => {
    if (connectionEndedRef.current) return;

    if (ws && storedRoom?.id === roomId) {
      setPageStatus("ready");
      return;
    }

    if (ws && storedRoom && storedRoom.id !== roomId) {
      router.replace(`/rooms/${storedRoom.id}`);
      return;
    }

    let mounted = true;

    const initializeRoom = async () => {
      const response = await roomService.list();
      if (!mounted) return;

      if (!response.success) {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: t("errors.joinFailed")
        });
        router.replace("/rooms");
        return;
      }

      const targetRoom = response.data.rooms.find((candidate) => candidate.id === roomId);
      if (!targetRoom) {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: t("errors.notFound")
        });
        router.replace("/rooms");
        return;
      }

      if (targetRoom.started || targetRoom.userCount >= 20) {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: t(targetRoom.started ? "errors.started" : "errors.full")
        });
        router.replace("/rooms");
        return;
      }

      if (targetRoom.hasPassword) {
        setPageStatus("password");
        return;
      }

      try {
        const joined = await roomService.join(roomId, undefined);
        if (!mounted) {
          joined.ws.close();
          return;
        }
        setWs(joined.ws, joined.room);
        setRoom(joined.room);
        setGame(initialGameState(joined.room));
        setPageStatus("ready");
      } catch {
        if (!mounted) return;
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: t("errors.joinFailed")
        });
        router.replace("/rooms");
      }
    };

    initializeRoom();
    return () => {
      mounted = false;
    };
  }, [roomId, router, setWs, storedRoom, t, tError, ws]);

  useEffect(() => {
    if (!ws || storedRoom?.id !== roomId) return;

    const handleClose = () => {
      connectionEndedRef.current = true;
      clearWs();
      if (intentionalLeaveRef.current) return;

      toast.add({
        type: "error",
        title: t("status.disconnected"),
        description: t("errors.connectionLost")
      });
      router.replace("/rooms");
    };

    const handleMessage = (event: MessageEvent) => {
      let data: RoomSocketEvent;
      try {
        data = convertKeysToCamelCase<RoomSocketEvent>(JSON.parse(event.data));
      } catch {
        return;
      }

      switch (data.type) {
        case "room_state":
          if (data.room) {
            setRoom(data.room);
            setGame(initialGameState(data.room));
          }
          break;
        case "user_joined":
        case "user_left":
          if (data.room) {
            setRoom(data.room);
            setGame((previous) => ({
              ...previous,
              scoreboard:
                data.room?.users.map((user) => {
                  const existing = previous.scoreboard.find(
                    (entry) => entry.username === user.username
                  );
                  return {
                    username: user.username,
                    score: existing?.score ?? 0,
                    rank: existing?.score ? existing.rank : 1
                  };
                }) ?? previous.scoreboard
            }));
          }
          if (data.user && data.user !== currentUser?.username) {
            const message = t(data.type === "user_joined" ? "system.joined" : "system.left", {
              user: data.user
            });
            setMessages((previous) => [...previous, createChatMessage("System", message, true)]);
          }
          break;
        case "chat_message":
          if (data.user && data.message) {
            const user = data.user;
            const message = data.message;
            setMessages((previous) => [...previous, createChatMessage(user, message)]);
          }
          break;
        case "ready_changed":
          if (data.room) setRoom(data.room);
          break;
        case "countdown":
          setGame((previous) => ({
            ...previous,
            phase: "countdown",
            countdown: data.value ?? null
          }));
          break;
        case "question":
          if (!data.question || data.index === undefined || data.total === undefined) break;
          {
            const question = data.question;
            const questionIndex = data.index;
            const questionTotal = data.total;
            const duration = data.duration ?? 20;

            answerDeadlineRef.current = Date.now() + duration * 1000;
            setGame((previous) => ({
              ...previous,
              phase: "question",
              countdown: null,
              question,
              questionIndex,
              questionTotal,
              duration,
              timeLeft: duration,
              answeredCount: 0,
              selectedOption: null,
              correctOption: null,
              results: []
            }));
          }
          break;
        case "answer_received":
          setGame((previous) => ({ ...previous, answeredCount: data.answered ?? 0 }));
          break;
        case "question_result":
          setGame((previous) => ({
            ...previous,
            phase: "result",
            timeLeft: 0,
            correctOption: data.correctOption ?? null,
            results: data.results ?? [],
            scoreboard: data.scoreboard ?? []
          }));
          break;
        case "finish":
          if (data.room) setRoom(data.room);
          setGame((previous) => ({
            ...previous,
            phase: "finished",
            question: null,
            scoreboard: data.scoreboard ?? []
          }));
          break;
        case "error":
          toast.add({
            type: "error",
            title: tError("genericTitle"),
            description: data.message ?? t("errors.server")
          });
          break;
      }
    };

    ws.addEventListener("close", handleClose);
    ws.addEventListener("message", handleMessage);

    return () => {
      ws.removeEventListener("close", handleClose);
      ws.removeEventListener("message", handleMessage);
    };
  }, [clearWs, currentUser?.username, roomId, router, storedRoom?.id, t, tError, ws]);

  useEffect(() => {
    if (game.phase !== "question") return;

    const updateTimer = () => {
      const remaining = Math.max(0, (answerDeadlineRef.current - Date.now()) / 1000);
      setGame((previous) => ({ ...previous, timeLeft: remaining }));
    };

    updateTimer();
    const timer = window.setInterval(updateTimer, 100);
    return () => window.clearInterval(timer);
  }, [game.phase]);

  useEffect(() => {
    if (!ws) return;
    if (unmountTimerRef.current !== null) window.clearTimeout(unmountTimerRef.current);

    return () => {
      unmountTimerRef.current = window.setTimeout(() => {
        if (useRoomStore.getState().ws !== ws) return;
        intentionalLeaveRef.current = true;
        connectionEndedRef.current = true;
        if (ws.readyState === WebSocket.OPEN) ws.send(JSON.stringify({ type: "leave" }));
        ws.close();
        clearWs();
      }, 0);
    };
  }, [clearWs, ws]);

  const sendReady = (ready: boolean) => {
    if (!ws || ws.readyState !== WebSocket.OPEN) return;
    if (game.phase === "finished") {
      setGame((previous) => ({ ...previous, phase: "lobby" }));
    }
    ws.send(JSON.stringify({ type: "ready", ready }));
  };

  const sendAnswer = (option: AnswerOption) => {
    if (
      !ws ||
      ws.readyState !== WebSocket.OPEN ||
      game.phase !== "question" ||
      game.selectedOption
    ) {
      return;
    }
    setGame((previous) => ({ ...previous, selectedOption: option }));
    ws.send(JSON.stringify({ type: "answer", index: game.questionIndex, option }));
  };

  const handleCopyCode = async () => {
    try {
      await navigator.clipboard.writeText(roomId);
      toast.add({ type: "success", title: t("copied"), description: roomId });
    } catch {
      toast.add({ type: "error", title: tError("genericTitle"), description: t("copyFailed") });
    }
  };

  const handleLeave = () => {
    intentionalLeaveRef.current = true;
    connectionEndedRef.current = true;
    if (ws?.readyState === WebSocket.OPEN) ws.send(JSON.stringify({ type: "leave" }));
    ws?.close();
    clearWs();
    router.push("/rooms");
  };

  const isLoading = !ws || pageStatus !== "ready" || !room;
  const isConnected = ws?.readyState === WebSocket.OPEN;

  return (
    <ProtectedRoute>
      <JoinRoomDialog
        roomId={roomId}
        open={pageStatus === "password"}
        onOpenChange={(open) => {
          if (open) return;
          if (useRoomStore.getState().ws) setPageStatus("ready");
          else router.replace("/rooms");
        }}
      />

      {isLoading ? (
        <div className="flex min-h-[60vh] w-full flex-col items-center justify-center gap-4 px-5">
          <Spinner className="size-8" />
          <p className="text-sm text-muted-foreground">
            {pageStatus === "password" ? t("loading.password") : t("loading.connecting")}
          </p>
        </div>
      ) : (
        <main className="mx-auto w-full max-w-6xl px-4 pb-10 pt-5 sm:px-5 sm:pt-8 lg:flex lg:h-[calc(100dvh-4.5rem)] lg:flex-col lg:overflow-hidden lg:pb-6 lg:pt-4">
          <header className="mb-5 flex shrink-0 flex-col gap-4 border-b pb-5 sm:flex-row sm:items-center sm:justify-between">
            <div className="min-w-0 space-y-2">
              <div className="flex min-w-0 flex-wrap items-center gap-2">
                <h1 className="max-w-full truncate text-2xl font-semibold">{room.name}</h1>
                <Button
                  variant="outline"
                  onClick={handleCopyCode}
                  className="font-mono text-[0.625rem] font-medium"
                  aria-label={t("copyCode")}
                >
                  {roomId}
                  <HugeiconsIcon icon={CopyIcon} className="size-3" />
                </Button>
              </div>
              <div className="flex flex-wrap items-center gap-2 text-xs text-muted-foreground">
                <span className="flex items-center gap-1.5">
                  <span className="relative h-2.5 w-3.5 shrink-0 overflow-hidden">
                    <Image
                      src={`/flags/${room.lang}.svg`}
                      fill
                      sizes="14px"
                      alt=""
                      className="object-cover"
                    />
                  </span>
                  {categoryNames.join(", ")}
                </span>
              </div>
            </div>

            <Button variant="destructive" size="lg" onClick={handleLeave} className="self-start">
              {t("leave")}
            </Button>
          </header>

          <div className="grid gap-4 lg:min-h-0 lg:flex-1 lg:grid-cols-3">
            <div className="space-y-4 lg:col-span-2 lg:flex lg:min-h-0 lg:flex-col lg:space-y-0 lg:gap-4">
              <RoomGame
                game={game}
                users={room.users}
                currentUsername={currentUser?.username}
                connectionReady={isConnected}
                onReadyChange={sendReady}
                onAnswer={sendAnswer}
              />
              <RoomChat messages={messages} isConnected={isConnected} />
            </div>
            <RoomUsers
              users={room.users}
              creator={room.creator}
              scoreboard={game.scoreboard}
              showScores={
                game.phase === "question" || game.phase === "result" || game.phase === "finished"
              }
            />
          </div>
        </main>
      )}
    </ProtectedRoute>
  );
}
