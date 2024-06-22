import { PageProps } from "@/app/type";
import { driversControllerFindOne } from "@/service/api";
import { WithdrawForm } from "./withdraw-form";

export default async function Page(props: PageProps<{ id: string }>) {
  const driver = (await driversControllerFindOne({ id: props.params.id })).data;
  return <WithdrawForm driver={driver} />;
}
