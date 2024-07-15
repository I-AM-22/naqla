"use client";
import { AdvantageSuper } from "@/service/api.schemas";
import { LabelList, Pie, PieChart } from "recharts";

import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart";
import { useTranslation } from "@/i18n/client";
import { ReactNode } from "react";

export type AdvantagePieProps = {
  title: ReactNode;
  data: (AdvantageSuper & { color: string })[];
};
export function AdvantagePie({ data, title }: AdvantagePieProps) {
  const { t } = useTranslation("home");
  const colored: (AdvantageSuper & { fill: string })[] = [];
  const chartConfig: ChartConfig = {
    percentage: {
      label: t("usagePercentage"),
    },
  };
  data.forEach((ad, index) => {
    colored.push({
      ...ad,
      fill: ad.color,
    });
    chartConfig[ad.advantage] = {
      label: ad.advantage,
      color: ad.color,
    };
  });

  return (
    <div className="flex flex-1 flex-col ">
      <h5 className="text-center text-xl">{title}</h5>
      <ChartContainer
        config={chartConfig}
        className="mx-auto aspect-square h-[300px] md:h-[400px]"
      >
        <PieChart>
          <ChartTooltip
            content={
              <ChartTooltipContent
                valueFormatter={(value) => `${value}%`}
                nameKey="percentage"
                hideLabel
              />
            }
          />
          <Pie data={colored} dataKey="percentage">
            <LabelList
              dataKey="advantage"
              className="fill-background"
              stroke="none"
              fontSize={12}
            />
          </Pie>
        </PieChart>
      </ChartContainer>
    </div>
  );
}
