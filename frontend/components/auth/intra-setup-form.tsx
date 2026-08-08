"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import { Field, FieldDescription, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import type { IntraResponse } from "@/lib/api/auth";
import { authService } from "@/lib/api/auth";

const formSchema = z.object({
  username: z
    .string()
    .trim()
    .nonempty("auth.signUp.usernameRequired")
    .min(3, "auth.signUp.usernameMinValue")
    .max(50, "auth.signUp.usernameMaxValue")
});

interface IntraSetupFormProps {
  response: IntraResponse;
  onSuccess: (accessToken: string) => void;
}

export function IntraSetupForm({ response, onSuccess }: IntraSetupFormProps) {
  const [isLoading, setIsLoading] = useState<boolean>(false);

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
          message: "auth.signUp.usernameShouldUnique"
        });
      } else {
        toast.add({
          type: "error",
          title: "error.genericTitle",
          description: `error.code-${response_.errorCode}`
        });
      }

      setIsLoading(false);
      return;
    }

    // setIsLoading(false);
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
                <FieldLabel htmlFor="sign-in-form-username">auth.username</FieldLabel>
                <Input
                  {...field}
                  id="sign-in-form-username"
                  aria-invalid={fieldState.invalid}
                  placeholder="auth.enterUsername"
                  autoComplete="off"
                />
                <FieldDescription>auth.signUp.uniqueUsername</FieldDescription>
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
        auth.oauth.complete
      </Button>
    </>
  );
}
