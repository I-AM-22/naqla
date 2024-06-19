"use client";
import { DataTable } from "@/components/ui/data-table";
import { useTranslation } from "react-i18next";
import { columns } from "./page";

export default function Loading() {
  const { t } = useTranslation("car-advantages");
  return <DataTable columns={columns(t)} type="loading" />;
}
