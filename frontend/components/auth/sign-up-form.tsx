"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useTranslations } from "next-intl";
import { useMemo, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import { Field, FieldDescription, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { authService } from "@/lib/api/auth";

export function SignUpForm({ onSuccess }: { onSuccess: (accessToken: string) => void }) {
  const t = useTranslations("auth");
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const formSchema = useMemo(
    () =>
      z
        .object({
          username: z
            .string()
            .trim()
            .nonempty(t("signUp.usernameRequired"))
            .min(3, t("signUp.usernameMinValue"))
            .max(50, t("signUp.usernameMaxValue")),
          password: z
            .string()
            .nonempty(t("signUp.passwordRequired"))
            .min(8, t("signUp.passwordMinValue"))
            .max(50, t("signUp.passwordMaxValue")),
          confirmPassword: z.string().nonempty(t("signUp.confirmPassword"))
        })
        .refine((data) => data.password === data.confirmPassword, {
          path: ["confirmPassword"],
          message: t("signUp.passwordDontMatch")
        }),
    [t]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),

    defaultValues: {
      username: "",
      password: "",
      confirmPassword: ""
    }
  });

  async function onSubmit(data: z.infer<typeof formSchema>) {
    setIsLoading(true);

    const response = await authService.signUp(data.username, data.password);
    if (!response.success) {
      if (response.status === 409) {
        form.setError("username", {
          message: t("signUp.usernameShouldUnique")
        });
      } else {
        toast.add({
          type: "error",
          title: t("error.genericTitle"),
          description: `error.code-${response.errorCode}`
        });
      }

      setIsLoading(false);
      return;
    }

    onSuccess(response.data.accessToken);
  }

  return (
    <>
      <form id="sign-up-form" onSubmit={form.handleSubmit(onSubmit)}>
        <FieldGroup>
          <Controller
            name="username"
            control={form.control}
            render={({ field, fieldState }) => (
              <Field data-invalid={fieldState.invalid}>
                <FieldLabel htmlFor="sign-up-form-username">{t("username")}</FieldLabel>
                <Input
                  {...field}
                  id="sign-up-form-username"
                  aria-invalid={fieldState.invalid}
                  placeholder={t("enterUsername")}
                  autoComplete="off"
                />
                <FieldDescription>{t("signUp.uniqueUsername")}</FieldDescription>
                {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
              </Field>
            )}
          />
          <div className="flex flex-col gap-y-2">
            <Controller
              name="password"
              control={form.control}
              render={({ field, fieldState }) => (
                <Field data-invalid={fieldState.invalid}>
                  <FieldLabel htmlFor="sign-up-form-password">{t("password")}</FieldLabel>
                  <Input
                    {...field}
                    id="sign-up-form-password"
                    type="password"
                    aria-invalid={fieldState.invalid}
                    placeholder={t("enterPassword")}
                    autoComplete="off"
                  />
                  {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
                </Field>
              )}
            />
            <Controller
              name="confirmPassword"
              control={form.control}
              render={({ field, fieldState }) => (
                <Field data-invalid={fieldState.invalid}>
                  <Input
                    {...field}
                    id="sign-up-form-confirm-password"
                    type="password"
                    aria-invalid={fieldState.invalid}
                    placeholder={t("confirmPassword")}
                    autoComplete="off"
                  />
                  <FieldDescription>{t("signUp.createPasswordMinMax")}</FieldDescription>
                  {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
                </Field>
              )}
            />
          </div>
        </FieldGroup>
      </form>
      <Button
        type="submit"
        disabled={isLoading}
        form="sign-up-form"
        className="flex items-center gap-x-2"
      >
        {isLoading && <Spinner />}
        {t("signUp.button")}
      </Button>
    </>
  );
}
