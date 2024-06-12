"use client";

import { revalidateTag } from "@/actions/cache";
import { LabelValue } from "@/components/composites/label-value";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import { Form } from "@/components/ui/form";
import Submit from "@/components/ui/submit";
import { useMutation } from "@/hooks/use-mutation";
import { useTranslation } from "@/i18n/client";
import { cn } from "@/lib/utils";
import { z } from "@/lib/zod";
import { subOrdersControllerCreate } from "@/service/api";
import { Order, OrderPhoto } from "@/service/api.schemas";
import { ordersTagKeys } from "@/service/orders";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { ComponentPropsWithoutRef, FC, useEffect } from "react";
import { DndProvider, useDrag, useDragLayer, useDrop } from "react-dnd";
import { getEmptyImage, HTML5Backend } from "react-dnd-html5-backend";
import {
  useFieldArray,
  useForm,
  useFormContext,
  useWatch,
} from "react-hook-form";

const schema = z.object({
  orderId: z.string(),
  subOrders: z.array(
    z.object({
      photos: z.array(
        z.object({
          id: z.string(),
          webUrl: z.string(),
          length: z.number(),
          width: z.number(),
          weight: z.number(),
        }),
      ),
      weight: z.number(),
    }),
  ),
});
type Schema = z.infer<typeof schema>;
type Photo = Schema["subOrders"][number]["photos"][number];
export type SubOrdersFormProps = {
  order: Order;
};
export function SubOrdersForm({ order }: SubOrdersFormProps) {
  const { t } = useTranslation("orders");
  const form = useForm<z.input<typeof schema>>({
    resolver: zodResolver(schema),
    defaultValues: {
      orderId: order.id,
      subOrders: [{ photos: [], weight: 0 }],
    },
  });
  const router = useRouter();
  const add = useMutation(subOrdersControllerCreate, form);
  console.log(order);

  const onSubmit = (data: Schema) => {
    add(
      {
        ...data,
        subOrders: data.subOrders.map((sub) => ({
          ...sub,
          photos: sub.photos.map((photo) => photo.id),
        })),
      },
      {
        onSuccess: () => {
          revalidateTag(ordersTagKeys.waiting().at(-1) ?? "");
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
            <h4 className="text-lg">{t("الملفات المرفقة")}</h4>

            <PhotosPicker photos={order.photos} />
          </div>
          <SubOrders />
        </DndProvider>
        <Submit type="submit" />
      </form>
    </Form>
  );
}

export type PhotosPickerProps = { photos: OrderPhoto[] };
export const PhotosPicker: FC<PhotosPickerProps> = ({ photos }) => {
  const { currentOffset, item: draggedItem } = useDragLayer((monitor) => ({
    item: monitor.getItem<Photo | null>(),
    isDragging: monitor.isDragging(),
    currentOffset: monitor.getSourceClientOffset(),
  }));
  const { control, setValue, getValues } = useFormContext<Schema>();

  const subOrders = useWatch({
    name: "subOrders",
    control,
  });
  const unSelectedPhotos = photos.filter(
    (photo) =>
      !subOrders.some((sub) =>
        sub.photos.some((subPhoto) => photo.webUrl === subPhoto.webUrl),
      ),
  );
  const { i18n, t } = useTranslation();
  const [{ isOver, canDrop }, drop] = useDrop(
    () => ({
      accept: ["photo"],
      canDrop: (photo) => {
        return subOrders.some((sub) =>
          sub.photos.some((subPhoto) => photo.webUrl === subPhoto.webUrl),
        );
      },
      drop: (photo: Photo) => {
        console.log(photo);
        setValue(
          "subOrders",
          getValues().subOrders.map((sub) => ({
            ...sub,
            photos: sub.photos.filter(
              (subPhoto) => subPhoto.webUrl !== photo.webUrl,
            ),
          })),
        );
      },
      collect: (monitor) => ({
        isOver: !!monitor.isOver(),
        canDrop: !!monitor.canDrop(),
      }),
    }),
    [subOrders, getValues, setValue],
  );
  return (
    <>
      {draggedItem && (
        <div className="z-999 pointer-events-none fixed inset-0 w-full">
          <PhotoCard
            photo={draggedItem}
            className="absolute"
            style={{
              [i18n.dir(i18n.language) === "rtl" ? "left" : "right"]:
                currentOffset?.x,
              top: currentOffset?.y,
            }}
          />
        </div>
      )}
      <div ref={drop} className="flex min-h-96 flex-row justify-center gap-2">
        {unSelectedPhotos.map((photo) => (
          <DraggablePhotoCard photo={photo} key={photo.id} />
        ))}
        {unSelectedPhotos.length === 0 && t("تم تحديد جميع الصور : )")}
      </div>
    </>
  );
};

export type DraggablePhotoCardProps = PhotoCardProps;
export const DraggablePhotoCard: FC<DraggablePhotoCardProps> = ({ photo }) => {
  const [{ isDragging }, drag, preview] = useDrag(
    () => ({
      type: "photo",
      item: photo,
      collect: (monitor) => ({
        isDragging: !!monitor.isDragging(),
      }),
    }),
    [photo],
  );

  useEffect(() => {
    preview(getEmptyImage(), { captureDraggingState: true });
  }, [preview]);

  return (
    <div ref={drag} className={cn(isDragging && "opacity-0")}>
      <PhotoCard photo={photo} />
    </div>
  );
};
export type PhotoCardProps = {
  photo: Photo;
} & ComponentPropsWithoutRef<"div">;
export const PhotoCard: FC<PhotoCardProps> = ({ photo, ...props }) => {
  const { t } = useTranslation("orders");

  return (
    <Card
      {...props}
      className={cn(
        "flex aspect-[4/5] h-96 flex-col gap-2 rounded-sm p-3",
        props.className,
      )}
    >
      <div className="flex gap-1 [&>*]:h-10 [&>*]:flex-1">
        <Badge variant="default">
          <LabelValue
            label={`${t("الوزن")}:`}
            valueProps={{
              className: cn("text-primary-foreground/80"),
            }}
          >
            {photo.weight}
          </LabelValue>
        </Badge>
        <Badge variant="default">
          <LabelValue
            label={`${t("الطول")}:`}
            valueProps={{
              className: cn("text-primary-foreground/80"),
            }}
          >
            {photo.length}
          </LabelValue>
        </Badge>
        <Badge variant="default">
          <LabelValue
            label={`${t("العرض")}:`}
            valueProps={{
              className: cn("text-primary-foreground/80"),
            }}
          >
            {photo.width}
          </LabelValue>
        </Badge>
      </div>

      <img
        alt=""
        className="h-80 rounded-sm border-2 border-border"
        src={photo.webUrl}
      />
    </Card>
  );
};
export type SubOrdersProps = {};
export const SubOrders: FC<SubOrdersProps> = ({}) => {
  const form = useFormContext<Schema>();
  const { fields, append, prepend, remove, swap, move, insert } = useFieldArray(
    {
      control: form.control,
      keyName: "no",
      name: "subOrders",
    },
  );
  return (
    <>
      {fields.map((subOrder, index) => (
        <SubOrder key={subOrder.no} index={index} />
      ))}
    </>
  );
};
export type SubOrderProps = {
  index: number;
};
export const SubOrder: FC<SubOrderProps> = ({ index }) => {
  const form = useFormContext<Schema>();
  const { fields, append } = useFieldArray({
    control: form.control,
    keyName: "no",
    name: `subOrders.${index}.photos`,
  });
  const { t } = useTranslation();
  const [{ isOver, canDrop }, drop] = useDrop(
    () => ({
      accept: ["photo"],
      canDrop: (photo) =>
        !fields.some((subPhoto) => photo.webUrl === subPhoto.webUrl),
      drop: (photo: Photo) => append(photo),
      collect: (monitor) => ({
        isOver: !!monitor.isOver(),
        canDrop: !!monitor.canDrop(),
      }),
    }),
    [fields, append],
  );
  return (
    <div
      ref={drop}
      className="min-h-96 w-full rounded-sm border-2 border-border p-2"
    >
      <h4 className="text-xl">
        {t("الطلب")} #{index + 1}
      </h4>
      <div className="flex flex-row justify-center gap-2">
        {fields.map((photo) => (
          <DraggablePhotoCard photo={photo} key={photo.id} />
        ))}
      </div>
    </div>
  );
};
