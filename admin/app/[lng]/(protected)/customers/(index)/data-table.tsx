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
import { usersControllerDelete } from "@/service/api";
import { StaticsUser, User } from "@/service/api.schemas";
import { createColumnHelper } from "@tanstack/react-table";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { MoreHorizontal, Trash2 } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
const columnHelper = createColumnHelper<StaticsUser>();
export const columns = (t: TFunction<string, string>, language: string) => [
  columnHelper.display({
    id: "image",
    cell: ({ row }) => (
      <img
        alt="driver"
        className="h-5 min-w-5 flex-shrink"
        // @ts-ignore
        src={row.original.photos[0].webUrl}
      />
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

  // columnHelper.accessor("wallet.available", {
  //   header: t("wallet"),
  //   cell: ({ cell, row }) => (
  //     <Button
  //       asChild
  //       variant={"ghost"}
  //       className="flex w-full min-w-fit max-w-60 justify-between"
  //     >
  //       <Link
  //         className="flex gap-2 font-normal"
  //         href={true ? `/customers/${row.original.id}/deposit` : ""}
  //       >
  //         {/* @ts-ignore */}
  //         {priceFormatter(cell.getValue(), language)}{" "}
  //         {<CircleArrowDown className="text-green-500" />}
  //       </Link>
  //     </Button>
  //   ),
  // }),
  columnHelper.accessor("countOrderDelivered", {
    header: t("countOrderDelivered"),
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
      const remove = useMutation(usersControllerDelete);
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
              onClick={async (e: any) => {
                e.preventDefault();
                await remove.mutate(
                  { id: row.original.id },
                  {
                    onSuccess: () => {
                      toast.success(t("removeSuccess"));
                      revalidatePath("/customers");
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
