import { PageProps } from "@/app/type";
import { Card } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { getTranslation } from "@/i18n/server";
import { cn } from "@/lib/utils";
import { statisticsControllerFind } from "@/service/api";
import { Inbox, Truck, Users } from "lucide-react";
import { ReactNode } from "react";
import { LabelCount } from "./labe-count";
export type CountsProps = PageProps;
export async function Counts(props: CountsProps) {
  const { t } = await getTranslation(props.params.lng, "home");
  const counts = (await statisticsControllerFind()).data;

  return (
    <div className="grid grid-cols-1 gap-2 md:grid-cols-2 lg:grid-cols-3 [&_svg]:h-full [&_svg]:w-32">
      <Section
        icon={<Users />}
        className="text-purple-700 dark:text-purple-300"
      >
        {[
          { label: t("user"), count: counts.user },
          { label: t("driver"), count: counts.driver },
          { label: t("car"), count: counts.car },
        ].map((card, index) => (
          <LabelCount
            count={card.count}
            index={index}
            key={index}
            label={card.label}
          />
        ))}
      </Section>
      <Section icon={<Inbox />} className="text-lime-600 dark:text-lime-200">
        {[
          {
            label: t("orderCompleted"),
            count: counts.orderCompleted,
          },
          {
            label: t("orderActive"),
            count: counts.orderActive,
          },
          {
            label: t("orderWaiting"),
            count: counts.orderWaiting,
          },
        ].map((card, index) => (
          <LabelCount
            count={card.count}
            index={index}
            key={index}
            label={card.label}
          />
        ))}
      </Section>
      <Section icon={<Truck />} className="text-sky-500 dark:text-sky-200">
        {[

          {
            label: t("subOrderCompleted"),
            count: counts.subOrderCompleted,
          },
          {
            label: t("subOrderActive"),
            count: counts.subOrderActive,
          },
        ].map((card, index) => (
          <LabelCount
            count={card.count}
            index={index}
            key={index}
            label={card.label}
          />
        ))}
      </Section>
    </div>
  );
}
export type SkeletonCountsProps = {};
export function SkeletonCounts({}: SkeletonCountsProps) {
  return (
    <div className="grid grid-cols-1 gap-2 md:grid-cols-2 lg:grid-cols-3 [&_svg]:h-full [&_svg]:w-32">
      <Section
        icon={<Users />}
        className="text-purple-700 dark:text-purple-300 [&>div]:ms-4 [&>div]:flex-1"
      >
        <Skeleton className="h-6" />
        <Skeleton className="h-6" />
        <Skeleton className="h-6" />
      </Section>
      <Section
        icon={<Inbox />}
        className="text-lime-600 dark:text-lime-200 [&>div]:ms-4 [&>div]:flex-1"
      >
        <Skeleton className="h-6" />
        <Skeleton className="h-6" />
        <Skeleton className="h-6" />
      </Section>
      <Section
        icon={<Truck />}
        className="text-sky-500 dark:text-sky-200 [&>div]:ms-4 [&>div]:flex-1"
      >
        <Skeleton className="h-6" />
        <Skeleton className="h-6" />
      </Section>
    </div>
  );
}
export type SectionProps = {
  icon: ReactNode;
  children: ReactNode;
  className: string;
};
export function Section({ children, className, icon }: SectionProps) {
  return (
    <Card className={cn("flex flex-row justify-between p-4", className)}>
      {icon}
      <div className="flex flex-col justify-center gap-2">{children}</div>
    </Card>
  );
}
