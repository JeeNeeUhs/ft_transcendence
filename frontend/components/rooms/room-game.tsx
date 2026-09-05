"use client";

import { useTranslations } from "next-intl";

import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import type {
  AnswerOption,
  QuestionResult,
  QuizQuestion,
  RoomUser,
  ScoreEntry
} from "@/lib/api/room";
import { cn } from "@/lib/utils";

export type GamePhase = "lobby" | "countdown" | "question" | "result" | "finished";

export interface RoomGameState {
  phase: GamePhase;
  countdown: number | null;
  question: QuizQuestion | null;
  questionIndex: number;
  questionTotal: number;
  timeLeft: number;
  duration: number;
  answeredCount: number;
  selectedOption: AnswerOption | null;
  correctOption: AnswerOption | null;
  results: QuestionResult[];
  scoreboard: ScoreEntry[];
}

interface RoomGameProps {
  game: RoomGameState;
  users: RoomUser[];
  currentUsername?: string;
  connectionReady: boolean;
  onReadyChange: (ready: boolean) => void;
  onAnswer: (option: AnswerOption) => void;
}

const optionKeys: AnswerOption[] = ["A", "B", "C", "D"];

export function RoomGame({
  game,
  users,
  currentUsername,
  connectionReady,
  onReadyChange,
  onAnswer
}: RoomGameProps) {
  const t = useTranslations("rooms.detail");
  const {
    phase,
    countdown,
    question,
    questionIndex,
    questionTotal,
    timeLeft,
    duration,
    answeredCount,
    selectedOption,
    correctOption,
    results,
    scoreboard
  } = game;
  const me = users.find((user) => user.username === currentUsername);
  const readyCount = users.filter((user) => user.ready).length;
  const ownResult = results.find((result) => result.username === currentUsername);
  const winner = scoreboard[0];
  const ownScore = scoreboard.find((entry) => entry.username === currentUsername);

  if (phase === "finished") {
    return (
      <Card className="min-h-80 justify-center">
        <CardContent className="flex flex-col items-center px-6 py-8 text-center sm:px-10">
          <h2 className="text-pretty text-2xl font-semibold">
            {winner ? t("game.winner", { user: winner.username }) : t("game.finishedTitle")}
          </h2>
          {winner && (
            <p className="mt-1 text-sm text-muted-foreground">
              {t("game.winnerScore", { score: winner.score })}
            </p>
          )}

          {ownScore && (
            <div className="mt-6 grid w-full max-w-sm grid-cols-2 divide-x rounded-lg border bg-background/80 py-3">
              <div>
                <p className="text-xs text-muted-foreground">{t("game.yourRank")}</p>
                <p className="mt-1 font-mono text-lg font-semibold">#{ownScore.rank}</p>
              </div>
              <div>
                <p className="text-xs text-muted-foreground">{t("game.yourScore")}</p>
                <p className="mt-1 font-mono text-lg font-semibold">{ownScore.score}</p>
              </div>
            </div>
          )}

          <p className="mt-5 max-w-md text-sm text-muted-foreground">
            {t("game.finishedDescription")}
          </p>
          <Button
            size="lg"
            className="mt-5 w-full max-w-sm"
            disabled={!connectionReady}
            onClick={() => onReadyChange(true)}
          >
            {t("game.playAgain")}
          </Button>
        </CardContent>
      </Card>
    );
  }

  if (phase === "lobby") {
    const enoughPlayers = users.length >= 2;
    return (
      <Card className="min-h-64 justify-center">
        <CardContent className="flex flex-col items-center px-6 py-8 text-center sm:px-10">
          <h2 className="text-xl font-semibold">
            {me?.ready ? t("lobby.readyTitle") : t("lobby.title")}
          </h2>
          <p className="mt-2 max-w-md text-sm text-muted-foreground">
            {!enoughPlayers
              ? t("lobby.waitingForPlayers")
              : me?.ready
                ? t("lobby.waitingForOthers")
                : t("lobby.description")}
          </p>

          <div className="mt-6 w-full max-w-sm space-y-2">
            <div className="flex justify-between text-xs text-muted-foreground">
              <span>{t("lobby.readyPlayers")}</span>
              <span className="font-medium tabular-nums text-foreground">
                {readyCount}/{users.length}
              </span>
            </div>
            <div className="h-2 overflow-hidden rounded-full bg-muted">
              <div
                className="h-full rounded-full bg-primary"
                style={{ width: `${users.length ? (readyCount / users.length) * 100 : 0}%` }}
              />
            </div>
          </div>

          <Button
            size="lg"
            variant={me?.ready ? "outline" : "default"}
            className="mt-6 min-w-40"
            disabled={!connectionReady}
            onClick={() => onReadyChange(!me?.ready)}
          >
            {me?.ready ? t("lobby.cancelReady") : t("lobby.readyAction")}
          </Button>
        </CardContent>
      </Card>
    );
  }

  if (phase === "countdown") {
    return (
      <Card className="min-h-96 justify-center">
        <CardContent className="flex flex-col items-center py-12 text-center">
          <p className="text-sm font-medium text-muted-foreground">{t("game.getReady")}</p>
          <div className="my-5 flex size-28 items-center justify-center rounded-full border text-5xl font-bold tabular-nums">
            {countdown}
          </div>
          <p className="text-sm text-muted-foreground">{t("game.starting")}</p>
        </CardContent>
      </Card>
    );
  }

  if (!question) return null;

  const optionText: Record<AnswerOption, string> = {
    A: question.optionA,
    B: question.optionB,
    C: question.optionC,
    D: question.optionD
  };
  const isResult = phase === "result";
  const canSelectOption = !isResult && selectedOption === null && connectionReady && timeLeft > 0;
  const progress = duration > 0 ? Math.max(0, Math.min(100, (timeLeft / duration) * 100)) : 0;

  return (
    <Card>
      <CardHeader className="border-b">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <Badge variant="secondary">
            {t("game.question", { current: questionIndex + 1, total: questionTotal })}
          </Badge>
          <span
            className={cn(
              "flex items-center gap-1.5 font-mono text-sm font-semibold tabular-nums",
              timeLeft <= 5 && !isResult && "text-destructive"
            )}
          >
            {isResult ? "—" : `${Math.ceil(timeLeft)}s`}
          </span>
        </div>
        <div className="mt-2 h-1.5 overflow-hidden rounded-full bg-muted">
          <div
            className={cn(
              "h-full rounded-full bg-primary",
              timeLeft <= 5 && !isResult && "bg-destructive"
            )}
            style={{ width: `${isResult ? 0 : progress}%` }}
          />
        </div>
      </CardHeader>
      <CardContent className="space-y-6 py-2">
        <h2 className="text-pretty text-lg font-semibold leading-relaxed sm:text-xl">
          {question.questionText}
        </h2>

        <div className="grid gap-2 sm:grid-cols-2">
          {optionKeys.map((option) => {
            const isSelected = selectedOption === option;
            const isCorrect = isResult && correctOption === option;
            const isWrongSelection = isResult && isSelected && !isCorrect;

            return (
              <button
                key={option}
                type="button"
                disabled={!canSelectOption}
                onClick={() => onAnswer(option)}
                className={cn(
                  "flex min-h-18 items-center gap-3 rounded-lg border bg-background p-3 text-left text-sm",
                  "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring/40",
                  "disabled:cursor-default disabled:opacity-100",
                  canSelectOption && "hover:border-foreground/30 hover:bg-muted/50",
                  isSelected && !isResult && "border-primary bg-primary/5 ring-1 ring-primary/20",
                  isCorrect && "border-emerald-500/60 bg-emerald-500/10",
                  isWrongSelection && "border-destructive/60 bg-destructive/10"
                )}
              >
                <span
                  className={cn(
                    "flex size-8 shrink-0 items-center justify-center rounded-md border bg-muted font-mono font-semibold",
                    isSelected && !isResult && "border-primary bg-primary text-primary-foreground",
                    isCorrect && "border-emerald-500 bg-emerald-500 text-white",
                    isWrongSelection && "border-destructive bg-destructive text-white"
                  )}
                >
                  {option}
                </span>
                <span className="leading-relaxed">{optionText[option]}</span>
              </button>
            );
          })}
        </div>

        <div className="flex min-h-6 items-center justify-between gap-3 text-xs text-muted-foreground">
          <span>
            {isResult
              ? ownResult?.correct
                ? t("game.correct", { points: ownResult.points })
                : ownResult?.option
                  ? t("game.incorrect")
                  : t("game.noAnswer")
              : selectedOption
                ? t("game.answerLocked")
                : timeLeft <= 0
                  ? t("game.waitingResult")
                  : t("game.chooseAnswer")}
          </span>
          <span className="shrink-0 tabular-nums">
            {t("game.answered", { answered: answeredCount, total: users.length })}
          </span>
        </div>
      </CardContent>
    </Card>
  );
}
