import { LayoutProps } from "@/app/type";
import { BreadcrumbLinks } from "@/components/ui/breadcrumb";
import { getTranslation } from "@/i18n/server";

export default async function Layout(props: LayoutProps) {
  const { t } = await getTranslation(props.params.lng);

  return (
    <>
      <BreadcrumbLinks
        prependNavigation
        breadcrumbs={[{ href: "/car-advantages/new", label: t("add") }]}
      />

      {props.children}
    </>
  );
}
