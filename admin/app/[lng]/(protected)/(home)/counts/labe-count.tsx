"use client";

import { ReactNode } from "react";
import CountUp from "react-countup";

export type CountCardProps = {
  count: number;
  index: number;
  label: ReactNode;
};
export function LabelCount({ count, index, label }: CountCardProps) {
  return (
    <div className="flex justify-between gap-8 text-lg">
      <p>{label}</p>
      <CountUp end={count} useEasing duration={index} />
    </div>
  );
}
