"use client";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/ui/data-table";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { useTranslation } from "@/i18n/client";
import { Order } from "@/service/api.schemas";
import { createColumnHelper } from "@tanstack/react-table";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { MoreHorizontal } from "lucide-react";
import Link from "next/link";
const columnHelper = createColumnHelper<Order>();
export const columns = (t: TFunction<string, string>) => [
  columnHelper.accessor("user", {
    cell: ({ cell }) =>
      `${(cell.getValue() as any).firstName} ${
        (cell.getValue() as any).lastName
      }`,
    header: t("user"),
  }),
  { accessorKey: "locationStart.region", header: t("regionStart") },
  { accessorKey: "locationEnd.region", header: t("regionEnd") },
  columnHelper.accessor("photos", {
    header: t("photos"),
    cell: ({ cell }) => cell.getValue().length,
  }),
  columnHelper.accessor("desiredDate", {
    header: t("desiredDate"),
    cell: ({ cell }) => dayjs(cell.getValue()).format("YYYY/MM/DD hh:mm A"),
  }),
  columnHelper.display({
    cell: ({ row }) => (
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="secondary" className="h-6 w-6 p-0 ">
            <MoreHorizontal className="h-4 w-4" />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end">
          <DropdownMenuItem asChild>
            <Link href={`/orders/${row.original.id}/review`} prefetch={false}>
              {t("review")}
            </Link>
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    ),
    id: "actions",
  }),
];
export type OrderDataTableProps = { data: Order[] };
export function OrderDataTable({ data }: OrderDataTableProps) {
  const { t } = useTranslation("orders");

  return <DataTable columns={columns(t)} data={data} />;
}
