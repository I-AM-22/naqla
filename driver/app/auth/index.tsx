import Welcome from "@/assets/welcome.svg";
import { Text } from "@/components/ui/text";
import { Image } from "expo-image";
import { Link, Stack } from "expo-router";
import { useTranslation } from "react-i18next";
import { View } from "react-native";
import { Button, useTheme } from "react-native-paper";
export default function Page() {
  const { t } = useTranslation("auth", { keyPrefix: "welcome" });
  const theme = useTheme();

  return (
    <View style={{ marginVertical: 10, flex: 1, display: "flex", gap: 8, flexDirection: "column" }}>
      <Stack.Screen
        options={{
          headerShown: false,
          contentStyle: { backgroundColor: theme.colors?.background },
        }}
      />
      <Text variant="headlineMedium" style={{ textAlign: "center", marginTop: 20 }}>
        {t("title")}
      </Text>
      <Text style={{ textAlign: "center", fontSize: 15 }}>{t("subtitle")}</Text>
      <Image
        source={Welcome}
        contentFit="contain"
        style={{
          height: 200,
          width: "100%",
        }}
      />
      <View
        style={{
          display: "flex",
          flexDirection: "column",
          gap: 8,
          marginHorizontal: 20,
          marginTop: "auto",
          marginBottom: 50,
        }}
      >
        <Link asChild href={{ pathname: "/auth/signup" }}>
          <Button mode="contained">{t("signup")}</Button>
        </Link>
        <Link href="/auth/login" asChild>
          <Button mode="outlined">{t("login")}</Button>
        </Link>
      </View>
    </View>
  );
}
