import useUserStore from "@/stores/user-store";
import { View } from "react-native";
import { Button, useTheme } from "react-native-paper";

export default function Tab() {
  const user = useUserStore();
  const theme = useTheme();
  return (
    <View style={{ padding: 20, display: "flex", flexDirection: "column" }}>
      <Button
        mode="outlined"
        style={{ backgroundColor: theme.colors.background }}
        labelStyle={{ marginRight: "auto" }}
        onPress={user.clear}
      >
        تسجيل خروج
      </Button>
    </View>
  );
}
