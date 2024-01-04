"use client";
import { PageProps } from "@/app/type";
import { setLocaleCookie } from "@/components/layouts/navigation-bar/actions";
import { Button } from "@/components/ui/button";
import { Divider } from "@/components/ui/divider";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { useTranslation } from "@/i18n/client";
import { locales } from "@/i18n/settings";
import { cn } from "@/lib/utils";
import { Home, Menu, User } from "lucide-react";
import { useTheme } from "next-themes";
import Link from "next/link";
import { useParams, usePathname } from "next/navigation";
import { FC, Fragment, useState } from "react";
import { NavigationButton } from "./navigation-button";
import { Route } from "./type";

const routes: Route[][] = [
  [
    { link: "/", icon: <Home />, label: "home", key: "home1" },
    { link: "/", icon: <Home />, label: "home", key: "home2" },
    { link: "/", icon: <Home />, label: "home", key: "home3" },
    { link: "/", icon: <Home />, label: "home", key: "home4" },
  ],
  [
    { link: "/", icon: <Home />, label: "home", key: "home5" },
    { link: "/", icon: <Home />, label: "home", key: "home6" },
    { link: "/", icon: <Home />, label: "home", key: "home7" },
    { link: "/", icon: <Home />, label: "home", key: "home8" },
  ],
  [
    { link: "/", icon: <Home />, label: "home", key: "home9" },
    { link: "/", icon: <Home />, label: "home", key: "home10" },
    { link: "/", icon: <Home />, label: "home", key: "home11" },
  ],
  [{ link: "/", icon: <Home />, label: "home", key: "home12" }],
];

export type NavigationBarProps = {};
export const NavigationBar: FC<NavigationBarProps> = ({}) => {
  const [open, setOpen] = useState(false);
  const activeRoute = usePathname().split("/")[0];
  const { t } = useTranslation("layout");
  const { setTheme, themes, theme } = useTheme();
  const { lng } = useParams<PageProps["params"]>();
  const pathname = usePathname();
  const pathnameWithoutLocale = pathname.split("/")[2] ?? "";

  return (
    <aside className="sticky bottom-0 start-0 top-0 flex h-screen max-h-screen w-fit flex-col overflow-y-auto border-e-2 border-e-border">
      <div className="sticky top-0 me-auto ms-1 bg-background">
        <Button
          size={"icon"}
          onClick={() => setOpen((prev) => !prev)}
          className={cn(
            "transition-all duration-200",
            "flex w-full rounded p-1 [&_svg]:h-7 [&_svg]:w-7 [&_svg]:text-primary", // Layout
            "bg-background shadow-none hover:bg-accent hover:shadow-sm", // Light mode
          )}
        >
          <Menu />
        </Button>
      </div>
      <div className="flex flex-1 flex-col p-1 transition-all">
        {routes.map((section, index) => (
          <Fragment key={index}>
            {section.map((route) => (
              <NavigationButton
                tooltip={!open}
                key={route.key}
                route={route}
                isActive={activeRoute === route.key}
              />
            ))}
            {index !== routes.length - 1 && <Divider />}
          </Fragment>
        ))}
        <Divider />
        <Divider className="mt-auto" />
        <DropdownMenu>
          <DropdownMenuTrigger>
            <NavigationButton
              tooltip={!open}
              route={{
                icon: <User />,
                key: "preferences",
                label: t("preferences"),
              }}
            />
          </DropdownMenuTrigger>
          <DropdownMenuContent sideOffset={7} className="mb-2" side="right">
            <DropdownMenuLabel>{t("theme.theme")}</DropdownMenuLabel>
            <DropdownMenuRadioGroup
              value={theme}
              onValueChange={(value) => {
                setTheme(value);
              }}
            >
              {themes.map((theme) => (
                <DropdownMenuRadioItem key={theme} value={theme}>
                  {t(`theme.${theme}`)}
                </DropdownMenuRadioItem>
              ))}
            </DropdownMenuRadioGroup>
            <DropdownMenuSeparator />
            <DropdownMenuLabel>{t("languages.language")}</DropdownMenuLabel>
            <DropdownMenuRadioGroup value={lng}>
              {locales.map((locale) => (
                <Link
                  key={locale}
                  onClick={() => setLocaleCookie(locale)}
                  href={`/${locale}/${pathnameWithoutLocale}`}
                >
                  <DropdownMenuRadioItem value={locale}>
                    {t(`languages.${locale}`)}
                  </DropdownMenuRadioItem>
                </Link>
              ))}
            </DropdownMenuRadioGroup>
            <DropdownMenuSeparator />
            <DropdownMenuItem>{t("logout")}</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </aside>
  );
};
