"use client";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/ui/data-table";
import Link from "next/link";
import { useTranslation } from "react-i18next";
import { columns } from "./data-table";

export default function Loading() {
  const { t, i18n } = useTranslation("admins");
  return (
    <article className="flex flex-col gap-2">
      <Button asChild className="ms-auto">
        <Link href={`/admins/new`}>{t("addAdmin")}</Link>
      </Button>
      <DataTable columns={columns(t, i18n.language)} type="loading" />{" "}
    </article>
  );
}
