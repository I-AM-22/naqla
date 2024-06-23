import { PageProps } from "@/app/type";
import { advantagesControllerFindOne } from "@/service/api";
import { EditForm } from "./edit-form";

export default async function Page(props: PageProps<{ id: string }>) {
  const advantage = await advantagesControllerFindOne({ id: props.params.id });
  return <EditForm advantage={advantage.data} />;
}
