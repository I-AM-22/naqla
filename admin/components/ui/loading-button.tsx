import { Button, ButtonProps } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { Loader2, LucideIcon } from "lucide-react";
import { ComponentPropsWithoutRef, ElementRef, Ref, forwardRef } from "react";
export type LoadingButtonProps = {
  isLoading?: boolean;
  error?: boolean;
  LoadingProps?: ComponentPropsWithoutRef<LucideIcon>;
} & ButtonProps;
const LoadingButton = forwardRef(function Fr(
  {
    isLoading = false,
    error = false,
    disabled,
    LoadingProps,
    children,
    ...props
  }: LoadingButtonProps,
  ref: Ref<ElementRef<typeof Button>>,
) {
  return (
    <Button
      ref={ref}
      disabled={isLoading || error || disabled}
      type="submit"
      {...props}
    >
      <div className={cn("opacity-100", isLoading && "opacity-0")}>
        {children}
      </div>
      {isLoading && (
        <Loader2
          {...LoadingProps}
          className={cn(
            "absolute mx-auto aspect-square h-full max-h-10 animate-spin",
            LoadingProps?.className,
          )}
        />
      )}
    </Button>
  );
});
export default LoadingButton;
