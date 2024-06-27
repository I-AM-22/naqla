import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
const locale: Record<string, string> = {
  ar: "ar-ae",
  en: "en-GB",
};
export const priceFormatter = (
  price: number,
  language: string,
  withSymbol = true,
  currency = "SYP",
) =>
  new Intl.NumberFormat(locale[language], {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
    currencyDisplay: "symbol",
    ...(withSymbol && { style: "currency", currency }),
  }).format(price);
