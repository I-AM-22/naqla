import { getUser } from "@/actions/auth";
import { LayoutProps } from "@/app/type";
import { redirect } from "next/navigation";

export default async function Layout({ children }: LayoutProps) {
  const user = await getUser();
  if (user) redirect("/");

  return <>{children}</>;
}
