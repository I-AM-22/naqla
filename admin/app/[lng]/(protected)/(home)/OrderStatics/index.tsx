"use client";
import { statisticsControllerFindForDate } from "@/service/api";
import {
  Bar,
  BarChart,
  CartesianGrid,
  Legend,
  Rectangle,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

import { Calendar } from "@/components/ui/calendar";
import { useQuery } from "@tanstack/react-query";
import dayjs from "dayjs";
import { TFunction } from "i18next";
import { ReactNode, useState } from "react";
import { DateRange } from "react-day-picker";
import { useTranslation } from "react-i18next";
const labels = (t: TFunction) =>
  ({
    completedOrders: t("completedOrders"),
    AllOrders: t("AllOrders"),
    refusedOrders: t("refusedOrders"),
  }) as Record<string, string>;
export type OrderStaticsProps = { children: ReactNode };
export function OrderStatics({ children }: OrderStaticsProps) {
  const { t, i18n } = useTranslation("home");

  const [date, setDate] = useState<DateRange | undefined>({
    from: dayjs().set("date", 1).toDate(),
    to: new Date(),
  });
  const ordersQuery = useQuery({
    queryKey: ["statistics", "orders", date],
    enabled: !!(date?.from && date.to),
    queryFn: () =>
      statisticsControllerFindForDate({
        firstDate: date?.from?.toISOString() ?? new Date().toISOString(),
        secondDate: date?.to?.toISOString() ?? new Date().toISOString(),
      }),
  });
  return (
    <div className="flex h-[400px] w-full flex-row">
      <div className="flex flex-col">
        {children}
        <Calendar
          initialFocus
          mode="range"
          defaultMonth={date?.from}
          selected={date}
          onSelect={setDate}
          numberOfMonths={1}
        />
      </div>
      <ResponsiveContainer className="pt-2">
        <BarChart
          width={500}
          height={300}
          data={
            ordersQuery.data?.data.map((data) => ({
              ...data,
              AllOrders: Number(data.AllOrders),
              completedOrders: Number(data.completedOrders),
              refusedOrders: Number(data.refusedOrders),
            })) ?? []
          }
        >
          <CartesianGrid vertical={false} />
          <XAxis
            reversed={i18n.dir() === "ltr" ? false : true}
            dataKey="day"
            tickFormatter={(v: string) => dayjs(v).format("MM/DD")}
          />
          <YAxis
            orientation={i18n.dir() === "ltr" ? "left" : "right"}
            dx={i18n.dir() === "ltr" ? 0 : 30}
            allowDecimals={false}
          />
          <Tooltip
            labelFormatter={(label) => {
              return dayjs(label).format("YYYY/MM/DD");
            }}
            formatter={(label, payload) => [label, labels(t)[payload]]}
          />
          <Legend formatter={(v) => labels(t)[v]} />
          <Bar
            dataKey="completedOrders"
            fill="#82ca9d"
            activeBar={<Rectangle fill="gold" stroke="purple" />}
          />
          <Bar
            dataKey="AllOrders"
            fill="#8884d8"
            activeBar={<Rectangle fill="pink" stroke="blue" />}
          />
          <Bar
            dataKey="refusedOrders"
            fill="#f87171"
            activeBar={<Rectangle fill="gold" stroke="purple" />}
          />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}
