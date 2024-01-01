import Link from "next/link";
import { PageProps } from "../type";

export default async function Page({ params: { lng } }: PageProps) {
  return (
    <>
      <Link href={"/post"}>{"hello"}</Link>
    </>
  );
}
