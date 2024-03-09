import ThemeProvider, { theme } from "@/providers/theme-provider";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useFonts } from "expo-font";
import { ErrorBoundaryProps, SplashScreen, Stack } from "expo-router";
import * as Updates from "expo-updates";
import "intl-pluralrules";
import "lib/i18next";
import * as React from "react";
import { useTranslation } from "react-i18next";
import { I18nManager, Platform, Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

const queryClient = new QueryClient();
export default function Layout() {
  const { i18n } = useTranslation();
  const [fontsLoaded, fontError] = useFonts({
    Cairo: require("assets/Cairo.ttf"),
  });

  const onLayoutRootView = React.useCallback(async () => {
    if (fontsLoaded || fontError) {
      await SplashScreen.hideAsync();
    }
  }, [fontsLoaded, fontError]);

  if (!fontsLoaded && !fontError) {
    return <Text>{""}</Text>;
  }

  const shouldBeRTL = i18n.dir(i18n.language) === "rtl";
  if (shouldBeRTL !== I18nManager.isRTL && Platform.OS !== "web") {
    I18nManager.allowRTL(shouldBeRTL);
    I18nManager.forceRTL(shouldBeRTL);
    Updates.reloadAsync();
  }
  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider>
        <SafeAreaView style={{ flex: 1 }} onLayout={onLayoutRootView}>
          <Stack screenOptions={{ contentStyle: { backgroundColor: theme.colors?.background } }}>
            <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
          </Stack>
        </SafeAreaView>
      </ThemeProvider>
    </QueryClientProvider>
  );
}
export function ErrorBoundary(props: ErrorBoundaryProps) {
  return (
    <View style={{ flex: 1, backgroundColor: "red" }}>
      <Text>{props.error.message}</Text>
      <Text onPress={props.retry}>Try Again?</Text>
    </View>
  );
}
