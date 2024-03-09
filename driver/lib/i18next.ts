import i18n from "i18next";
import ar from "localization/ar";
import en from "localization/en";
import { initReactI18next } from "react-i18next";
const resources = {
  ar,
  en,
};
declare module "i18next" {
  interface CustomTypeOptions {
    returnNull: false;
  }
}
export const availableLanguages = Object.keys(resources);
i18n
  .use(initReactI18next)
  // .use(I18nextBrowserLanguageDetector)
  .init({
    resources,
    fallbackLng: "ar",
    defaultNS: "common",
    returnNull: false,
    debug: false,
    react: { useSuspense: false },
  });
i18n.on("languageChanged", (language) => {
  if (i18n.language !== language) i18n.changeLanguage(language);
});

export const changeLanguage = (lang: string) => {
  i18n.changeLanguage(lang);
};
export default i18n;
