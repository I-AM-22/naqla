import { PageProps } from "@/app/type";
import { Button } from "@/components/ui/button";
import { getTranslation } from "@/i18n/server";
import { advantagesControllerFindAll } from "@/service/api";
import { carAdvantagesTagKeys } from "@/service/car-advantages";
import Link from "next/link";
import { AdvantagesDataTable } from "./data-table";

export default async function Page(props: PageProps) {
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
      <AdvantagesDataTable data={res.data} />
    </article>
  );
}
