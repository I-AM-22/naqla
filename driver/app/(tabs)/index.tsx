import useUserStore from "@/stores/userStore";
import { Tabs } from "expo-router";
import { View } from "react-native";
import Icon from "react-native-vector-icons/Feather";

export default function Page() {
  const { user } = useUserStore();

  return (
    <View style={{ display: "flex", flexDirection: "column", alignItems: "center" }}>
      <Tabs.Screen
        options={{
          headerTitle: `أهلا ${user?.firstName} ${user?.lastName}`,

          tabBarIcon: (props) => <Icon size={28} name="home" />,
        }}
      />
    </View>
  );
}
