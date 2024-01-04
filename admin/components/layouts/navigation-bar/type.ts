import { ReactNode } from "react";

export type Route = {
  key: string;
  label: string;
  icon: ReactNode;
  link?: string;
  disabled?: boolean;
};
