import { AuthAdminResponse } from "@/service/api.schemas";
import { getCookie } from "@/utils/cookies";
import { useCookies } from "react-cookie";

export function useUser() {
  const [{ user }] = useCookies(["user"]);
  console.log(user);

  return user as AuthAdminResponse | undefined;
}

export function getUser() {
  const userCookie = getCookie("user");
  const user = userCookie
    ? (JSON.parse(userCookie) as AuthAdminResponse)
    : undefined;
  return user;
}
