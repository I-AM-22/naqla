"use client";
import { logoutUser } from "@/actions/auth";
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
import {
  Sheet,
  SheetContent,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";
import { AdminUser } from "@/hooks/use-user";
import { useTranslation } from "@/i18n/client";
import { locales } from "@/i18n/settings";
import { cn } from "@/lib/utils";
import {
  CarFront,
  Home,
  Inbox,
  Menu,
  Settings,
  Truck,
  User,
  UserCog,
  Users,
} from "lucide-react";
import { useTheme } from "next-themes";
import Link from "next/link";
import { useParams, usePathname, useRouter } from "next/navigation";
import { FC, Fragment, useEffect, useState } from "react";
import { NavigationButton } from "./navigation-button";
import { Route } from "./type";

const routes: Route[][] = [
  [
    {
      href: "/",
      icon: <Home />,
      label: "home",
      key: "",
    },
  ],

  [
    {
      href: "/orders",
      icon: <Inbox />,
      label: "orders",
      key: "orders",
    },
    {
      href: "/car-advantages",
      icon: <CarFront />,
      label: "car-advantages",
      key: "car-advantages",
    },
  ],
  [
    {
      href: "/customers",
      icon: <Users />,
      label: "customers",
      key: "customers",
    },
    {
      href: "/drivers",
      icon: <Truck />,
      label: "drivers",
      key: "drivers",
    },
    {
      href: "/admins",
      icon: <UserCog />,
      label: "admins",
      key: "admins",
      roles: ["superadmin"],
    },
    {
      href: "/settings",
      icon: <Settings />,
      label: "settings",
      key: "settings",
      roles: ["superadmin"],
    },
  ],
];
export type NavigationBarProps = { user: AdminUser };
export const NavigationBar: FC<NavigationBarProps> = ({ user }) => {
  const [isOpen, setIsOpen] = useState(false);
  const [portal, setPortal] = useState<Element | null>(null);
  const [isPortalShowing, setIsPortalShowing] = useState(false);
  const [hasReadFromLocalStorage, setHasReadFromLocalStorage] = useState(false);
  const activeRoute = usePathname().split("/")[2] ?? "";
  const { t, i18n } = useTranslation("layout");
  const { setTheme, themes, theme } = useTheme();
  const { lng } = useParams<PageProps["params"]>();
  const router = useRouter();

  const pathname = usePathname();
  const pathnameWithoutLocale = pathname.split("/")[2] ?? "";
  const handleLogout = async () => {
    await logoutUser();
    router.push("/");
    setIsOpen(false);
  };
  useEffect(() => {
    setIsOpen(window.localStorage.getItem("navbar-open") === "true");
    setHasReadFromLocalStorage(true);

    function initPortal() {
      setPortal(document.getElementById("less-than-xl-portal"));
      setIsPortalShowing(
        window.getComputedStyle(
          document.getElementById("less-than-xl-portal")!,
          null,
        ).display !== "none",
      );
    }
    initPortal();
    window.addEventListener("resize", initPortal);
    return () => window.removeEventListener("resize", initPortal);
  }, []);
  useEffect(() => {
    if (hasReadFromLocalStorage)
      window.localStorage.setItem("navbar-open", String(isOpen));
  }, [isOpen, hasReadFromLocalStorage]);

  return (
    <>
      <aside
        suppressHydrationWarning
        className={cn(
          "sticky bottom-0 start-0 top-0 hidden h-screen max-h-screen flex-col overflow-y-auto border-e-2 border-e-border xl:flex",
          isOpen && "w-52",
          !isOpen && "w-fit overflow-hidden",
        )}
      >
        <div className="sticky top-0 me-auto ms-1 bg-background pe-1">
          <Button
            size={"icon"}
            onClick={() => setIsOpen((prev) => !prev)}
            className={cn(
              "transition-all duration-200",
              "flex w-full rounded p-1 [&_svg]:min-h-7 [&_svg]:min-w-7 [&_svg]:text-primary", // Layout
              "bg-background shadow-none hover:bg-accent hover:shadow-sm", // Light mode
            )}
          >
            <Menu />
          </Button>
        </div>
        <div className="flex flex-1 flex-col gap-0.5 p-1 transition-all ">
          {routes.map((section, index) => (
            <Fragment key={index}>
              {section
                .filter(
                  (route) =>
                    !route.roles || route.roles.includes(user?.admin.role),
                )
                .map((route) => (
                  <NavigationButton
                    tooltip={!isOpen}
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
              <span
                className={cn(
                  "transition-colors duration-200",
                  "flex w-fit rounded p-1 [&_svg]:min-h-6 [&_svg]:min-w-6 [&_svg]:text-primary", // Layout
                  "bg-background hover:bg-accent", // Light mode
                )}
              >
                {<User />}
                <span
                  className={cn(
                    "flex overflow-hidden text-start transition-all",
                    !isOpen && "max-h-0 w-0 opacity-0 ease-in",
                    isOpen && "opacity-1 ms-1 ease-out sm:min-w-32",
                  )}
                >
                  {t("navigation.preferences")}
                </span>
              </span>
            </DropdownMenuTrigger>
            <DropdownMenuContent sideOffset={7} className="mb-2" side="right">
              <DropdownMenuItem className="flex justify-center">
                {`${user?.admin.firstName} ${user?.admin.lastName}`}
              </DropdownMenuItem>
              <DropdownMenuSeparator />
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
              <DropdownMenuItem onClick={handleLogout}>
                {t("logout")}
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      </aside>
      {isPortalShowing && (
        <Sheet open={isOpen} onOpenChange={setIsOpen} modal={false}>
          <SheetTrigger asChild>
            <Button
              size={"icon"}
              className={cn(
                "fixed flex transition-all duration-200",
                "flex rounded p-1 [&_svg]:min-h-7 [&_svg]:min-w-7 [&_svg]:text-primary", // Layout
                "bg-background shadow-none hover:bg-accent hover:shadow-sm", // Light mode
              )}
            >
              <Menu />
            </Button>
          </SheetTrigger>
          <SheetContent
            SheetPortalProps={{ container: portal }}
            className="flex flex-col justify-between"
            side={i18n.dir(i18n.language) === "ltr" ? "left" : "right"}
          >
            <div className="mt-4 flex flex-col gap-1">
              <SheetTitle></SheetTitle>
              {routes.map((section, index) => (
                <Fragment key={index}>
                  {section
                    .filter(
                      (route) =>
                        !route.roles || route.roles.includes(user?.admin.role),
                    )
                    .map((route) => (
                      <NavigationButton
                        onClick={() => setIsOpen(false)}
                        tooltip={!isOpen}
                        key={route.key}
                        route={route}
                        isActive={activeRoute === route.key}
                      />
                    ))}
                  {index !== routes.length - 1 && <Divider />}
                </Fragment>
              ))}
            </div>

            <DropdownMenu>
              <DropdownMenuTrigger>
                <span
                  className={cn(
                    "transition-colors duration-200",
                    "flex w-full rounded p-1 [&_svg]:min-h-6 [&_svg]:min-w-6 [&_svg]:text-primary", // Layout
                    "bg-background hover:bg-accent", // Light mode
                  )}
                >
                  {<User />}
                  <span
                    className={cn(
                      "flex overflow-hidden text-start transition-all",
                      !isOpen && "max-h-0 w-0 opacity-0 ease-in",
                      isOpen && "opacity-1 ms-1 ease-out sm:min-w-32",
                    )}
                  >
                    {t("navigation.preferences")}
                  </span>
                </span>
              </DropdownMenuTrigger>
              <DropdownMenuContent
                sideOffset={7}
                className="mb-2"
                side="bottom"
                align="end"
              >
                <DropdownMenuItem className="flex justify-center">
                  {`${user?.admin.firstName} ${user?.admin.lastName}`}
                </DropdownMenuItem>
                <DropdownMenuSeparator />
                <DropdownMenuLabel>{t("theme.theme")}</DropdownMenuLabel>
                <DropdownMenuRadioGroup
                  value={theme}
                  onValueChange={(value) => {
                    setTheme(value);
                  }}
                >
                  {themes.map((theme) => (
                    <DropdownMenuRadioItem
                      onClick={() => setIsOpen(false)}
                      key={theme}
                      value={theme}
                    >
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
                      <DropdownMenuRadioItem
                        onClick={() => setIsOpen(false)}
                        value={locale}
                      >
                        {t(`languages.${locale}`)}
                      </DropdownMenuRadioItem>
                    </Link>
                  ))}
                </DropdownMenuRadioGroup>
                <DropdownMenuSeparator />
                <DropdownMenuItem onClick={handleLogout}>
                  {t("logout")}
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </SheetContent>
        </Sheet>
      )}
    </>
  );
};
