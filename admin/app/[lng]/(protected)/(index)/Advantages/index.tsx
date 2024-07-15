import { PageProps } from "@/app/type";
import { getTranslation } from "@/i18n/server";
import { statisticsControllerFindLimitAdvantages } from "@/service/api";
import { AdvantagePie } from "./Pie";
const COLORS = [
  "#ef4444",
  "#f59e0b",
  "#6366f1",
  "#65a30d",
  "#0891b2",
  "#10b981",
  "#8b5cf6",
  "#4ade80",
  "#c084fc",
  "#fcd34d",
  "#e879f9",
  "#ec4899",
  "#fb7185",
  "#2dd4bf",
  "#9a3412",
  "#854d0e",
  "#4d7c0f",
  "#15803d",
  "#047857",
  "#0369a1",
  "#5b21b6",
  "#6b21a8",
  "#a21caf",
  "#be123c",
];
export type AdvantagesProps = PageProps;
export async function Advantages(props: AdvantagesProps) {
  const { t } = await getTranslation(props.params.lng, "home");

  const advantagesStats = await statisticsControllerFindLimitAdvantages({
    limit: 8,
  });
  const colorMap = new Map<string, string>();
  [
    ...new Set(
      advantagesStats.data.cars
        .map((a) => a.advantage)
        .concat(advantagesStats.data.orders.map((a) => a.advantage)),
    ),
  ].forEach((advantage, i) => colorMap.set(advantage, COLORS[i]));

  const carAdvantages = advantagesStats.data.cars.map((ad) => ({
    ...ad,
    percentage: Number((ad.percentage * 100).toFixed(2)),
    color: colorMap.get(ad.advantage) ?? COLORS[0],
  }));
  const orderAdvantages = advantagesStats.data.orders.map((ad) => ({
    ...ad,
    percentage: Number((ad.percentage * 100).toFixed(2)),
    color: colorMap.get(ad.advantage) ?? COLORS[0],
  }));
  return (
    <div className="flex flex-col md:flex-row">
      <AdvantagePie data={carAdvantages} title={t("advantagesCar")} />
      <AdvantagePie data={orderAdvantages} title={t("advantagesOrder")} />
    </div>
  );
}
