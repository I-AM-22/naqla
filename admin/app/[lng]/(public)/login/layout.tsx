import { LayoutProps } from "@/app/type";
import { AuthLayout } from "@/components/layouts/auth-layout";
import { getTranslation } from "@/i18n/server";

export default async function Layout({
  params: { lng },
  children,
}: LayoutProps) {
  const { t } = await getTranslation(lng, "login");
  return (
    <AuthLayout heading={t("heading")} subheading={t("subheading")}>
      {children}
    </AuthLayout>
  );
}
