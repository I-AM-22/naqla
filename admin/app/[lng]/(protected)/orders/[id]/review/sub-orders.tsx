import { Button } from "@/components/ui/button";
import { FormInput } from "@/components/ui/form-input";
import { useTranslation } from "@/i18n/client";
import { OrderPhoto } from "@/service/api.schemas";
import { ArrowRightSquare, Trash } from "lucide-react";
import { FC } from "react";
import { useDrop } from "react-dnd";
import { useFieldArray, useFormContext } from "react-hook-form";
import { DraggablePhotoCard } from "./photo-card";
import { Photo, Schema } from "./sub-orders-form";

export type SubOrdersProps = { photos: OrderPhoto[] };
export const SubOrders: FC<SubOrdersProps> = ({ photos }) => {
  const { t } = useTranslation("orders", {
    keyPrefix: "subOrderCreate",
  });
  const form = useFormContext<Schema>();
  const { fields, append, remove } = useFieldArray({
    control: form.control,
    keyName: "no",
    name: "subOrders",
  });
  return (
    <>
      <Button
        onClick={() => append({ photos: [], weight: 0 })}
        variant={"outline"}
      >
        {t("addSubOrder")} +
      </Button>
      <div className="flex flex-row flex-wrap gap-1">
        {fields.map((subOrder, index) => (
          <SubOrder
            photos={photos}
            key={subOrder.no}
            index={index}
            onRemove={() => remove(index)}
          />
        ))}
      </div>
    </>
  );
};
export type SubOrderProps = {
  index: number;
  onRemove: () => void;
  photos: OrderPhoto[];
};
export const SubOrder: FC<SubOrderProps> = ({ index, onRemove, photos }) => {
  const form = useFormContext<Schema>();
  const { fields, append } = useFieldArray({
    control: form.control,
    keyName: "no",
    name: `subOrders.${index}.photos`,
  });
  const { t } = useTranslation("orders", {
    keyPrefix: "subOrderCreate",
  });
  const [, drop] = useDrop(
    () => ({
      accept: ["photo"],
      canDrop: (photo) =>
        !fields.some((subPhoto) => photo.webUrl === subPhoto.webUrl),
      drop: (photo: Photo) => {
        form.setValue(
          `subOrders`,
          form.getValues().subOrders.map((sub) => ({
            ...sub,
            photos: sub.photos.filter((subPhoto) => photo.id !== subPhoto.id),
          })),
        );
        form.clearErrors("subOrders");
        append(photo);
        form.setValue(
          "subOrders",
          form.getValues().subOrders.map((sub) => ({
            ...sub,
            weight: sub.photos.reduce((sum, ph) => sum + ph.weight, 0),
          })),
        );
      },
      collect: (monitor) => ({
        isOver: !!monitor.isOver(),
        canDrop: !!monitor.canDrop(),
      }),
    }),
    [fields, append, form.getValues, form.setValue, index],
  );
  return (
    <div
      ref={drop}
      className="min-h-96 flex-1 rounded-sm border-2 border-border p-2"
    >
      <div className="flex flex-wrap items-center gap-2">
        <h4 className="text-xl font-semibold">
          {t("subOrder")} #{index + 1}
        </h4>
        <FormInput
          FormItemProps={{ className: "flex items-center gap-3" }}
          FormControlProps={{ className: "w-20" }}
          inputMode="numeric"
          label={t("estimatedWeight")}
          name={`subOrders.${index}.weight`}
        />
        <Button
          className="ms-auto"
          variant={"outline"}
          size={"icon"}
          onClick={() => {
            form.setValue(
              "subOrders",
              form.getValues().subOrders.map((_, i) =>
                i === index
                  ? {
                      photos: [...photos],
                      weight: photos.reduce((sum, ph) => sum + ph.weight, 0),
                    }
                  : { photos: [], weight: 0 },
              ),
            );
          }}
        >
          <ArrowRightSquare className="text-green-400 rtl:-scale-100" />
        </Button>
        <Button variant={"outline"} size={"icon"} onClick={onRemove}>
          <Trash className="text-destructive" />
        </Button>
      </div>

      <p className="text-destructive">
        {form.formState.errors.subOrders?.[index]?.photos?.message}
      </p>

      <div className="mt-3 flex flex-row flex-wrap justify-center gap-2">
        {fields.map((photo) => (
          <DraggablePhotoCard photo={photo} key={photo.id} />
        ))}
      </div>
    </div>
  );
};
