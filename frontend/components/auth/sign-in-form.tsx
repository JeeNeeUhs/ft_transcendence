"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import { Field, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { authService } from "@/lib/api/auth";

const formSchema = z.object({
  username: z.string().trim().nonempty("auth.signIn.usernameRequired"),
  password: z.string().nonempty("auth.signIn.passwordRequired")
});

export function SignInForm({ onSuccess }: { onSuccess: (accessToken: string) => void }) {
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),

    // set default values to prevent uncontrolled input warning
    // do not remove these default values
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
          message: "auth.signIn.invalidUsernameOrPassword"
        });
        form.setError("password", {
          message: "auth.signIn.invalidUsernameOrPassword"
        });
      } else {
        toast.add({
          type: "error",
          title: "error.genericTitle",
          description: `error.code-${response.errorCode}`
        });
      }

      setIsLoading(false);
      return;
    }

    // setIsLoading(false);
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
                <FieldLabel htmlFor="sign-in-form-username">auth.username</FieldLabel>
                <Input
                  {...field}
                  id="sign-in-form-username"
                  aria-invalid={fieldState.invalid}
                  placeholder="auth.enterUsername"
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
                <FieldLabel htmlFor="sign-in-form-password">auth.password</FieldLabel>
                <Input
                  {...field}
                  id="sign-in-form-password"
                  type="password"
                  aria-invalid={fieldState.invalid}
                  placeholder="auth.enterPassword"
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
        auth.signIn
      </Button>
    </>
  );
}
