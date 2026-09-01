"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { Add01Icon } from "@hugeicons/core-free-icons";
import { HugeiconsIcon } from "@hugeicons/react";
import { useRouter } from "next/navigation";
import { useTranslations } from "next-intl";
import { useMemo, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger
} from "@/components/ui/dialog";
import {
  Field,
  FieldError,
  FieldGroup,
  FieldLabel,
  FieldLegend,
  FieldSet
} from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { Spinner } from "@/components/ui/spinner";
import { toast } from "@/components/ui/toast";
import { type Category, roomService } from "@/lib/api/room";
import { useRoomStore } from "@/stores/socket";

export function CreateRoomDialog({
  categories,
  locale
}: {
  categories: Category[];
  locale: string;
}) {
  const tDialog = useTranslations("rooms.create");
  const tError = useTranslations("error");

  const [isLoading, setIsLoading] = useState<boolean>(false);

  const router = useRouter();
  const setWs = useRoomStore((state) => state.setWs);

  const formSchema = useMemo(
    () =>
      z.object({
        name: z
          .string()
          .trim()
          .min(1, tDialog("roomNameRequired"))
          .max(30, tDialog("roomNameTooLong")),
        password: z
          .string()
          .optional()
          .refine((val) => !val || (val.length >= 4 && val.length <= 16), {
            message: tDialog("passwordInvalidLen")
          }),
        categories: z.number().array().min(1, tDialog("categoriesRequired"))
      }),
    [tDialog]
  );

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),

    defaultValues: {
      name: "",
      password: "",
      categories: []
    }
  });

  async function onSubmit(data: z.infer<typeof formSchema>) {
    setIsLoading(true);

    try {
      const { ws, room } = await roomService.create(
        data.name,
        data.password,
        data.categories,
        locale
      );
      setWs(ws, room);
      form.reset();
      router.push(`/rooms/${room.id}`);
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
    <Dialog>
      <DialogTrigger
        render={
          <Button size="lg">
            <HugeiconsIcon icon={Add01Icon} />
            {tDialog("action")}
          </Button>
        }
      />
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{tDialog("title")}</DialogTitle>
          <DialogDescription>{tDialog("description")}</DialogDescription>
        </DialogHeader>
        <form id="create-room-form" onSubmit={form.handleSubmit(onSubmit)}>
          <FieldGroup>
            <Controller
              name="name"
              control={form.control}
              render={({ field, fieldState }) => (
                <Field data-invalid={fieldState.invalid}>
                  <FieldLabel htmlFor="create-room-form-name">{tDialog("roomName")}</FieldLabel>
                  <Input
                    {...field}
                    id="create-room-form-name"
                    aria-invalid={fieldState.invalid}
                    placeholder={tDialog("roomNamePlaceholder")}
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
                  <FieldLabel htmlFor="create-room-form-password">{tDialog("password")}</FieldLabel>
                  <Input
                    {...field}
                    id="create-room-form-password"
                    type="password"
                    aria-invalid={fieldState.invalid}
                    placeholder={tDialog("passwordPlaceholder")}
                    autoComplete="off"
                  />
                  {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
                </Field>
              )}
            />
            <Controller
              name="categories"
              control={form.control}
              render={({ field, fieldState }) => (
                <FieldSet>
                  <FieldLegend variant="label">{tDialog("categories")}</FieldLegend>
                  <FieldGroup data-slot="checkbox-group" className="flex flex-row flex-wrap">
                    {categories.map((category) => (
                      <Field
                        key={category.id}
                        orientation="horizontal"
                        data-invalid={fieldState.invalid}
                        className="w-fit"
                      >
                        <Checkbox
                          id={`create-room-form-checkbox-${category.id}`}
                          name={field.name}
                          aria-invalid={fieldState.invalid}
                          checked={field.value.includes(category.id)}
                          onCheckedChange={(checked) => {
                            const newValue = checked
                              ? [...field.value, category.id]
                              : field.value.filter((value) => value !== category.id);
                            field.onChange(newValue);
                          }}
                        />
                        <FieldLabel
                          htmlFor={`create-room-form-checkbox-${category.id}`}
                          className="font-normal"
                        >
                          {category.name}
                        </FieldLabel>
                      </Field>
                    ))}
                  </FieldGroup>
                  {fieldState.invalid && <FieldError errors={[fieldState.error]} />}
                </FieldSet>
              )}
            />
          </FieldGroup>
        </form>
        <DialogFooter>
          <Button type="submit" disabled={isLoading} form="create-room-form" className="w-full">
            {isLoading && <Spinner />}
            {tDialog("action")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
