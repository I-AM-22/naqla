import { adminsControllerFind } from "@/service/api";
import { AdminsTable } from "./data-table";
import { Button } from "@/components/ui/button";

export default async function Page() {
  const res = await adminsControllerFind();
  return (
    <article className="flex flex-col gap-2">
      <AdminsTable data={res.data} />
    </article>
  );
}
