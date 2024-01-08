"use client";
import { ThemeProvider } from "next-themes";
import { FC, ReactNode } from "react";
import { ZodI18nProvider } from "./zod-i18n";
export type ProvidersProps = { children: ReactNode };
export const Providers: FC<ProvidersProps> = ({ children }) => {
  return (
    <ThemeProvider themes={["light", "dark"]} attribute="class">
      <ZodI18nProvider>{children}</ZodI18nProvider>
    </ThemeProvider>
  );
};
