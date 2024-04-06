import i18n from "@/lib/i18next";

export const PriceFormatter = (language = i18n.language, currency = "SYP") => {
  const intl = new Intl.NumberFormat(language, {
    style: "currency",
    currency,
  });
  return (value: number) => intl.format(value);
};
