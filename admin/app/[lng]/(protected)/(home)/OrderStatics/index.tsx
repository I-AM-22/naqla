"use client";
import { DatePickerRange } from "@/components/ui/date-picker-range";
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

import { useQuery } from "@tanstack/react-query";
import dayjs from "dayjs";
import { useState } from "react";
import { DateRange } from "react-day-picker";
import { useTranslation } from "react-i18next";
export type OrderStaticsProps = {};
export function OrderStatics({}: OrderStaticsProps) {
  const { t, i18n } = useTranslation();

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
  console.log(ordersQuery.data);
  return (
    <div className="flex h-[400px] w-[700px] flex-col">
      <DatePickerRange date={date} className="mx-auto" onChange={setDate} />
      <ResponsiveContainer className="p-10 pt-2">
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
          />
          <Tooltip
            labelFormatter={(label, payload) => {
              return dayjs(label).format("YYYY/MM/DD");
            }}
            formatter={(label, payload) => {
              console.log(label, payload);
              return [label, payload];
            }}
          />
          <Legend />
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
