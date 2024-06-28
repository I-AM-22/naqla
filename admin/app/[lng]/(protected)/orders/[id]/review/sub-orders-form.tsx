"use client";

import { revalidatePath } from "@/actions/cache";
import { Form } from "@/components/ui/form";
import Submit from "@/components/ui/submit";
import { useMutation } from "@/hooks/use-mutation";
import { useTranslation } from "@/i18n/client";
import { z } from "@/lib/zod";
import { subOrdersControllerCreate } from "@/service/api";
import { Order, OrderPhoto } from "@/service/api.schemas";
import { zodResolver } from "@hookform/resolvers/zod";
import { TFunction } from "i18next";
import { useRouter } from "next/navigation";
import { DndProvider } from "react-dnd";
import { HTML5Backend } from "react-dnd-html5-backend";
import { useForm } from "react-hook-form";
import { PhotosPicker } from "./photos-picker";
import { SubOrders } from "./sub-orders";

const schema = (photos: OrderPhoto[], t: TFunction) =>
  z
    .object({
      orderId: z.string(),
      subOrders: z.array(
        z.object({
          photos: z
            .array(
              z.object({
                id: z.string(),
                webUrl: z.string(),
                length: z.number(),
                width: z.number(),
                weight: z.number(),
              }),
            )
            .min(1, t("atLeastOneFile")),
          weight: z.coerce.number(),
        }),
      ),
    })
    .refine(
      ({ subOrders }) =>
        photos.every((photo) =>
          subOrders.some((sub) =>
            sub.photos.some((subPhoto) => subPhoto.id === photo.id),
          ),
        ),
      { message: t("notAllFilesSelected"), path: ["subOrders"] },
    );
export type Schema = z.infer<ReturnType<typeof schema>>;
export type Photo = Schema["subOrders"][number]["photos"][number];
export type SubOrdersFormProps = {
  order: Order;
};
export function SubOrdersForm({ order }: SubOrdersFormProps) {
  const { t } = useTranslation("orders", {
    keyPrefix: "subOrderCreate",
  });
  const form = useForm<z.input<ReturnType<typeof schema>>>({
    resolver: zodResolver(schema(order.photos, t)),
    defaultValues: {
      orderId: order.id,
      subOrders: [{ photos: [], weight: 0 }],
    },
  });
  const subOrdersErrorMessage = form.formState.errors.subOrders?.root?.message;
  const canDoActions = order.status === "waiting";
  const router = useRouter();
  const create = useMutation(subOrdersControllerCreate, form);
  const onSubmit = async (data: Schema) => {
    await create.mutate(
      {
        ...data,
        subOrders: data.subOrders.map((sub) => ({
          ...sub,
          photos: sub.photos.map((photo) => photo.id),
        })),
      },
      {
        onSuccess: () => {
          revalidatePath("/orders");
          router.push("/orders");
        },
      },
    );
  };

  return (
    <Form {...form}>
      <form
        onSubmit={form.handleSubmit(onSubmit)}
        className="flex flex-col gap-2"
      >
        <DndProvider backend={HTML5Backend}>
          <div className="flex flex-col gap-2 rounded-sm border-2 border-border p-2">
            <h4 className="text-lg font-semibold">{t("photos")} </h4>
            {subOrdersErrorMessage && (
              <p className="text-destructive">{subOrdersErrorMessage}</p>
            )}
            <PhotosPicker photos={order.photos} />
          </div>
          {canDoActions && <SubOrders photos={order.photos} />}
        </DndProvider>

        <Submit
          type="submit"
          disabled={!canDoActions}
          className="fit-content ms-auto"
        >
          {t("submit")}
        </Submit>
      </form>
    </Form>
  );
}
