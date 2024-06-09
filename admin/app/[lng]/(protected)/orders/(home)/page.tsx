import { PageProps } from "@/app/type";
import { getTranslation } from "@/i18n/server";
import { orderControllerFindAllWaiting } from "@/service/api";
import { ordersTagKeys } from "@/service/orders";
import { OrderDataTable } from "./data-table";
export default async function Page(props: PageProps) {
  const { t: ct } = await getTranslation(props.params.lng);
  const res = await orderControllerFindAllWaiting({
    next: { tags: ordersTagKeys.waiting() },
  });

  return (
    <article className="flex flex-col gap-2">
      <OrderDataTable data={res.data} />
    </article>
  );
}
