"use client";
import { DataTable } from "@/components/ui/data-table";
import { Skeleton } from "@/components/ui/skeleton";
import { useTranslation } from "react-i18next";
import { columns } from "./data-table";

export default function Loading() {
  const { t, i18n } = useTranslation("drivers");
  return (
    <article className="flex flex-col gap-2">
      <Skeleton className="h-6 w-40 text-2xl"></Skeleton>
      <DataTable columns={columns(t, i18n.language)} type="loading" />
    </article>
  );
}
