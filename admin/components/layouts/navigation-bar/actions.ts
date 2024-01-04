"use server";

import { cookies } from "next/headers";

export async function setLocaleCookie(locale: string) {
  if (cookies().get("locale")?.value !== locale) {
    cookies().set("locale", locale);
  }
}
