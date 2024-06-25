import { PageProps } from "@/app/type";
import { getTranslation } from "@/i18n/server";
import { statisticsControllerResponseTime } from "@/service/api";
import humanizeDuration from "humanize-duration";
import { Timer } from "lucide-react";

export type ResponseTimeProps = PageProps;
export async function ResponseTime(props: ResponseTimeProps) {
  const { i18n } = await getTranslation(props.params.lng);
  let responseTime = (await statisticsControllerResponseTime()).data;
  // mock data
  responseTime = {
    today: { hours: 1, minutes: 3, seconds: 0, milliseconds: 0 },
    yesterday: { hours: 3, minutes: 55, seconds: 0, milliseconds: 0 },
  };
  const todayInMilliseconds = responseTime.today
    ? timeToMilliseconds(responseTime.today)
    : 0;
  const yesterdayInMilliseconds = responseTime.yesterday
    ? timeToMilliseconds(responseTime.yesterday)
    : 0;
  // calculate who is better in percentage
  const percentage = (todayInMilliseconds / yesterdayInMilliseconds) * 100;
  const differencePercentage = Math.abs(percentage - 100).toFixed(2);
  const isTodayBetter = percentage >= 100;
  return (
    <div className="flex">
      <div>
        <h4 className="text-lg ">متوسط استجابة المشرفين لليوم</h4>
        <p className="m-1 rounded-sm bg-secondary p-1">
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
                {differencePercentage}% اسرع من البارحة
              </p>
            )}
            {!isTodayBetter && (
              <p className="text-red-400">
                {differencePercentage}% أبطأ من البارحة
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
  hours: number;
  minutes: number;
  seconds: number;
  milliseconds: number;
}) {
  return (
    time.hours * 60 * 60 * 1000 +
    time.minutes * 60 * 1000 +
    time.seconds * 1000 +
    time.milliseconds
  );
}
