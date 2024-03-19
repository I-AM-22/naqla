import { getUser } from "@/actions/auth";
import { LayoutProps } from "@/app/type";
import { NavigationBar } from "@/components/layouts/navigation-bar";
import { redirect } from "next/navigation";

export default async function Layout({ children }: LayoutProps) {
  const user = await getUser();
  if (!user) redirect("/login");

  return (
    <div className="flex">
      <NavigationBar />
      {children}
    </div>
  );
}
