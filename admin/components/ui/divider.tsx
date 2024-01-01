import { FC } from "react";
export type DividerProps = {};
export const Divider: FC<DividerProps> = ({}) => {
  return <hr className="h-px w-full bg-border" />;
};
