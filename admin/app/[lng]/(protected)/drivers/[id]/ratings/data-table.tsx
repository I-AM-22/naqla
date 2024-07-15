"use client";
import { DataTable } from "@/components/ui/data-table";
import { useTranslation } from "@/i18n/client";
import { Driver, Rating } from "@/service/api.schemas";
import { createColumnHelper } from "@tanstack/react-table";
import { TFunction } from "i18next";
const columnHelper = createColumnHelper<Rating>();
export const columns = (t: TFunction<string, string>, language: string) => [
  columnHelper.display({
    cell: ({ row }) => `${row.original.firstName} ${row.original.lastName}`,
    header: t("name"),
  }),
  columnHelper.accessor("rating", {
    header: t("rating"),
  }),
  columnHelper.accessor("note", {
    header: t("note"),
  }),
];
export type RatingTableProps = { ratings: Rating[]; driver: Driver };
export function RatingTable({ driver, ratings }: RatingTableProps) {
  const { t, i18n } = useTranslation("drivers");
  return (
    <article className="flex flex-col gap-2">
      <h2 className="text-2xl">
        {t("driver")} {driver.firstName} {driver.lastName}
      </h2>
      <DataTable columns={columns(t, i18n.language)} data={ratings} />
    </article>
  );
}
