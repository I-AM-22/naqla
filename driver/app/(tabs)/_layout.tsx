import useUserStore from "@/stores/userStore";
import { Redirect, Tabs } from "expo-router";
import "intl-pluralrules";
import "lib/i18next";
import * as React from "react";
import { useTheme } from "react-native-paper";
import Icon from "react-native-vector-icons/Feather";

export default function Layout() {
  const { isAuthed, user } = useUserStore();
  const theme = useTheme();
  console.log("(tabs) layout");

  if (!isAuthed) {
    return <Redirect href={"/auth"} />;
  }

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: theme.colors.primary,
        tabBarLabelStyle: { fontFamily: "Cairo" },
        headerTitleStyle: { fontFamily: "Cairo" },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: `الرئيسية`,
          tabBarIcon: (props) => <Icon size={28} name="home" />,
        }}
      />
      <Tabs.Screen
        name="settings"
        options={{
          title: "الإعدادات",
          tabBarIcon: (props) => <Icon size={28} name="settings" />,
        }}
      />
    </Tabs>
  );
}
