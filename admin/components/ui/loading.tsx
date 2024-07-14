import { cn } from "@/lib/utils";
import { cva, VariantProps } from "class-variance-authority";
import { Loader2 } from "lucide-react";

const loadingVariants = cva("animate-spin", {
  variants: {
    size: {
      sm: "min-h-4 min-w-4",
      default: "min-h-10 min-w-10",
      lg: "min-h-20 min-w-20",
    },
  },
  defaultVariants: {
    size: "default",
  },
});

export type LoadingProps = React.SVGProps<SVGSVGElement> &
  VariantProps<typeof loadingVariants>;
export function Loading({ size, className, ref, ...props }: LoadingProps) {
  return (
    <Loader2 {...props} className={cn(loadingVariants({ size, className }))} />
  );
}
