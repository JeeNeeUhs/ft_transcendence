"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { InformationCircleIcon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { useTranslations } from "next-intl";
import { useMemo, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { SectionHeader } from "@/components/settings/section-header";
import { Button } from "@/components/ui/button";
import { Field, FieldDescription, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { userService } from "@/lib/api/user";
import { useUserStore } from "@/providers/user";

function IntraNotice({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex items-start gap-2 rounded-md bg-muted px-3 py-2.5 text-xs/relaxed text-muted-foreground">
      <HugeiconsIcon icon={InformationCircleIcon} size={16} className="mt-px shrink-0" />
      <p>{children}</p>
    </div>
  );
}

export function PasswordSection() {
  const tSettings = useTranslations("settings");
  const tError = useTranslations("error");

  const user = useUserStore((state) => state.user);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const formSchema = useMemo(
    () =>
      z
        .object({
          currentPassword: z.string().nonempty(tSettings("password.currentRequired")),
          newPassword: z
            .string()
            .min(8, tSettings("password.minValue"))
            .max(50, tSettings("password.maxValue")),
          confirmPassword: z.string().nonempty(tSettings("password.confirmRequired"))
        })
        .refine((data) => data.newPassword === data.confirmPassword, {
          path: ["confirmPassword"],
          message: tSettings("password.dontMatch")
        })
        .refine((data) => data.newPassword !== data.currentPassword, {
          path: ["newPassword"],
          message: tSettings("password.sameAsCurrent")
        }),
    [tSettings]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),

    defaultValues: {
      currentPassword: "",
      newPassword: "",
      confirmPassword: ""
    }
  });

  async function onSubmit(data: z.infer<typeof formSchema>) {
    setIsLoading(true);

    const response = await userService.updatePassword(data.currentPassword, data.newPassword);
    if (!response.success) {
      if (response.errorCode === 48) {
        form.setError("currentPassword", {
          message: tSettings("password.invalidCurrent")
        });
      } else if (response.errorCode === 7) {
        form.setError("newPassword", {
          message: tSettings("password.minValue")
        });
      } else {
        toast.add({
          type: "error",
          title: tError("genericTitle"),
          description: tError(`codes.${response.errorCode}`)
        });
      }

      setIsLoading(false);
      return;
    }

    // the backend invalidates every issued token, so the fresh one must replace it
    localStorage.setItem("access_token", response.data.accessToken);

    form.reset();
    setIsLoading(false);

    toast.add({
      type: "success",
      title: tSettings("password.saved"),
      description: tSettings("password.savedDescription")
    });
  }

  if (!user) return null;

  return (
    <div className="space-y-5">
      <SectionHeader
        title={tSettings("password.title")}
        description={tSettings("password.description")}
      />

      {user.isIntra ? (
        <IntraNotice>{tSettings("password.intraNotice")}</IntraNotice>
      ) : (
        <>
          <form id="settings-password-form" onSubmit={form.handleSubmit(onSubmit)}>
            <FieldGroup>
              <Controller
                name="currentPassword"
                control={form.control}
                render={({ field, fieldState }) => (
                  <Field data-invalid={fieldState.invalid}>
                    <FieldLabel htmlFor="settings-password-form-current">
                      {tSettings("password.currentPassword")}
                    </FieldLabel>
                    <Input
                      {...field}
                      id="settings-password-form-current"
                      type="password"
                      aria-invalid={fieldState.invalid}
                      placeholder={tSettings("password.enterCurrent")}
                      autoComplete="current-password"
                    />
                    {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
                  </Field>
                )}
              />
              <div className="flex flex-col gap-y-2">
                <Controller
                  name="newPassword"
                  control={form.control}
                  render={({ field, fieldState }) => (
                    <Field data-invalid={fieldState.invalid}>
                      <FieldLabel htmlFor="settings-password-form-new">
                        {tSettings("password.newPassword")}
                      </FieldLabel>
                      <Input
                        {...field}
                        id="settings-password-form-new"
                        type="password"
                        aria-invalid={fieldState.invalid}
                        placeholder={tSettings("password.enterNew")}
                        autoComplete="new-password"
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
                        id="settings-password-form-confirm"
                        type="password"
                        aria-invalid={fieldState.invalid}
                        placeholder={tSettings("password.enterConfirm")}
                        autoComplete="new-password"
                      />
                      <FieldDescription>{tSettings("password.hint")}</FieldDescription>
                      {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
                    </Field>
                  )}
                />
              </div>
            </FieldGroup>
          </form>

          <Button
            type="submit"
            form="settings-password-form"
            disabled={isLoading}
            className="flex items-center gap-x-2"
          >
            {isLoading && <Spinner />}
            {tSettings("password.save")}
          </Button>
        </>
      )}
    </div>
  );
}
