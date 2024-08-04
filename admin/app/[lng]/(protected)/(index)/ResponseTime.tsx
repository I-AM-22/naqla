import { PageProps } from "@/app/type";
import { getTranslation } from "@/i18n/server";
import { statisticsControllerResponseTime } from "@/service/api";
import humanizeDuration from "humanize-duration";
import { Timer } from "lucide-react";

export type ResponseTimeProps = PageProps;
export async function ResponseTime(props: ResponseTimeProps) {
  const { i18n, t } = await getTranslation(props.params.lng, "home");
  const responseTime = (await statisticsControllerResponseTime()).data;

  const todayInMilliseconds = responseTime.today
    ? timeToMilliseconds(responseTime.today)
    : 0;
  const yesterdayInMilliseconds = responseTime.yesterday
    ? timeToMilliseconds(responseTime.yesterday)
    : 0;

  // calculate who is better in percentage
  const percentage = (todayInMilliseconds / yesterdayInMilliseconds) * 100;
  const differencePercentage = Math.abs(percentage - 100).toFixed(2);
  const isTodayBetter = percentage <= 100;
  return (
    <div className="flex">
      <div>
        <h4 className="text-lg ">{t("responseTime")}</h4>
        <p className="mx-1 my-3 rounded-sm bg-secondary p-1">
          {responseTime.today
            ? humanizeDuration(todayInMilliseconds, {
                language: i18n.language,
                units: ["h", "m", "s"],
                round: true,
                largest: 2,
                digitReplacements: [
                  "0",
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "9",
                ],
              })
            : "-"}
        </p>
        {responseTime.today && responseTime.yesterday && (
          <>
            {isTodayBetter && (
              <p className="text-green-600 dark:text-green-400">
                {differencePercentage}% {t("fasterThanYesterday")}
              </p>
            )}
            {!isTodayBetter && (
              <p className="text-red-400">
                {differencePercentage}% {t("slowerThanYesterday")}
              </p>
            )}
          </>
        )}
      </div>
      <Timer className="h-32 w-32 text-yellow-500" />
    </div>
  );
}
function timeToMilliseconds(time: {
  hours: number | null;
  minutes: number | null;
  seconds: number | null;
  milliseconds: number | null;
}) {
  return (
    (time.hours ?? 0) * 60 * 60 * 1000 +
    (time.minutes ?? 0) * 60 * 1000 +
    (time.seconds ?? 0) * 1000 +
    (time.milliseconds ?? 0)
  );
}
