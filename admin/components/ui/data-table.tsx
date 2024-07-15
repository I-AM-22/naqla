"use client";

import {
  ColumnDef,
  flexRender,
  getCoreRowModel,
  SortingState,
  useReactTable,
} from "@tanstack/react-table";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { useTranslation } from "@/i18n/client";
import { ChevronDown, ChevronUp, GalleryHorizontalEnd } from "lucide-react";
import { Button } from "./button";
import { Loading } from "./loading";

type DataTableProps<TData> = {
  columns: ColumnDef<TData, any>[];
} & (
  | {
      type?: "data";
      data: TData[];
    }
  | { type: "loading" }
) &
  (
    | {
        sorting: SortingState;
        onSortChange: React.Dispatch<React.SetStateAction<SortingState>>;
      }
    | {
        sorting?: false;
      }
  );

export function DataTable<TData>({ columns, ...props }: DataTableProps<TData>) {
  props.type ??= "data";
  const table = useReactTable({
    manualPagination: true,
    data: props.type === "data" ? props.data : [],
    columns,
    getCoreRowModel: getCoreRowModel(),
    ...(props.sorting
      ? {
          state: {
            sorting: props.sorting,
          },
          onSortingChange: props.onSortChange,
        }
      : {}),
  });
  const { t } = useTranslation();

  return (
    <div className="w-full rounded-md border">
      <Table>
        <TableHeader>
          {table.getHeaderGroups().map((headerGroup) => (
            <TableRow key={headerGroup.id}>
              {headerGroup.headers.map((header) => {
                return (
                  <TableHead key={header.id}>
                    {flexRender(
                      header.column.columnDef.header,
                      header.getContext(),
                    )}
                    {header.column.getIsSorted() && (
                      <Button
                        size={"icon"}
                        onClick={() =>
                          header.column.toggleSorting(
                            header.column.getIsSorted() === "asc",
                          )
                        }
                        variant={"ghost"}
                        className="inline h-4 w-5"
                      >
                        {{
                          asc: <ChevronUp className="h-5 w-5" />,
                          desc: <ChevronDown className="h-5 w-5" />,
                        }[header.column.getIsSorted() as string] ?? null}
                      </Button>
                    )}
                  </TableHead>
                );
              })}
            </TableRow>
          ))}
        </TableHeader>
        <TableBody>
          {table.getRowModel().rows?.length
            ? table.getRowModel().rows.map((row) => (
                <TableRow
                  key={row.id}
                  data-state={row.getIsSelected() && "selected"}
                >
                  {row.getVisibleCells().map((cell) => (
                    <TableCell key={cell.id}>
                      {flexRender(
                        cell.column.columnDef.cell,
                        cell.getContext(),
                      )}
                    </TableCell>
                  ))}
                </TableRow>
              ))
            : props.type == "data" && (
                <TableRow>
                  <TableCell
                    colSpan={columns.length}
                    className="h-24 text-center"
                  >
                    <p className="flex flex-col items-center gap-2 text-xl">
                      <GalleryHorizontalEnd size={100} />
                      {t("noData")}...
                    </p>
                  </TableCell>
                </TableRow>
              )}
          {props.type == "loading" && (
            <TableRow>
              <TableCell
                colSpan={table.getAllColumns().length}
                className="h-24 text-center"
              >
                <Loading className="mx-auto" />
              </TableCell>
            </TableRow>
          )}
        </TableBody>
      </Table>
    </div>
  );
}
