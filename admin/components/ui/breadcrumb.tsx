"use client";
import { ChevronRightIcon, DotsHorizontalIcon } from "@radix-ui/react-icons";
import { Slot } from "@radix-ui/react-slot";
import * as React from "react";
import { ReactNode } from "react";

import { cn } from "@/lib/utils";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useTranslation } from "react-i18next";

const Breadcrumb = React.forwardRef<
  HTMLElement,
  React.ComponentPropsWithoutRef<"nav"> & {
    separator?: React.ReactNode;
  }
>(({ ...props }, ref) => <nav ref={ref} aria-label="breadcrumb" {...props} />);
Breadcrumb.displayName = "Breadcrumb";

const BreadcrumbList = React.forwardRef<
  HTMLOListElement,
  React.ComponentPropsWithoutRef<"ol">
>(({ className, ...props }, ref) => (
  <ol
    ref={ref}
    className={cn(
      "flex flex-wrap items-center gap-1.5 break-words text-sm text-muted-foreground sm:gap-2.5",
      className,
    )}
    {...props}
  />
));
BreadcrumbList.displayName = "BreadcrumbList";

const BreadcrumbItem = React.forwardRef<
  HTMLLIElement,
  React.ComponentPropsWithoutRef<"li">
>(({ className, ...props }, ref) => (
  <li
    ref={ref}
    className={cn("inline-flex items-center gap-1.5", className)}
    {...props}
  />
));
BreadcrumbItem.displayName = "BreadcrumbItem";

const BreadcrumbLink = React.forwardRef<
  HTMLAnchorElement,
  React.ComponentPropsWithoutRef<"a"> & {
    asChild?: boolean;
  }
>(({ asChild, className, ...props }, ref) => {
  const Comp = asChild ? Slot : "a";

  return (
    <Comp
      ref={ref}
      className={cn("transition-colors hover:text-foreground", className)}
      {...props}
    />
  );
});
BreadcrumbLink.displayName = "BreadcrumbLink";

const BreadcrumbPage = React.forwardRef<
  HTMLSpanElement,
  React.ComponentPropsWithoutRef<"span">
>(({ className, ...props }, ref) => (
  <span
    ref={ref}
    role="link"
    aria-disabled="true"
    aria-current="page"
    className={cn("font-normal text-foreground", className)}
    {...props}
  />
));
BreadcrumbPage.displayName = "BreadcrumbPage";

const BreadcrumbSeparator = ({
  children,
  className,
  ...props
}: React.ComponentProps<"li">) => (
  <li
    role="presentation"
    aria-hidden="true"
    className={cn("[&>svg]:size-3.5", className)}
    {...props}
  >
    {children ?? <ChevronRightIcon className="rtl:scale-x-[-1]" />}
  </li>
);
BreadcrumbSeparator.displayName = "BreadcrumbSeparator";

const BreadcrumbEllipsis = ({
  className,
  ...props
}: React.ComponentProps<"span">) => (
  <span
    role="presentation"
    aria-hidden="true"
    className={cn("flex h-9 w-9 items-center justify-center", className)}
    {...props}
  >
    <DotsHorizontalIcon className="h-4 w-4" />
    <span className="sr-only">More</span>
  </span>
);
BreadcrumbEllipsis.displayName = "BreadcrumbElipssis";

type BreadcrumbList = { label: ReactNode; href: string }[];
function BreadcrumbLinks({
  breadcrumbs,
  prependNavigation,
}: {
  breadcrumbs?: BreadcrumbList;
  prependNavigation?: boolean;
}) {
  const { t } = useTranslation("layout", { keyPrefix: "navigation" });
  const parentPage = usePathname().split("/")[2];
  const navigation: BreadcrumbList = prependNavigation
    ? [
        { href: "/", label: t("home") },
        { href: `/${parentPage}`, label: t(parentPage) },
      ]
    : [];
  const list = [...navigation, ...(breadcrumbs ?? [])];
  return (
    <Breadcrumb className="mb-2">
      <BreadcrumbList>
        {list.length > 1 &&
          list.slice(0, list.length - 1).map((breadcrumb) => (
            <React.Fragment key={breadcrumb.href}>
              <BreadcrumbItem>
                <BreadcrumbLink className="text-lg" asChild>
                  <Link href={breadcrumb.href}>{breadcrumb.label}</Link>
                </BreadcrumbLink>
              </BreadcrumbItem>
              <BreadcrumbSeparator />
            </React.Fragment>
          ))}
        {list[list.length - 1] && (
          <BreadcrumbItem>
            <BreadcrumbLink
              className={cn("font-normal text-foreground", "text-lg")}
              asChild
            >
              <Link href={list[list.length - 1].href}>
                {list[list.length - 1].label}
              </Link>
            </BreadcrumbLink>
          </BreadcrumbItem>
        )}
      </BreadcrumbList>
    </Breadcrumb>
  );
}

export {
  Breadcrumb,
  BreadcrumbEllipsis,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbLinks,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
};
