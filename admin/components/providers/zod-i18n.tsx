"use client";
import { useTranslation } from "@/i18n/client";
import { FC, ReactNode } from "react";
import { z } from "zod";
import { makeZodI18nMap } from "zod-i18n-map";
export type ZodI18nProviderProps = { children?: ReactNode };
export const ZodI18nInit: FC<ZodI18nProviderProps> = ({ children }) => {
  const { t } = useTranslation("zod");
  z.setErrorMap(makeZodI18nMap({ t }));
  return children;
};
