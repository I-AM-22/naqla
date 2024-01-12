import { ReactNode } from "react";

export type PageProps = { params: { lng: string } };
export type LayoutProps = PageProps & { children: ReactNode };
