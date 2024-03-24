"use server";

import { revalidatePath as path, revalidateTag as tag } from "next/cache";

export async function revalidatePath(...params: Parameters<typeof path>) {
  return path(...params);
}
export async function revalidateTag(...params: Parameters<typeof tag>) {
  return tag(...params);
}
