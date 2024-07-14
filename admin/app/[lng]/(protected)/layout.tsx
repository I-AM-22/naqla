import { getUser } from "@/actions/auth";
import { LayoutProps } from "@/app/type";
import { NavigationBar } from "@/components/layouts/navigation-bar";
import { redirect } from "next/navigation";
import { Providers } from "../providers";
export default async function Layout({ children }: LayoutProps) {
  const user = await getUser();
  if (!user) redirect("/login");

  return (
    <div className="flex">
      <NavigationBar user={user} />

      <Providers>
        <div className="flex w-full flex-col p-4">{children}</div>
      </Providers>
    </div>
  );
}
