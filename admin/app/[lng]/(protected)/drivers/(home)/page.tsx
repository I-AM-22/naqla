import { statisticsControllerStaticsDriver } from "@/service/api";
import { DriversTable } from "./data-table";

export default async function Page() {
  const res = await statisticsControllerStaticsDriver({});
  return (
    <article className="flex flex-col gap-2">
      {/* @ts-ignore */}
      <DriversTable data={res.data} />
    </article>
  );
}
