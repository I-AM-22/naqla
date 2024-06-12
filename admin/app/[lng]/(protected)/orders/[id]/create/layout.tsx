import { LayoutProps } from "@/app/type";
import { BreadcrumbLinks } from "@/components/ui/breadcrumb";
import { getTranslation } from "@/i18n/server";

export default async function Layout(props: LayoutProps<{ id: string }>) {
  const { t } = await getTranslation(props.params.lng, "orders");
  const id = props.params.id;
  return (
    <>
      <BreadcrumbLinks
        prependNavigation
        breadcrumbs={[{ href: `/orders/${id}/new`, label: t("splitOrder") }]}
      />
      {props.children}
    </>
  );
}
