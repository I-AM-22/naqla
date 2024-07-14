import { AuthAdminResponse } from "@/service/api.schemas";
import { getCookie } from "@/utils/cookies";
import { useCookies } from "react-cookie";
export type AdminUser = Pick<AuthAdminResponse, "token"> & {
  admin: AuthAdminResponse["admin"] & { role: "admin" | "superadmin" };
};
export function useUser() {
  const [{ user }] = useCookies(["user"]);
  return user as AdminUser | undefined;
}

export function getUser() {
  const userCookie = getCookie("user");
  const user = userCookie ? (JSON.parse(userCookie) as AdminUser) : undefined;
  return user;
}
