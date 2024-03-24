import { ReactNode } from "react";

export type Route = {
  label: string;
  icon: ReactNode;
  href?: string;
  disabled?: boolean;
  key: string;
};
