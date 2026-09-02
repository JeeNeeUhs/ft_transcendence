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
import type { IntraResponse } from "@/lib/api/auth";
import { authService } from "@/lib/api/auth";

interface IntraSetupFormProps {
  response: IntraResponse;
  onSuccess: (accessToken: string) => void;
}

export function IntraSetupForm({ response, onSuccess }: IntraSetupFormProps) {
  const tAuth = useTranslations("auth");
  const tError = useTranslations("error");
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const formSchema = useMemo(
    () =>
      z.object({
        username: z
          .string()
          .trim()
          .nonempty(tAuth("signUp.usernameRequired"))
          .min(3, tAuth("signUp.usernameMinValue"))
          .max(50, tAuth("signUp.usernameMaxValue"))
      }),
    [tAuth]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      username: ""
    }
  });

  async function onSubmit(data: z.infer<typeof formSchema>) {
    setIsLoading(true);

    const response_ = await authService.intraComplete(response.accessToken, data.username);
    if (!response_.success) {
      if (response_.status === 409) {
        form.setError("username", {
          message: tAuth("signUp.usernameShouldUnique")
        });
      } else {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: tError(`codes.${response_.errorCode}`)
        });
      }

      setIsLoading(false);
      return;
    }

    onSuccess(response_.data.accessToken);
  }

  return (
    <>
      <form id="intra-setup-form" onSubmit={form.handleSubmit(onSubmit)}>
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
                <FieldDescription>{tAuth("signUp.uniqueUsername")}</FieldDescription>
                {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
              </Field>
            )}
          />
        </FieldGroup>
      </form>
      <Button
        type="submit"
        disabled={isLoading}
        form="intra-setup-form"
        className="flex items-center gap-x-2"
      >
        {isLoading && <Spinner />}
        {tAuth("oauth.complete")}
      </Button>
    </>
  );
}
