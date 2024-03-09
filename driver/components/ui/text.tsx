import { Platform } from "react-native";
import MobileText from "./mobile-text";
import WebText from "./web-text";

export const Text = Platform.OS === "web" ? WebText : MobileText;
