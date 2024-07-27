import { PageProps } from "@/app/type";
import { Card } from "@/components/ui/card";
import { getTranslation } from "@/i18n/server";
import { settingsControllerFindAll } from "@/service/api";
import { SettingForm } from "./setting-form";

export default async function Page(props: PageProps) {
  const { t } = await getTranslation(props.params.lng, "settings");
  const settings = (await settingsControllerFindAll()).data;
  return (
    <Card className="p-5">
      <h2 className="mb-2 text-2xl font-semibold">{t("generalSettings")}</h2>
      <div className="w-fit p-2">
        {settings
          .sort((a, b) => sortMap.indexOf(a.name) - sortMap.indexOf(b.name))
          .map((setting) => (
            <SettingForm key={setting.id} setting={setting} />
          ))}
      </div>
    </Card>
  );
}
const sortMap = [
  "profit",
  "defaultWeight",
  "minWeight",
  "midWeight",
  "maxWeight",
  "porters",
];
