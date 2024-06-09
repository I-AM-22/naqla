import { PageProps } from "@/app/type";
import { getTranslation } from "@/i18n/server";
import { orderControllerFindOne } from "@/service/api";
import { ordersTagKeys } from "@/service/orders";
export default async function Page(props: PageProps<{ id: string }>) {
  const { t: ct } = await getTranslation(props.params.lng);
  const res = await orderControllerFindOne(
    { id: props.params.id },
    { next: { tags: ordersTagKeys.details() } },
  );
  console.log(res);

  return (
    <article className="flex flex-col gap-2">
      <div className="flex justify-end"></div>
    </article>
  );
}
