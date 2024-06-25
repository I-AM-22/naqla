"use client";

import { Button } from "@/components/ui/button";
import { Calendar } from "@/components/ui/calendar";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { cn } from "@/lib/utils";
import dayjs from "dayjs";
import { Calendar as CalendarIcon } from "lucide-react";
import * as React from "react";
import { DateRange, SelectRangeEventHandler } from "react-day-picker";
import { useTranslation } from "react-i18next";

export type DatePickerRangeProps = Omit<
  React.ComponentPropsWithoutRef<"div">,
  "onChange"
> & {
  date: DateRange | undefined;
  onChange: SelectRangeEventHandler;
};
export function DatePickerRange({
  className,
  date,
  onChange,
  ...props
}: DatePickerRangeProps) {
  const { t } = useTranslation("common");
  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button
          id="date"
          variant={"outline"}
          className={cn(
            "w-fit justify-start text-left font-normal",
            !date && "text-muted-foreground",
            className,
          )}
        >
          <CalendarIcon className="me-2 h-4 w-4" />
          {date?.from ? (
            date.to ? (
              <>
                {dayjs(date.from).format("YYYY/MM/DD")} -{" "}
                {dayjs(date.to).format("YYYY/MM/DD")}
              </>
            ) : (
              dayjs(date.from).format("YYYY/MM/DD")
            )
          ) : (
            <span>{t("pickDate")}</span>
          )}
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-auto p-0" align="start">
        <Calendar
          initialFocus
          mode="range"
          defaultMonth={date?.from}
          selected={date}
          onSelect={onChange}
          numberOfMonths={1}
        />
      </PopoverContent>
    </Popover>
  );
}
