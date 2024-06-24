import { PageProps } from "@/app/type";
import { getTranslation } from "@/i18n/server";
import { Counts } from "./counts";

export default async function Page(props: PageProps) {
  const { t } = await getTranslation(props.params.lng);

  return (
    <div className="container w-full py-10">
      <Counts {...props} />
    </div>
  );
}
