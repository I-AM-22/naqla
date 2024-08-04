"use client";
import { revalidatePath } from "@/actions/cache";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/ui/data-table";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Loading } from "@/components/ui/loading";
import { useMutation } from "@/hooks/use-mutation";
import { useTranslation } from "@/i18n/client";
import { priceFormatter } from "@/lib/utils";
import { driversControllerDelete } from "@/service/api";
import { Driver } from "@/service/api.schemas";
import { createColumnHelper, SortingState } from "@tanstack/react-table";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { CircleArrowUp, MoreHorizontal, Trash2 } from "lucide-react";
import Link from "next/link";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { useCallback, useState } from "react";
import { toast } from "sonner";
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
  // @ts-ignore
  columnHelper.accessor("rating", {
    id: "rating",
    header: t("rating"),
    cell: ({ getValue, row }) => {
      return getValue() ? (
        <Link
          className="underline"
          prefetch={false}
          href={`/drivers/${row.original.id}/ratings`}
        >
          {Number(getValue()).toFixed(2)}
        </Link>
      ) : (
        <div className="ps-6">-</div>
      );
    },
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
            prefetch={false}
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
  columnHelper.display({
    id: "options",
    header: t("options"),
    cell: function Cell({ row }) {
      const [dropdownOpen, setDropdownOpen] = useState(false);
      const remove = useMutation(driversControllerDelete);
      return (
        <DropdownMenu onOpenChange={setDropdownOpen} open={dropdownOpen}>
          <DropdownMenuTrigger asChild>
            <Button variant="default" className="h-6 w-6 p-0 ">
              <span className="sr-only">Open menu</span>
              <MoreHorizontal className="h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="center">
            <DropdownMenuLabel>{t("options")}</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem
              disabled={remove.isPending}
              onClick={async (e) => {
                e.preventDefault();

                await remove.mutate(
                  { id: row.original.id },
                  {
                    onSuccess: () => {
                      toast.success(t("removeSuccess"));
                      revalidatePath("/drivers");
                    },
                  },
                );
                setDropdownOpen(false);
              }}
            >
              <p className="flex-1">{t("remove")}</p>
              {remove.isPending ? (
                <Loading className="ms-2" size="sm" />
              ) : (
                <Trash2 className="ms-2 h-4 w-4" />
              )}
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    },
  }),
];
export type DiversTableProps = { data: Driver[] };
export function DriversTable({ data }: DiversTableProps) {
  const { t, i18n } = useTranslation("drivers");

  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const ratingDesc = searchParams.get("rating") === "desc";
  const sorting: SortingState = [{ desc: ratingDesc, id: "rating" }];
  const createQueryString = useCallback(
    (name: string, value: string) => {
      const params = new URLSearchParams(searchParams.toString());
      params.set(name, value);

      return params.toString();
    },
    [searchParams],
  );
  const onSortChange = (sorting: () => SortingState) => {
    router.replace(
      `${pathname}?${createQueryString(
        "rating",
        String(sorting()[0]?.desc ? "desc" : "asc"),
      )}`,
    );
  };
  return (
    <article className="flex flex-col gap-2">
      {/* @ts-ignore */}
      <DataTable
        {...{ sorting, onSortChange }}
        columns={columns(t, i18n.language)}
        data={data}
      />
    </article>
  );
}
