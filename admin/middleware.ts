import { match } from "@formatjs/intl-localematcher";
import Negotiator from "negotiator";
import { cookies } from "next/headers";
import { NextRequest } from "next/server";
import { fallbackLng, locales } from "./i18n/settings";
function getLocale(request: NextRequest) {
  if (cookies().get("locale")) {
    request.headers.set(
      "accept-language",
      cookies().get("locale")?.value ?? "ar",
    );
  }
  let languages = new Negotiator({
    headers: Object.fromEntries(request.headers),
  }).languages();

  return match(languages, locales, fallbackLng); // -> 'en-US'
}

export function middleware(request: NextRequest) {
  // Check if there is any supported locale in the pathname
  const { pathname } = request.nextUrl;
  const pathnameHasLocale = locales.some(
    (locale) => pathname.startsWith(`/${locale}/`) || pathname === `/${locale}`,
  );

  if (pathnameHasLocale) return;

  // Redirect if there is no locale
  const locale = getLocale(request);

  request.nextUrl.pathname = `/${locale}${pathname}`;

  return Response.redirect(request.nextUrl);
}

export const config = {
  matcher: "/((?!api|static|.*\\..*|_next).*)",
};
