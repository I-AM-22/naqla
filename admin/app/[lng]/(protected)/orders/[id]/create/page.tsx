import { PageProps } from "@/app/type";
import { LabelValue } from "@/components/composites/label-value";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { getTranslation } from "@/i18n/server";
import { orderControllerFindOne } from "@/service/api";
import { ordersTagKeys } from "@/service/orders";
import { SubOrdersForm } from "./sub-orders-form";
export default async function Page(props: PageProps<{ id: string }>) {
  const { t } = await getTranslation(props.params.lng, "orders", {
    keyPrefix: "subOrderCreate",
  });
  const { data } = await orderControllerFindOne(
    { id: props.params.id },
    { next: { tags: ordersTagKeys.details() } },
  );

  return (
    <article className="flex flex-col gap-2">
      <Card className="">
        <CardHeader className="flex flex-row items-center gap-1 text-2xl">
          <LabelValue label={t("customer")}>
            {`${data.user.firstName} ${data.user.lastName}`}
          </LabelValue>
        </CardHeader>
        <CardContent className="flex flex-col gap-2">
          <div className="flex flex-row gap-2">
            <span>{t("requestedAdvantages")}: </span>
            <div className="text-foreground/70">
              {data.advantages.map((ad) => (
                //  @ts-ignore
                <Badge variant="outline" key={ad.name}>
                  {/* @ts-ignore */}
                  {ad.name}
                </Badge>
              ))}
            </div>
          </div>
          <SubOrdersForm order={data} />
        </CardContent>
      </Card>
    </article>
  );
}
