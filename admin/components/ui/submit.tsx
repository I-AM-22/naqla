"use client";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { ElementRef, Ref, forwardRef } from "react";
import { useFormContext } from "react-hook-form";
import { useTranslation } from "react-i18next";
import LoadingButton, { LoadingButtonProps } from "./loading-button";
export type SubmitProps = LoadingButtonProps;
const Submit = forwardRef(function Fr(
  { children, ...props }: SubmitProps,
  ref: Ref<ElementRef<typeof Button>>,
) {
  const form = useFormContext();
  const { t } = useTranslation();
  return (
    <LoadingButton
      ref={ref}
      isLoading={form?.formState.isSubmitting}
      disabled={form?.formState.isSubmitting}
      {...props}
      className={cn(
        Object.keys(form.formState.errors).length !== 0 && "text-destructive",
        props.className,
      )}
    >
      {children ?? t("submit")}
    </LoadingButton>
  );
});
export default Submit;
