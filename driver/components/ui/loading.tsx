import { theme } from "@/providers/theme-provider";
import { FC } from "react";
import { ActivityIndicator, ActivityIndicatorProps } from "react-native";
export type LoadingProps = ActivityIndicatorProps;
export const Loading: FC<LoadingProps> = (props) => {
  return <ActivityIndicator color={theme.colors?.primary} {...props} />;
};
