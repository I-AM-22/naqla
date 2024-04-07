import useUserStore from "@/stores/user-store";
import { Redirect, Tabs } from "expo-router";
import "intl-pluralrules";
import "lib/i18next";
import * as React from "react";
import { useTranslation } from "react-i18next";
import { StyleSheet } from "react-native";
import { useTheme } from "react-native-paper";
import Icon from "react-native-vector-icons/Feather";
import MIcon from "react-native-vector-icons/MaterialCommunityIcons";
const styles = StyleSheet.create({
  base: {},
  focused: {},
  normal: {},
});
export default function Layout() {
  const { isAuthed, user } = useUserStore();
  const { t } = useTranslation("layout");
  const theme = useTheme();

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
          tabBarActiveTintColor: theme.colors.secondary,
          tabBarInactiveTintColor: theme.colors.primary,
          tabBarIcon: ({ color }) => <Icon color={color} size={28} name="home" />,
        }}
      />
      <Tabs.Screen
        name="cars"
        options={{
          title: t("navLink.cars"),
          tabBarActiveTintColor: theme.colors.secondary,
          tabBarInactiveTintColor: theme.colors.primary,
          tabBarIcon: ({ color }) => <MIcon color={color} size={28} name="truck-cargo-container" />,
        }}
      />
      <Tabs.Screen
        name="settings"
        options={{
          title: t("navLink.settings"),
          tabBarActiveTintColor: theme.colors.secondary,
          tabBarInactiveTintColor: theme.colors.primary,
          tabBarIcon: ({ color }) => <Icon size={28} color={color} name="settings" />,
        }}
      />
    </Tabs>
  );
}
