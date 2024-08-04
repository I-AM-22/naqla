"use client";
import { statisticsControllerProfits } from "@/service/api";
import {
  Area,
  AreaChart,
  CartesianGrid,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

import { DatePickerRange } from "@/components/ui/date-picker-range";
import { Skeleton } from "@/components/ui/skeleton";
import { dateDayEnd, dateDayStart } from "@/lib/dayjs";
import { priceFormatter } from "@/lib/utils";
import { useQuery } from "@tanstack/react-query";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { useTheme } from "next-themes";
import { useState } from "react";
import { DateRange } from "react-day-picker";
import { useTranslation } from "react-i18next";
const labels = (t: TFunction) =>
  ({
    completedOrders: t("completedOrders"),
    AllOrders: t("AllOrders"),
    refusedOrders: t("refusedOrders"),
  }) as Record<string, string>;
export type ProfitsProps = {};
export function Profits({}: ProfitsProps) {
  const { t, i18n } = useTranslation("home");
  const theme = useTheme().theme;

  const [date, setDate] = useState<DateRange | undefined>({
    from: dateDayStart(dayjs().set("date", 1)),
    to: dateDayEnd(new Date()),
  });
  const profitsQuery = useQuery({
    queryKey: ["statistics", "profits", date],
    enabled: !!(date?.from && date.to),
    queryFn: () =>
      statisticsControllerProfits({
        first_date: date?.from?.toISOString() ?? new Date().toISOString(),
        second_date: date?.to?.toISOString() ?? new Date().toISOString(),
      }),
  });
  return (
    <div className="flex flex-col">
      <div className="mx-auto">
        <DatePickerRange
          className="my-2 md:ms-[140px]"
          date={date}
          onChange={(date) => {
            setDate({
              from: dateDayStart(date?.from),
              to: dateDayEnd(date?.to),
            });
          }}
        />
      </div>
      <div className="relative h-[500px]">
        {profitsQuery.isLoading && <Skeleton className="absolute inset-0" />}
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart
            width={400}
            margin={{ top: 0, right: 100, left: 0, bottom: 0 }}
            height={400}
            data={
              profitsQuery.data?.data.map((data) => ({
                ...data,
                profits: Number(data.profits),
              })) ?? []
              // [
              //   { day: "2024-01-01", profits: 130000 },
              //   { day: "2024-01-02", profits: 40000 },
              //   { day: "2024-01-03", profits: 50000 },
              //   { day: "2024-01-04", profits: 30000 },
              //   { day: "2024-01-05", profits: 50000 },
              //   { day: "2024-01-06", profits: 70000 },
              //   { day: "2024-01-07", profits: 53200 },
              //   { day: "2024-01-08", profits: 83400 },
              //   { day: "2024-01-09", profits: 32000 },
              //   { day: "2024-01-20", profits: 62000 },
              //   { day: "2024-02-30", profits: 1135 },
              //   { day: "2024-04-11", profits: 12000 },
              // ]
            }
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis
              reversed={i18n.dir() === "ltr" ? false : true}
              dataKey="day"
              stroke={theme === "dark" ? "#dddddd" : "#222222"}
              fill={theme === "dark" ? "#dddddd" : "#222222"}
              tickFormatter={(v) => dayjs(v).format("MM/DD")}
            />
            <YAxis
              orientation={i18n.dir() === "ltr" ? "left" : "right"}
              dx={i18n.dir() === "ltr" ? 0 : 100}
              stroke={theme === "dark" ? "#dddddd" : "#222222"}
              fill={theme === "dark" ? "#dddddd" : "#222222"}
              tickFormatter={(v) => priceFormatter(v, i18n.language, false)}
            />
            <Tooltip
              formatter={(label) => [
                priceFormatter(Number(label), i18n.language),
                t("profits"),
              ]}
              labelFormatter={(date) => dayjs(date).format("YYYY/MM/DD")}
              labelClassName="text-orange-600"
            />
            <Area
              type="monotone"
              dataKey="profits"
              // use darker green colors for light theme
              stroke={theme === "dark" ? "#82ca9d" : "#427c58"}
              fill={theme === "dark" ? "#82ca9d" : "#82ca9d"}
            />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}
