import { PageProps } from "@/app/type";
import { usersControllerFindOne } from "@/service/api";
import { DepositForm } from "./deposit-form";

export default async function Page(props: PageProps<{ id: string }>) {
  const customer = (await usersControllerFindOne({ id: props.params.id })).data;
  return <DepositForm customer={customer} />;
}
