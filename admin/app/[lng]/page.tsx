import { getTranslation } from "@/i18n/server";
import Link from "next/link";
import { PageProps } from "../type";

export default async function Page({ params: { lng } }: PageProps) {
  const { t } = await getTranslation(lng);
  return (
    <>
      <Link href={"/posts"}>{t("hello")}</Link>
    </>
  );
}
