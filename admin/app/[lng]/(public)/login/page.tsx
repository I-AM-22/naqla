"use client";
import { loginUser } from "@/actions/auth";
import { Form } from "@/components/ui/form";
import { FormInput } from "@/components/ui/form-input";
import LoadingButton from "@/components/ui/loading-button";
import PasswordFormInput from "@/components/ui/password-form-input";
import { useTranslation } from "@/i18n/client";
import { zodResolver } from "@hookform/resolvers/zod";
import Link from "next/link";
import { useForm } from "react-hook-form";
import * as z from "zod";
const formSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});
export default function Page() {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      email: "",
      password: "",
    },
  });
  const { t } = useTranslation("login");
  const onSubmit = async () => {
    loginUser("token");
  };
  return (
    <Form {...form}>
      <form
        className="flex flex-col gap-6"
        onSubmit={form.handleSubmit(onSubmit)}
      >
        <FormInput label={t("email")} name="email" />
        <div className="relative">
          <Link
            href="/forgot-password"
            className="absolute end-0 top-2 z-[2] mr-1 text-xs text-secondary-foreground"
          >
            {t("forgotPassword")}
          </Link>
          <PasswordFormInput label={t("password")} name="password" />
        </div>
        <LoadingButton isLoading={false} className="mx-auto mt-8">
          {t("submit")}
        </LoadingButton>
        <p className="mt-auto text-center text-secondary-foreground">
          {t("noAccount")}{" "}
          <Link href={"/sign-up"} className="underline">
            {t("signup")}
          </Link>
        </p>
      </form>
    </Form>
  );
}
