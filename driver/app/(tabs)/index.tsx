import useUserStore from "@/stores/user-store";
import { Tabs } from "expo-router";
import { View } from "react-native";

export default function Page() {
  const { user } = useUserStore();

  return (
    <View style={{ display: "flex", flexDirection: "column", alignItems: "center" }}>
      <Tabs.Screen
        options={{
          headerTitle: `أهلا ${user?.firstName} ${user?.lastName}`,
        }}
      />
    </View>
  );
}
