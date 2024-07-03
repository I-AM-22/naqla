"use client";
import {
  Legend,
  PolarAngleAxis,
  PolarGrid,
  PolarRadiusAxis,
  Radar,
  RadarChart,
  ResponsiveContainer,
} from "recharts";

import { Skeleton } from "@/components/ui/skeleton";
import { useQuery } from "@tanstack/react-query";
import { TFunction } from "i18next";
import { useTheme } from "next-themes";
import { useTranslation } from "react-i18next";
const labels = (t: TFunction) =>
  ({
    completedOrders: t("completedOrders"),
    AllOrders: t("AllOrders"),
    refusedOrders: t("refusedOrders"),
  }) as Record<string, string>;
export type AdvantagesProps = {};
export function Advantages({}: AdvantagesProps) {
  const { t } = useTranslation("home");
  const theme = useTheme().theme;
  const advantagesQuery = useQuery({
    queryKey: ["statistics", "advantages"],
    queryFn: () => StatisticsControllerFindLimitAdvantagesResult({ limit: 7 }),
  });
  const maxCount = Math.max(
    ...(advantagesQuery.data?.data.map((ad) =>
      Math.max(ad.countCarUsed, ad.countUserUsed),
    ) ?? []),
  );
  return (
    <div className="relative h-[500px]">
      {advantagesQuery.isLoading && <Skeleton className="absolute inset-0" />}
      <p>{t("advantagesUsage")}</p>
      <ResponsiveContainer width="100%" height="100%">
        <RadarChart
          cx="50%"
          cy="50%"
          outerRadius="80%"
          data={advantagesQuery.data?.data.filter((ad) => ad.advantage) ?? []}
        >
          <PolarGrid />
          <Legend />
          <PolarAngleAxis
            dataKey="advantage"
            stroke={theme === "dark" ? "#ddd" : ""}
            fill={theme === "dark" ? "#ddd" : ""}
          />
          <PolarRadiusAxis
            allowDecimals={false}
            angle={50}
            label={{ value: t("totalCount") }}
            stroke={theme === "dark" ? "#fff" : "#444"}
            fill={theme === "dark" ? "#fff" : "#444"}
            domain={[0, maxCount]}
          />
          <Radar
            name={t("countUserUsed")}
            dataKey="countUserUsed"
            stroke="#0284c7"
            fill="#0284c7"
            fillOpacity={0.4}
          />
          <Radar
            name={t("countCarUsed")}
            dataKey={"countCarUsed"}
            stroke="#e11d48"
            fill="#e11d48"
            fillOpacity={0.4}
          />
        </RadarChart>
      </ResponsiveContainer>
    </div>
  );
}
