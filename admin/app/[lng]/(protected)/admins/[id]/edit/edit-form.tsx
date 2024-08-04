"use client";

import { revalidatePath } from "@/actions/cache";
import { Card } from "@/components/ui/card";
import { Form } from "@/components/ui/form";
import { FormInput } from "@/components/ui/form-input";
import PasswordFormInput from "@/components/ui/password-form-input";
import Submit from "@/components/ui/submit";
import { phoneRegex } from "@/constants/regex";
import { useMutation } from "@/hooks/use-mutation";
import { z } from "@/lib/zod";
import { adminsControllerUpdate } from "@/service/api";
import { Admin, UpdateAdminDto } from "@/service/api.schemas";
import { withT } from "@/utils/i18n";
import { getDirtyValues } from "@/utils/react-form-hook";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";

const schema = withT((t) =>
  z
    .object({
      firstName: z.string().min(1),
      lastName: z.string().min(1),
      phone: z.string().regex(phoneRegex, t("phoneNotValid")).min(1),
      password: z.string().min(8),
      passwordConfirm: z.string().min(8),
    })
    .refine(({ password, passwordConfirm }) => password === passwordConfirm, {
      message: t("passwordDoNotMatch"),
      path: ["passwordConfirm"],
    }),
);
type Schema = z.infer<ReturnType<typeof schema>>;
export type EditFormProps = { admin: Admin };
export function EditForm({ admin }: EditFormProps) {
  const { t } = useTranslation("admins");
  const form = useForm<Schema>({
    resolver: zodResolver(schema(t)),
    defaultValues: admin,
  });
  const router = useRouter();
  const update = useMutation(
    (dto: UpdateAdminDto) => adminsControllerUpdate({ id: admin.id }, dto),
    form,
  );
  const onSubmit = async (data: Schema) => {
    const { passwordConfirm, ...toSend } = getDirtyValues(
      form.formState.dirtyFields,
      data,
    );

    await update.mutate(
      //@ts-ignore
      { ...toSend },
      {
        onSuccess: () => {
          revalidatePath(`/admins/${admin.id}/edit`);
          revalidatePath("/admins");
          router.push("/admins");
        },
      },
    );
  };
  return (
    <Card className="mx-auto mt-5 p-4">
      <Form {...form}>
        <form
          className="flex flex-col gap-3 "
          onSubmit={form.handleSubmit(onSubmit)}
        >
          <h3 className="text-xl">{t("editAdmin")}</h3>
          <div className="flex w-96 max-w-full flex-col">
            <FormInput label={t("firstName")} name="firstName" />
            <FormInput label={t("lastName")} name="lastName" />
            <FormInput label={t("phone")} name="phone" />
            <PasswordFormInput label={t("password")} name="password" />
            <PasswordFormInput
              label={t("passwordConfirm")}
              name="passwordConfirm"
            />
            <Submit className="mt-3" />
          </div>
        </form>
      </Form>
    </Card>
  );
}
