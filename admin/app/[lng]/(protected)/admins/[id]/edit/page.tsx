import { PageProps } from "@/app/type";
import { adminsControllerFindOne } from "@/service/api";
import { EditForm } from "./edit-form";

export default async function Page(props: PageProps<{ id: string }>) {
  const admin = await adminsControllerFindOne({ id: props.params.id });
  return <EditForm admin={admin.data} />;
}
