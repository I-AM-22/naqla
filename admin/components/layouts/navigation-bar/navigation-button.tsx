import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";
import Link from "next/link";

import { ConditionalWrap } from "@/components/ui/conditional-wrap";
import { useTranslation } from "@/i18n/client";
import { cn } from "@/lib/utils";
import { Route } from "./type";

export type NavigationButtonProps = {
  route: Route;
  isActive?: boolean;
  tooltip: boolean;
  onClick?: () => void;
};
export const NavigationButton = ({
  route,
  tooltip,
  isActive = false,
  onClick,
}: NavigationButtonProps) => {
  const { t } = useTranslation("layout", { keyPrefix: "navigation" });
  return (
    <TooltipProvider>
      <Tooltip delayDuration={0}>
        <TooltipTrigger tabIndex={-1} onClick={onClick}>
          <ConditionalWrap
            condition={route.href !== undefined}
            wrap={(children) => <Link href={route.href ?? ""}>{children}</Link>}
          >
            <span
              className={cn(
                "transition-colors duration-200 animate-in fade-in",
                "flex w-full rounded p-1 [&_svg]:min-h-6 [&_svg]:min-w-6 [&_svg]:text-primary", // Layout
                "bg-background hover:bg-accent", // Light mode
                `${
                  isActive ? "bg-foreground/5 text-foreground shadow-sm" : ""
                }`,
              )}
            >
              {route.icon}
              <span
                className={cn(
                  "flex overflow-hidden text-start transition-all",
                  tooltip && "max-h-0 w-0 opacity-0 ease-in",
                  !tooltip && "opacity-1 ms-1 ease-out sm:min-w-32",
                )}
              >
                {t(route.label)}
              </span>
            </span>
          </ConditionalWrap>
        </TooltipTrigger>
        <TooltipContent
          side="right"
          className={cn(!tooltip && "hidden")}
          sideOffset={5}
        >
          {t(route.label)}
        </TooltipContent>
      </Tooltip>
    </TooltipProvider>
  );
};
