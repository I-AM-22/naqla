import { PageProps } from "@/app/type";
import { getTranslation } from "@/i18n/server";
import { Construction } from "lucide-react";

export default async function Page(props: PageProps) {
  const { t } = await getTranslation(props.params.lng);

  return (
    <div className="container w-full py-10">
      <Construction size={400} className="mx-auto" />
      <p className="text-center text-7xl">{t("construction")}...</p>
    </div>
  );
}
