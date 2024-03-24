"use client";
import { useTranslation } from "@/i18n/client";
import { cn } from "@/lib/utils";
import { AlertCircle } from "lucide-react";
import { ComponentPropsWithoutRef } from "react";

export type SomethingWentWrongProps = ComponentPropsWithoutRef<"p">;
export function SomethingWentWrong({
  children,
  className,
  ...props
}: SomethingWentWrongProps) {
  const { t } = useTranslation();
  return (
    <p
      {...props}
      className={cn(
        "mx-auto flex flex-col items-center gap-2 text-xl text-destructive",
        className,
      )}
    >
      <AlertCircle size={100} />
      {t("somethingWentWrong")}
    </p>
  );
}
