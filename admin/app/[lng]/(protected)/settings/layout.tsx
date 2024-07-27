import { LayoutProps } from "@/app/type";
import { BreadcrumbLinks } from "@/components/ui/breadcrumb";

export default async function Layout(props: LayoutProps) {
  return (
    <>
      <BreadcrumbLinks prependNavigation />
      {props.children}
    </>
  );
}
