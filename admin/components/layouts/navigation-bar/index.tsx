"use client";
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
import { HomeIcon } from "@radix-ui/react-icons";
import { User } from "lucide-react";
import { useTheme } from "next-themes";
import { usePathname } from "next/navigation";
import { FC, Fragment } from "react";
import { NavigationButton } from "./navigation-button";
import { Route } from "./type";

const routes: Route[][] = [
  [
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home1" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home2" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home3" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home4" },
  ],
  [
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home5" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home6" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home7" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home8" },
  ],
  [
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home9" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home10" },
    { link: "/", icon: <HomeIcon />, label: "Home", key: "home11" },
  ],
  [{ link: "/", icon: <HomeIcon />, label: "Home", key: "home12" }],
];

export type NavigationBarProps = {};
export const NavigationBar: FC<NavigationBarProps> = ({}) => {
  const activeRoute = usePathname().split("/")[0];

  const { setTheme, themes, theme } = useTheme();
  return (
    <aside className="sticky bottom-0 start-0 top-0 flex h-screen w-fit flex-col border-e-2 border-e-border p-1">
      {routes.map((section, index) => (
        <Fragment key={index}>
          {section.map((route) => (
            <NavigationButton
              key={route.key}
              route={route}
              isActive={activeRoute === route.key}
            />
          ))}
          {index !== routes.length - 1 && <Divider />}
        </Fragment>
      ))}
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant={"ghost"} size="icon">
            <User />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent sideOffset={5} side="right">
          <DropdownMenuLabel>Theme</DropdownMenuLabel>
          <DropdownMenuRadioGroup
            value={theme}
            onValueChange={(value) => {
              setTheme(value);
            }}
          >
            {themes.map((theme) => (
              <DropdownMenuRadioItem key={theme} value={theme}>
                {theme}
              </DropdownMenuRadioItem>
            ))}
          </DropdownMenuRadioGroup>
          <DropdownMenuRadioGroup
            value={theme}

          >
            {themes.map((theme) => (
              <DropdownMenuRadioItem key={theme} value={theme}>
                {theme}
              </DropdownMenuRadioItem>
            ))}
          </DropdownMenuRadioGroup>
          <DropdownMenuSeparator />
          <DropdownMenuItem>Log out</DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </aside>
  );
};
