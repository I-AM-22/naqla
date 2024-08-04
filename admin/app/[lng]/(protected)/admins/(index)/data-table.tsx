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
import { adminsControllerDelete } from "@/service/api";
import { Admin } from "@/service/api.schemas";
import { createColumnHelper } from "@tanstack/react-table";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { Edit, MoreHorizontal, Trash2 } from "lucide-react";
import Link from "next/link";
import { useState } from "react";
import { toast } from "sonner";
const columnHelper = createColumnHelper<Admin>();
export const columns = (t: TFunction<string, string>, language: string) => [
  columnHelper.display({
    cell: ({ row }) => `${row.original.firstName} ${row.original.lastName}`,
    header: t("name"),
  }),
  columnHelper.accessor("phone", {
    header: t("phone"),
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
      const remove = useMutation(adminsControllerDelete);

      return (
        // row.original.role === "admin" &&
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
            <DropdownMenuItem asChild>
              <Link prefetch={false} href={`/admins/${row.original.id}/edit`}>
                <p className="flex-1">{t("edit")}</p>
                <Edit className="ms-2 h-4 w-4" />
              </Link>
            </DropdownMenuItem>
            <DropdownMenuItem
              disabled={remove.isPending}
              onClick={async (e: any) => {
                e.preventDefault();
                await remove.mutate(
                  { id: row.original.id },
                  {
                    onSuccess: () => {
                      toast.success(t("removeSuccess"));
                      revalidatePath("/admins");
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
export type AdminsTableProps = { data: Admin[] };
export function AdminsTable({ data }: AdminsTableProps) {
  const { t, i18n } = useTranslation("admins");

  return (
    <article className="flex flex-col gap-2">
      <Button asChild className="ms-auto">
        <Link href={`/admins/new`}>{t("addAdmin")}</Link>
      </Button>
      <DataTable columns={columns(t, i18n.language)} data={data} />
    </article>
  );
}
