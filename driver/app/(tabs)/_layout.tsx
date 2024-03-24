import useUserStore from "@/stores/userStore";
import { Redirect, Tabs } from "expo-router";
import "intl-pluralrules";
import "lib/i18next";
import * as React from "react";
import { useTranslation } from "react-i18next";
import { useTheme } from "react-native-paper";
import Icon from "react-native-vector-icons/Feather";
import MIcon from "react-native-vector-icons/MaterialCommunityIcons";

export default function Layout() {
  const { isAuthed, user } = useUserStore();
  const { t } = useTranslation("layout");
  const theme = useTheme();
  console.log("(tabs) layout");

  if (!isAuthed) {
    return <Redirect href={"/auth"} />;
  }

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: theme.colors.primary,
        tabBarStyle: { paddingBottom: 2, paddingTop: 2 },
        tabBarLabelStyle: { fontFamily: "Cairo" },
        headerTitleStyle: { fontFamily: "Cairo" },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: t("navLink.home"),
          tabBarIcon: () => <Icon size={28} name="home" />,
        }}
      />
      <Tabs.Screen
        name="cars/index"
        options={{
          title: t("navLink.cars"),
          tabBarIcon: () => <MIcon size={28} name="truck-cargo-container" />,
        }}
      />
      <Tabs.Screen
        name="settings"
        options={{
          title: t("navLink.settings"),
          tabBarIcon: () => <Icon size={28} name="settings" />,
        }}
      />
    </Tabs>
  );
}
