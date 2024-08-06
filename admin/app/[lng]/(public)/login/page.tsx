"use client";
import { loginUser } from "@/actions/auth";
import { Form } from "@/components/ui/form";
import { FormInput } from "@/components/ui/form-input";
import PasswordFormInput from "@/components/ui/password-form-input";
import Submit from "@/components/ui/submit";
import { phoneRegex } from "@/constants/regex";
import { useMutation } from "@/hooks/use-mutation";
import { AdminUser } from "@/hooks/use-user";
import { useTranslation } from "@/i18n/client";
import { z } from "@/lib/zod";
import { adminsControllerLogin } from "@/service/api";
import { withT } from "@/utils/i18n";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
const formSchema = withT((t) =>
  z.object({
    phone: z.string().regex(phoneRegex, t("validation:phoneNumber")).min(1),
    password: z.string().min(8),
  }),
);
type FormSchema = z.infer<ReturnType<typeof formSchema>>;
export default function Page() {
  const { t } = useTranslation("login");
  const { t: validationT } = useTranslation("validation");
  const form = useForm<FormSchema>({
    resolver: zodResolver(formSchema(validationT)),
    defaultValues: {
      phone: "",
      password: "",
    },
  });
  const login = useMutation(adminsControllerLogin, form);
  const onSubmit = async (data: FormSchema) => {
    const response = await login.mutate(data);
    if (response) loginUser(response.data as AdminUser);
  };
  return (
    <Form {...form}>
      <form
        className="flex flex-col gap-6"
        onSubmit={form.handleSubmit(onSubmit)}
      >
        <FormInput label={t("phone")} name="phone" />
        <PasswordFormInput label={t("password")} name="password" />
        <Submit className="mx-auto mt-8">{t("submit")}</Submit>
      </form>
    </Form>
  );
}
