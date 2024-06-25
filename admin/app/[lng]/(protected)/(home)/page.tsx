import { PageProps } from "@/app/type";
import { Card } from "@/components/ui/card";
import { Loading } from "@/components/ui/loading";
import { Suspense } from "react";
import { Counts, SkeletonCounts } from "./counts";
import { OrderStatics } from "./OrderStatics";
import { ResponseTime } from "./ResponseTime";

export default async function Page(props: PageProps) {
  return (
    <div className="container flex w-full flex-col gap-2 py-10">
      <Suspense fallback={<SkeletonCounts />}>
        <Counts {...props} />
      </Suspense>
      <Card className="flex justify-between p-3">
        <Suspense fallback={<Loading />}>
          <ResponseTime {...props} />
        </Suspense>
        <OrderStatics />
      </Card>
    </div>
  );
}
