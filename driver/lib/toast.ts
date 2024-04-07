import { ToastAndroid } from "react-native";

export function toast(message: string, duration = ToastAndroid.SHORT) {
  ToastAndroid.show(message, duration);
}
