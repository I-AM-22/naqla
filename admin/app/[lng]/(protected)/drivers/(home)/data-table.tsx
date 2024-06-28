"use client";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/ui/data-table";
import { useTranslation } from "@/i18n/client";
import { priceFormatter } from "@/lib/utils";
import { Driver } from "@/service/api.schemas";
import { createColumnHelper } from "@tanstack/react-table";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { CircleArrowUp } from "lucide-react";
import Link from "next/link";
const columnHelper = createColumnHelper<Driver>();
export const columns = (t: TFunction<string, string>, language: string) => [
  columnHelper.display({
    cell: ({ row }) => (
      <img
        alt="customer"
        className="h-5 min-w-5 flex-shrink"
        // @ts-ignore
        src={row.original.photos[0].webUrl}
      />
    ),
    id: "photo",
    header: "",
  }),
  columnHelper.display({
    cell: ({ row }) => `${row.original.firstName} ${row.original.lastName}`,
    header: t("name"),
  }),
  columnHelper.accessor("phone", {
    header: t("phone"),
  }),
  // @ts-ignore
  columnHelper.accessor("countOrderDelivered", {
    header: t("countOrderDelivered"),
  }),
  // @ts-ignore
  columnHelper.accessor("countCar", {
    header: t("countCar"),
  }),
  columnHelper.accessor("wallet.available", {
    header: t("wallet"),
    cell: ({ cell, row }) =>
      // @ts-ignore
      cell.getValue() > 0 ? (
        <Button asChild variant={"ghost"}>
          <Link
            className="flex gap-2 font-normal"
            href={`/drivers/${row.original.id}/withdraw`}
          >
            {/* @ts-ignore */}
            {priceFormatter(cell.getValue(), language)} {/* @ts-ignore */}
            {cell.getValue() > 0 && (
              <CircleArrowUp className="text-orange-400" />
            )}
          </Link>
        </Button>
      ) : (
        <Button variant={"ghost"} className="flex gap-2 font-normal">
          {/* @ts-ignore */}
          {priceFormatter(cell.getValue(), language)}
        </Button>
      ),
  }),
  columnHelper.accessor("createdAt", {
    header: t("createdAt"),
    cell: ({ cell }) => dayjs(cell.getValue()).format("YYYY/MM/DD hh:mm A"),
  }),
];
export type DiversTableProps = { data: Driver[] };
export function DriversTable({ data }: DiversTableProps) {
  const { t, i18n } = useTranslation("drivers");
  return (
    <article className="flex flex-col gap-2">
      {/* @ts-ignore */}
      <DataTable columns={columns(t, i18n.language)} data={data} />
    </article>
  );
}
