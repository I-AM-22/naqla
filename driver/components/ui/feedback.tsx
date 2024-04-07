import { FC, ReactNode } from "react";
import { useTranslation } from "react-i18next";
import { StyleSheet, View, ViewProps } from "react-native";
import Icon from "react-native-vector-icons/Feather";
import { Text } from "./text";
const styles = StyleSheet.create({
  view: { display: "flex", alignItems: "center", padding: 10, paddingTop: 30 },
  text: {},
});
export type NoDataProps = ViewProps & { message?: ReactNode };
export const NoData: FC<NoDataProps> = ({ message, ...props }) => {
  const { t } = useTranslation();
  return (
    <View {...props} style={[styles.view, props.style]}>
      <Icon name="inbox" size={110} />
      <Text style={styles.text} variant="titleLarge">
        {message ?? `${t("error.noData")}...`}
      </Text>
    </View>
  );
};
