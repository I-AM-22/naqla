import { getPetById } from "@/service/api";

export default async function Page() {
  const data = await getPetById({ petId: 1 }, { method: "GET" });
  return <>{data.data.name}</>;
}
