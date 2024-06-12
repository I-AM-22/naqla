import { cn } from "@/lib/utils";
import { ComponentPropsWithoutRef, FC, ReactNode } from "react";

export type LabelValueProps = {
  label: ReactNode;
  labelProps?: ComponentPropsWithoutRef<"div">;
  valueProps?: ComponentPropsWithoutRef<"span">;
  children: ReactNode;
} & ComponentPropsWithoutRef<"div">;
export const LabelValue: FC<LabelValueProps> = ({
  children,
  label,
  labelProps,
  valueProps,
  ...props
}) => {
  return (
    <div {...props} className={cn("flex flex-row gap-1", props.className)}>
      <div {...labelProps}>{label}</div>
      <span
        {...valueProps}
        className={cn("text-foreground/70", valueProps?.className)}
      >
        {children}{" "}
      </span>
    </div>
  );
};
