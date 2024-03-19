import { getTranslation } from "@/i18n/server";
import { z } from "zod";
import { makeZodI18nMap } from "zod-i18n-map";

export async function zodI18nInitServer(language: string) {
  const { t } = await getTranslation(language);
  z.setErrorMap(makeZodI18nMap({ t }));
}
export * as z from "zod";
