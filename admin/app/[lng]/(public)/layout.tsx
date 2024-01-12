import { LayoutProps } from "@/app/type";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export default function Layout({ children }: LayoutProps) {
  const user = cookies().get("user")?.value;
  if (user) redirect("/");

  return children;
}
