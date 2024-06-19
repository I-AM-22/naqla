import { driversControllerFind } from "@/service/api";
import { DriversTable } from "./data-table";

export default async function Page() {
  const res = await driversControllerFind({});
  return (
    <article className="flex flex-col gap-2">
      {/* @ts-ignore */}
      <DriversTable data={res.data.data} />
    </article>
  );
}
