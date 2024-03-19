"use server";

import { AuthAdminResponse } from "@/service/api.schemas";
import { cookies } from "next/headers";

export async function loginUser(user: AuthAdminResponse) {
  // token for now
  cookies().set("user", JSON.stringify(user));
}
export async function getUser() {
  const userCookie = cookies().get("user")?.value;
  const user = userCookie
    ? (JSON.parse(userCookie) as AuthAdminResponse)
    : undefined;
  return user;
}
export async function logoutUser() {
  cookies().delete("user");
}
