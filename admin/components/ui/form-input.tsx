import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { cn } from "@/lib/utils";
import { cva, type VariantProps } from "class-variance-authority";
import * as React from "react";
import { Control } from "react-hook-form";
import { Input } from "./input";

const formFieldVariants = cva("flex flex-col");

export type FormInputProps<C extends { [k: string]: any } = any> = Omit<
  React.ComponentPropsWithoutRef<typeof Input>,
  "control" | "name" | "render"
> &
  VariantProps<typeof formFieldVariants> & {
    name: keyof C extends string ? keyof C : string;
    control?: Control<C>;
    label?: React.ReactNode;
    FormItemProps?: React.ComponentPropsWithoutRef<typeof FormItem>;
    FormControlProps?: React.ComponentPropsWithoutRef<typeof FormControl>;
    FormFieldProps?: React.ComponentPropsWithoutRef<typeof FormField>;
    FormDescriptionProps?: React.ComponentPropsWithoutRef<
      typeof FormDescription
    >;
    FormLabelProps?: React.ComponentPropsWithoutRef<typeof FormLabel>;
  };

const FormInput = React.forwardRef<HTMLDivElement, FormInputProps>(
  (
    {
      label,
      name,
      control,
      className,
      FormControlProps,
      FormDescriptionProps,
      FormItemProps,
      FormFieldProps,
      FormLabelProps,
      ...props
    },
    ref,
  ) => {
    return (
      <FormField
        name={name}
        control={control}
        {...FormFieldProps}
        render={({ field }) => {
          return (
            <FormItem
              ref={ref}
              {...FormItemProps}
              className={cn(className, FormItemProps?.className)}
            >
              <FormLabel
                {...FormLabelProps}
                className={cn("ps-2", FormLabelProps?.className)}
              >
                {label}
              </FormLabel>
              <FormControl {...FormControlProps}>
                <Input {...props} {...field} />
              </FormControl>
              <FormDescription {...FormDescriptionProps} />
              <FormMessage />
              {FormItemProps?.children}
            </FormItem>
          );
        }}
      />
    );
  },
);
FormInput.displayName = "FormInput";

export { FormInput, formFieldVariants };
