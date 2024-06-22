"use client";
import { DataTable } from "@/components/ui/data-table";
import { useTranslation } from "react-i18next";
import { columns } from "./data-table";

export default function Loading() {
  const { t, i18n } = useTranslation("customers");
  return <DataTable columns={columns(t, i18n.language)} type="loading" />;
}
