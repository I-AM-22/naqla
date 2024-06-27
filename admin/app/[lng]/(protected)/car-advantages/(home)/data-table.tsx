"use client";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Loading } from "@/components/ui/loading";
import { Advantage } from "@/service/api.schemas";
import { createColumnHelper } from "@tanstack/react-table";
import { toast } from "sonner";

import { revalidatePath } from "@/actions/cache";
import { DataTable } from "@/components/ui/data-table";
import { useMutation } from "@/hooks/use-mutation";
import { advantagesControllerDelete } from "@/service/api";
import { TFunction } from "i18next";
import { Edit, MoreHorizontal, Trash2 } from "lucide-react";
import Link from "next/link";
import { useState } from "react";
import { useTranslation } from "react-i18next";
const columnHelper = createColumnHelper<Advantage>();
export const columns = (t: TFunction) => [
  { accessorKey: "name", header: t("name") },
  { accessorKey: "cost", header: t("cost") },
  columnHelper.display({
    id: "options",
    header: t("options"),
    cell: function Cell({ row }) {
      const [dropdownOpen, setDropdownOpen] = useState(false);
      const remove = useMutation(advantagesControllerDelete);
      return (
        <DropdownMenu onOpenChange={setDropdownOpen} open={dropdownOpen}>
          <DropdownMenuTrigger asChild>
            <Button variant="default" className="h-6 w-6 p-0 ">
              <span className="sr-only">Open menu</span>
              <MoreHorizontal className="h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="start">
            <DropdownMenuLabel>{t("options")}</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem asChild>
              <Link href={`/car-advantages/${row.original.id}/edit`}>
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
                      revalidatePath("/car-advantages");
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
export type AdvantagesDataTableProps = { data: Advantage[] };
export function AdvantagesDataTable({ data }: AdvantagesDataTableProps) {
  const { t } = useTranslation("car-advantages");

  return <DataTable columns={columns(t)} data={data} />;
}
