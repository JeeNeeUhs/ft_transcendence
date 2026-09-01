"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useTranslations } from "next-intl";
import { useMemo, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import { Field, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { authService } from "@/lib/api/auth";

export function SignInForm({ onSuccess }: { onSuccess: (accessToken: string) => void }) {
  const tAuth = useTranslations("auth");
  const tError = useTranslations("auth");
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const formSchema = useMemo(
    () =>
      z.object({
        username: z.string().trim().nonempty(tAuth("signIn.usernameRequired")),
        password: z.string().nonempty(tAuth("signIn.passwordRequired"))
      }),
    [tAuth]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),

    defaultValues: {
      username: "",
      password: ""
    }
  });

  async function onSubmit(data: z.infer<typeof formSchema>) {
    setIsLoading(true);

    const response = await authService.signIn(data.username, data.password);
    if (!response.success) {
      if (response.status === 401) {
        form.setError("username", {
          message: tAuth("signIn.invalidUsernameOrPassword")
        });
        form.setError("password", {
          message: tAuth("signIn.invalidUsernameOrPassword")
        });
      } else {
        toast.add({
          type: "error",
          title: tAuth("error.genericTitle"),
          description: tError(`codes.${response.errorCode}`)
        });
      }

      setIsLoading(false);
      return;
    }

    onSuccess(response.data.accessToken);
  }

  return (
    <>
      <form id="sign-in-form" onSubmit={form.handleSubmit(onSubmit)}>
        <FieldGroup>
          <Controller
            name="username"
            control={form.control}
            render={({ field, fieldState }) => (
              <Field data-invalid={fieldState.invalid}>
                <FieldLabel htmlFor="sign-in-form-username">{tAuth("username")}</FieldLabel>
                <Input
                  {...field}
                  id="sign-in-form-username"
                  aria-invalid={fieldState.invalid}
                  placeholder={tAuth("enterUsername")}
                  autoComplete="off"
                />
                {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
              </Field>
            )}
          />
          <Controller
            name="password"
            control={form.control}
            render={({ field, fieldState }) => (
              <Field data-invalid={fieldState.invalid}>
                <FieldLabel htmlFor="sign-in-form-password">{tAuth("password")}</FieldLabel>
                <Input
                  {...field}
                  id="sign-in-form-password"
                  type="password"
                  aria-invalid={fieldState.invalid}
                  placeholder={tAuth("enterPassword")}
                  autoComplete="off"
                />
                {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
              </Field>
            )}
          />
        </FieldGroup>
      </form>
      <Button
        type="submit"
        disabled={isLoading}
        form="sign-in-form"
        className="flex items-center gap-x-2"
      >
        {isLoading && <Spinner />}
        {tAuth("signIn.button")}
      </Button>
    </>
  );
}
