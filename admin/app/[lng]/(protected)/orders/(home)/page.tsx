import { orderControllerFindAllWaiting } from "@/service/api";
import { ordersTagKeys } from "@/service/orders";
import { OrderDataTable } from "./data-table";
export default async function Page() {
  const res = await orderControllerFindAllWaiting({
    next: { tags: ordersTagKeys.waiting() },
  });

  return (
    <article className="flex flex-col gap-2">
      <OrderDataTable data={res.data} />
    </article>
  );
}
