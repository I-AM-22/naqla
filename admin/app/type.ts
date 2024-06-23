import { ReactNode } from "react";

export type PageProps<
  TParams extends object = {},
  TSeach extends object = {},
> = {
  params: { lng: string } & TParams;
  searchParams: TSeach;
};
export type LayoutProps<
  TParams extends object = {},
  TSeach extends object = {},
> = PageProps<TParams, TSeach> & {
  children: ReactNode;
};
