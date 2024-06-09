import { PageProps } from "@/app/type";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/ui/data-table";
import { getTranslation } from "@/i18n/server";
import { advantagesControllerFindAll } from "@/service/api";
import { carAdvantagesTagKeys } from "@/service/car-advantages";
import Link from "next/link";

export default async function Page(props: PageProps) {
  const { t } = await getTranslation(props.params.lng, "car-advantages");
  const { t: ct } = await getTranslation(props.params.lng);
  const res = await advantagesControllerFindAll({
    next: { tags: carAdvantagesTagKeys.all() },
  });
  return (
    <article className="flex flex-col gap-2">
      <div className="flex justify-end">
        <Button asChild>
          <Link href={"/car-advantages/new"}>{ct("add")}</Link>
        </Button>
      </div>
      <DataTable
        columns={[
          { accessorKey: "name", header: t("name") },
          { accessorKey: "cost", header: t("cost") },
        ]}
        data={res.data}
      />
    </article>
  );
}
