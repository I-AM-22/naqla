import { usersControllerFind } from "@/service/api";
import { CustomersTable } from "./data-table";

export default async function Page() {
  const res = await usersControllerFind({});
  return (
    <article className="flex flex-col gap-2">
      {/* @ts-ignore */}
      <CustomersTable data={res.data.data} />
    </article>
  );
}
