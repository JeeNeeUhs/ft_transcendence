"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { CheckmarkCircle02Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { useTranslations } from "next-intl";
import { useEffect, useMemo, useRef, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import { Field, FieldDescription, FieldError } from "@/components/ui/field";
import { Input } from "@/components/ui/input";

export function AddFriendForm() {
  const tUsers = useTranslations("users");
  const [sentTo, setSentTo] = useState<string | null>(null);

  // the confirmation clears itself, so the timer has to be cleared on unmount
  const sentTimerRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    return () => {
      if (sentTimerRef.current !== null) clearTimeout(sentTimerRef.current);
    };
  }, []);

  const formSchema = useMemo(
    () =>
      z.object({
        username: z
          .string()
          .trim()
          .nonempty(tUsers("add.usernameRequired"))
          .min(3, tUsers("add.usernameMinValue"))
          .max(50, tUsers("add.usernameMaxValue"))
      }),
    [tUsers]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),

    defaultValues: {
      username: ""
    }
  });

  // TODO: there is no friendship endpoint yet, so this only confirms locally
  function onSubmit(data: z.infer<typeof formSchema>) {
    setSentTo(data.username);
    form.reset();

    if (sentTimerRef.current !== null) clearTimeout(sentTimerRef.current);
    sentTimerRef.current = setTimeout(() => {
      setSentTo(null);
      sentTimerRef.current = null;
    }, 5000);
  }

  return (
    <form
      onSubmit={form.handleSubmit(onSubmit)}
      className="w-full space-y-2 rounded-lg bg-card px-3 py-2.5 ring-1 ring-foreground/10"
    >
      <Controller
        name="username"
        control={form.control}
        render={({ field, fieldState }) => (
          <Field data-invalid={fieldState.invalid}>
            <div className="flex items-center gap-2">
              <Input
                {...field}
                aria-label={tUsers("add.title")}
                aria-invalid={fieldState.invalid}
                placeholder={tUsers("add.placeholder")}
                autoComplete="off"
                className="flex-1"
              />
              <Button type="submit">{tUsers("add.button")}</Button>
            </div>
            {fieldState.invalid ? (
              <FieldError errors={[fieldState.error]} />
            ) : sentTo ? (
              <FieldDescription className="flex items-center gap-1.5 text-foreground">
                <HugeiconsIcon icon={CheckmarkCircle02Icon} size={14} className="shrink-0" />
                {tUsers("add.sent", { username: sentTo })}
              </FieldDescription>
            ) : (
              <FieldDescription>{tUsers("add.hint")}</FieldDescription>
            )}
          </Field>
        )}
      />
    </form>
  );
}
