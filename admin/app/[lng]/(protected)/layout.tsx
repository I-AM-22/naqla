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
      <div id="less-than-xl-portal" className="block xl:hidden"></div>
      <NavigationBar user={user} />

      <Providers>
        <div className="mx-6 flex w-full flex-col p-4 xl:mx-0">{children}</div>
      </Providers>
    </div>
  );
}
