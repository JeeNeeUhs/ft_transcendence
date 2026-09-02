"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useTranslations } from "next-intl";
import { useMemo, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle
} from "@/components/ui/dialog";
import { Field, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { roomService } from "@/lib/api/room";
import { useRoomStore } from "@/stores/socket";

interface JoinRoomDialogProps {
  roomId: string;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export function JoinRoomDialog({ roomId, open, onOpenChange }: JoinRoomDialogProps) {
  const tDialog = useTranslations("rooms.join");
  const tError = useTranslations("error");

  const [isLoading, setIsLoading] = useState<boolean>(false);

  const setWs = useRoomStore((state) => state.setWs);

  const formSchema = useMemo(
    () =>
      z.object({
        password: z.string().min(1, tDialog("passwordRequired"))
      }),
    [tDialog]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      password: ""
    }
  });

  async function onSubmit(data: z.infer<typeof formSchema>) {
    setIsLoading(true);

    try {
      const { ws, room: joinedRoom } = await roomService.join(roomId, data.password);
      setWs(ws, joinedRoom);
      onOpenChange(false);
    } catch {
      toast.add({
        type: "error",
        title: tError("genericTitle"),
        description: tDialog("failed")
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{tDialog("title")}</DialogTitle>
          <DialogDescription>{tDialog("description")}</DialogDescription>
        </DialogHeader>
        <form id={`join-room-form-${roomId}`} onSubmit={form.handleSubmit(onSubmit)}>
          <FieldGroup>
            <Controller
              name="password"
              control={form.control}
              render={({ field, fieldState }) => (
                <Field data-invalid={fieldState.invalid}>
                  <FieldLabel htmlFor={`join-room-form-password-${roomId}`}>
                    {tDialog("password")}
                  </FieldLabel>
                  <Input
                    {...field}
                    id={`join-room-form-password-${roomId}`}
                    type="password"
                    aria-invalid={fieldState.invalid}
                    placeholder={tDialog("passwordPlaceholder")}
                    autoComplete="off"
                  />
                  {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
                </Field>
              )}
            />
          </FieldGroup>
        </form>
        <DialogFooter>
          <Button
            type="submit"
            disabled={isLoading}
            form={`join-room-form-${roomId}`}
            className="w-full"
          >
            {isLoading && <Spinner />}
            {tDialog("action")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
