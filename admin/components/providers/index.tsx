"use client";
import { ThemeProvider } from "next-themes";
import { FC, ReactNode } from "react";
export type ProvidersProps = { children: ReactNode };
export const Providers: FC<ProvidersProps> = ({ children }) => {
  return (
    <ThemeProvider themes={["light", "dark"]} attribute="class">
      {children}
    </ThemeProvider>
  );
};
