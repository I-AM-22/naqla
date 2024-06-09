import { ReactNode } from "react";

export type PageProps<TParams extends object = {}> = {
  params: { lng: string } & TParams;
};
export type LayoutProps<TParams extends object = {}> = PageProps<TParams> & {
  children: ReactNode;
};
