import { sm } from "@/utils/ui";
import { useTranslation } from "react-i18next";
import { Text as RNText, TextProps as RNTextProps } from "react-native-paper";

const WebText = (props: RNTextProps<unknown>) => {
  const { i18n } = useTranslation();
  return (
    <RNText
      //@ts-expect-error workaround
      lang={"ar"}
      {...props}
      style={sm(
        {
          textAlign: "auto",
          direction: i18n.dir(i18n.language),
        },
        props.style
      )}
    />
  );
};

export default WebText;
