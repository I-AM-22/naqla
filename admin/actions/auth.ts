"use server";

import { AdminUser } from "@/hooks/use-user";
import { cookies } from "next/headers";

export async function loginUser(user: AdminUser) {
  // token for now
  cookies().set("user", JSON.stringify(user));
}
export async function getUser() {
  const userCookie = cookies().get("user")?.value;
  const user = userCookie ? (JSON.parse(userCookie) as AdminUser) : undefined;
  return user;
}
export async function logoutUser() {
  cookies().delete("user");
}
