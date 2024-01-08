import { cookies } from "next/headers";
import { useCookies } from "react-cookie";

export function useUser() {
  const [{ user }] = useCookies(["user"]);
  return user as string;
}

export function getUser() {
  return cookies().get("user")?.value;
}
