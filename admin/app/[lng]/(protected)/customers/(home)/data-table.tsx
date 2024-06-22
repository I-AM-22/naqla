"use client";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/ui/data-table";
import { useTranslation } from "@/i18n/client";
import { priceFormatter } from "@/lib/utils";
import { User } from "@/service/api.schemas";
import { createColumnHelper } from "@tanstack/react-table";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { CircleArrowDown } from "lucide-react";
import Link from "next/link";
const columnHelper = createColumnHelper<User>();
export const columns = (t: TFunction<string, string>, language: string) => [
  columnHelper.accessor("photo.webUrl", {
    cell: ({ cell }) => (
      <img alt="driver" className="h-5 w-5 flex-shrink" src={cell.getValue()} />
    ),

    header: "",
  }),
  columnHelper.display({
    cell: ({ row }) => `${row.original.firstName} ${row.original.lastName}`,
    header: t("name"),
  }),
  columnHelper.accessor("phone", {
    header: t("phone"),
  }),
  columnHelper.display({
    header: t("wallet"),
    cell: ({ cell, row }) => (
      <Button asChild variant={"ghost"}>
        <Link
          className="flex gap-2 font-normal"
          href={true ? `/customers/${row.original.id}/deposit` : ""}
        >
          {priceFormatter(0, language)}{" "}
          {<CircleArrowDown className="text-green-500" />}
        </Link>
      </Button>
    ),
  }),
  columnHelper.accessor("createdAt", {
    header: t("createdAt"),
    cell: ({ cell }) => dayjs(cell.getValue()).format("YYYY/MM/DD hh:mm A"),
  }),
];
export type CustomersTableProps = { data: User[] };
export function CustomersTable({ data }: CustomersTableProps) {
  const { t, i18n } = useTranslation("customers");
  return (
    <article className="flex flex-col gap-2">
      {/* @ts-ignore */}
      <DataTable columns={columns(t, i18n.language)} data={data} />
    </article>
  );
}
