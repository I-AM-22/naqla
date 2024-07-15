import { statisticsControllerStaticsUser } from "@/service/api";
import { CustomersTable } from "./data-table";

export default async function Page() {
  const res = await statisticsControllerStaticsUser({});
  return (
    <article className="flex flex-col gap-2">
      <CustomersTable data={res.data} />
    </article>
  );
}
