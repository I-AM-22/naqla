"use client";
import { Button } from "@/components/ui/button";
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
      {...props}
      isLoading={form?.formState.isSubmitting}
      disabled={form?.formState.isSubmitting}
    >
      {children ?? t("submit")}
    </LoadingButton>
  );
});
export default Submit;
