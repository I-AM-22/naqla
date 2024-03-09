import { sm } from "@/utils/ui";
import { Text as RNText, TextProps as RNTextProps } from "react-native-paper";

const MobileText = (props: RNTextProps<unknown>) => {
  return <RNText style={sm({ textAlign: "left" }, props.style)} {...props} />;
};
export default MobileText;
