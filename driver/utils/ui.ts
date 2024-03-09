import { StyleProp } from "react-native";

/**  Style Merge */
export function sm<T>(...arr: StyleProp<T>[]): StyleProp<T> {
  return arr.reduce((obj, style) => ({ ...obj, ...(style as object) }), {}) as StyleProp<T>;
}
