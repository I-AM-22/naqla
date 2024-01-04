import { cn } from "@/lib/utils";
import { ComponentPropsWithoutRef, FC } from "react";
export type DividerProps = ComponentPropsWithoutRef<"hr">;
export const Divider: FC<DividerProps> = ({ className, ...props }) => {
  return <hr {...props} className={cn("h-px w-full bg-border", className)} />;
};
