import { LayoutProps } from "@/app/type";
import { BreadcrumbLinks } from "@/components/ui/breadcrumb";
import { getTranslation } from "@/i18n/server";

export default async function Layout(props: LayoutProps<{ id: string }>) {
  const { t } = await getTranslation(props.params.lng, "drivers");

  return (
    <>
      <BreadcrumbLinks
        prependNavigation
        breadcrumbs={[
          {
            href: `/drivers/${props.params.id}/ratings`,
            label: t("ratings"),
          },
        ]}
      />
      {props.children}
    </>
  );
}
