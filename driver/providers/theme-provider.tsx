import { ReactNode } from "react";
import { MD3LightTheme as DefaultTheme, PaperProvider, configureFonts } from "react-native-paper";
import { ThemeProp } from "react-native-paper/lib/typescript/types";
export const theme: ThemeProp = {
  ...DefaultTheme,
  fonts: configureFonts({ config: { fontFamily: "Cairo" } }),
  colors: {
    ...DefaultTheme.colors,
    primary: "#2c2c2c",
    onPrimary: "#fff",
    primaryContainer: "#2c2c2c",
    onPrimaryContainer: "#fff",
    secondary: "#B7083C",
    inversePrimary: "#fff",
    background: "#fff",
    elevation: { ...DefaultTheme.colors.elevation, level1: "#fff", level2: "#fff" },
  },
  roundness: 2,
};
export interface ThemeProviderProps {
  children: ReactNode;
}
export default function ThemeProvider({ children }: ThemeProviderProps) {
  return <PaperProvider theme={theme}>{children}</PaperProvider>;
}
