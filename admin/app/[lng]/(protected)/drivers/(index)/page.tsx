import { statisticsControllerStaticsDriver } from "@/service/api";
import { DriversTable } from "./data-table";

export default async function Page({
  searchParams,
}: {
  searchParams?: { [key: string]: string | string[] | undefined };
}) {
  const ratingAsc = searchParams?.["rating"] === "asc";

  const res = await statisticsControllerStaticsDriver({ sort: ratingAsc });

  return (
    <article className="flex flex-col gap-2">
      {/* @ts-ignore */}
      <DriversTable data={res.data} />
    </article>
  );
}
