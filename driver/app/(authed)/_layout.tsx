import { theme } from "@/providers/theme-provider";
import useUserStore from "@/stores/user-store";
import { Redirect, Stack } from "expo-router";
import "intl-pluralrules";
export default function Layout() {
  const { isAuthed } = useUserStore();
  if (!isAuthed) {
    return <Redirect href={"/auth"} />;
  }
  return <Stack screenOptions={{ contentStyle: { backgroundColor: theme.colors?.background } }} />;
}
