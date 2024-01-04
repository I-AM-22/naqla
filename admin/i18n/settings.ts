export const fallbackLng = "ar";
export const locales = [fallbackLng, "en"];
export const cookieName = "i18next";
export const defaultNS = "common";
export function getOptions(lng = fallbackLng, ns = defaultNS) {
  return {
    // debug: true,
    supportedLngs: locales,
    fallbackLng,
    lng,
    fallbackNS: ns,
    defaultNS,
    ns,
  };
}
