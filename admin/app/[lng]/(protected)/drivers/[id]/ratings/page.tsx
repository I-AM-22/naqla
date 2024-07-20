import { PageProps } from "@/app/type";
import {
  driversControllerFindOne,
  driversControllerRating,
} from "@/service/api";
import { RatingTable } from "./data-table";

export default async function Page(props: PageProps<{ id: string }>) {
  const driver = await driversControllerFindOne({ id: props.params.id });
  const ratings = await driversControllerRating({ id: props.params.id });

  return (
    <article className="flex flex-col gap-2">
      <RatingTable driver={driver.data} ratings={ratings.data} />
    </article>
  );
}
