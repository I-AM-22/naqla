import { Providers } from "@/components/providers";
import { ZodI18nInit } from "@/components/providers/zod-i18n";
import { Toaster } from "@/components/ui/sonner";
import { cn } from "@/lib/utils";
import { zodI18nInitServer } from "@/lib/zod";
import { dir } from "i18next";
import type { Metadata } from "next";
import localFont from "next/font/local";
import "../globals.css";
import { LayoutProps } from "../type";

const rubik = localFont({ src: "../../public/Rubik-VariableFont_wght.ttf" });
export const metadata: Metadata = {
  title: "نقلة | لوحة التحكم",
};
export default function RootLayout({ children, params: { lng } }: LayoutProps) {
  zodI18nInitServer(lng);

  return (
    <html
      lang={lng}
      dir={dir(lng)}
      className="flex min-h-screen flex-col"
      suppressHydrationWarning
    >
      <body
        className={cn(
          "flex flex-1 flex-col",
          dir(lng) === "ltr" ? "[&_*]:dir-ltr" : "[&_*]:dir-rtl",
          rubik.className,
        )}
      >
        <Providers>
          {children}
          <ZodI18nInit />
          <Toaster />
        </Providers>
      </body>
    </html>
  );
}
