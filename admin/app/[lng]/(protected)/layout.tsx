import { LayoutProps } from "@/app/type";
import { NavigationBar } from "@/components/layouts/navigation-bar";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export default function Layout({ children }: LayoutProps) {
  const user = cookies().get("user")?.value;
  if (!user) redirect("/login");

  return (
    <div className="flex">
      <NavigationBar />
      {children}
    </div>
  );
}
