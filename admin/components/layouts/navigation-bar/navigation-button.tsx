import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";
import Link from "next/link";

import { ConditionalWrap } from "@/components/ui/conditional-wrap";
import { cn } from "@/lib/utils";
import { Route } from "./type";

export type NavigationButtonProps = {
  route: Route;
  isActive?: boolean;
};
export const NavigationButton = ({
  route,
  isActive = false,
}: NavigationButtonProps) => {
  return (
    <TooltipProvider>
      <Tooltip delayDuration={0}>
        <TooltipTrigger tabIndex={-1}>
          <ConditionalWrap
            condition={route.link !== undefined}
            wrap={(children) => <Link href={route.link ?? ""}>{children}</Link>}
          >
            <span
              className={cn(
                "transition-colors duration-200",
                "flex rounded p-1 [&_svg]:h-7 [&_svg]:w-7 [&_svg]:text-primary", // Layout
                "bg-background hover:bg-accent", // Light mode
                `${isActive ? "bg-selection text-foreground shadow-sm" : ""}`,
              )}
            >
              {route.icon}
            </span>
          </ConditionalWrap>
        </TooltipTrigger>
        <TooltipContent side="right" sideOffset={5}>
          {route.label}
        </TooltipContent>
      </Tooltip>
    </TooltipProvider>
  );
};
