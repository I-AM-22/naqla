import dayjs from "dayjs";

export function dateDayStart(date?: dayjs.ConfigType) {
  return dayjs(date).hour(0).minute(0).second(0).millisecond(0).toDate();
}
export function dateDayEnd(date?: dayjs.ConfigType) {
  return dayjs(date).hour(23).minute(59).second(59).millisecond(999).toDate();
}
