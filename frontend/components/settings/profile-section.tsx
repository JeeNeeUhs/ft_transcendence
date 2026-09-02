"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useLocale, useTranslations } from "next-intl";
import { useMemo, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { SectionHeader } from "@/components/section-header";
import { AvatarField } from "@/components/settings/avatar-field";
import { Button } from "@/components/ui/button";
import {
  Field,
  FieldDescription,
  FieldError,
  FieldGroup,
  FieldLabel,
  FieldTitle
} from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { Textarea } from "@/components/ui/textarea";
import { toast } from "@/components/ui/toast";
import { userService } from "@/lib/api/user";
import { useUserStore } from "@/providers/user";

const maxDescriptionLength = 100;

export function ProfileSection() {
  const tSettings = useTranslations("settings");
  const tError = useTranslations("error");
  const locale = useLocale();

  const user = useUserStore((state) => state.user);
  const setUser = useUserStore((state) => state.setUser);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const formSchema = useMemo(
    () =>
      z.object({
        description: z
          .string()
          .trim()
          .max(maxDescriptionLength, tSettings("profile.descriptionMaxValue"))
      }),
    [tSettings]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),

    defaultValues: {
      description: user?.description ?? ""
    }
  });

  const description = form.watch("description");

  async function onSubmit(data: z.infer<typeof formSchema>) {
    if (!user) return;

    setIsLoading(true);

    const response = await userService.updateDescription(data.description);
    if (!response.success) {
      if (response.errorCode === 47) {
        form.setError("description", {
          message: tSettings("profile.descriptionMaxValue")
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

    setUser({ ...user, description: response.data.description });
    form.reset({ description: response.data.description });
    setIsLoading(false);

    toast.add({
      type: "success",
      title: tSettings("profile.saved")
    });
  }

  if (!user) return null;

  const memberSince = new Intl.DateTimeFormat(locale, { dateStyle: "long" }).format(
    new Date(user.createdAt)
  );

  return (
    <div className="space-y-5">
      <SectionHeader
        title={tSettings("profile.title")}
        description={tSettings("profile.description")}
      />

      <FieldGroup>
        <AvatarField />

        <Field>
          <FieldLabel htmlFor="settings-username">{tSettings("profile.username")}</FieldLabel>
          <Input id="settings-username" value={user.username} readOnly disabled />
          <FieldDescription>{tSettings("profile.usernameHint")}</FieldDescription>
        </Field>

        <Field>
          <FieldTitle>{tSettings("profile.accountInfo")}</FieldTitle>
          <p className="text-muted-foreground text-xs">
            {tSettings("profile.memberSince", { date: memberSince })}
          </p>
          <p className="text-muted-foreground text-xs">
            {user.isIntra ? tSettings("profile.intraAccount") : tSettings("profile.localAccount")}
          </p>
        </Field>
      </FieldGroup>

      <form id="settings-profile-form" onSubmit={form.handleSubmit(onSubmit)}>
        <FieldGroup>
          <Controller
            name="description"
            control={form.control}
            render={({ field, fieldState }) => (
              <Field data-invalid={fieldState.invalid}>
                <FieldLabel htmlFor="settings-profile-form-description">
                  {tSettings("profile.bio")}
                </FieldLabel>
                <Textarea
                  {...field}
                  id="settings-profile-form-description"
                  aria-invalid={fieldState.invalid}
                  placeholder={tSettings("profile.bioPlaceholder")}
                  maxLength={maxDescriptionLength}
                />
                <FieldDescription>
                  {tSettings("profile.bioHint", {
                    count: description.length,
                    max: maxDescriptionLength
                  })}
                </FieldDescription>
                {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
              </Field>
            )}
          />
        </FieldGroup>
      </form>

      <Button
        type="submit"
        form="settings-profile-form"
        disabled={isLoading || !form.formState.isDirty}
        className="flex items-center gap-x-2"
      >
        {isLoading && <Spinner />}
        {tSettings("profile.save")}
      </Button>
    </div>
  );
}
