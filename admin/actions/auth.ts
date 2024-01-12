"use server";

import { cookies } from "next/headers";

export async function loginUser(token: string) {
  // token for now
  cookies().set("user", token);
}

export async function logoutUser() {
  cookies().delete("user");
}
