import { OrderPhoto } from "@/service/api.schemas";
import { FC } from "react";
import { useDragLayer, useDrop } from "react-dnd";
import { useFormContext, useWatch } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { DraggablePhotoCard, PhotoCard } from "./photo-card";
import { Photo, Schema } from "./sub-orders-form";

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
  const { i18n, t } = useTranslation("orders", {
    keyPrefix: "subOrderCreate",
  });
  const [, drop] = useDrop(
    () => ({
      accept: ["photo"],
      canDrop: (photo) => {
        return subOrders.some((sub) =>
          sub.photos.some((subPhoto) => photo.webUrl === subPhoto.webUrl),
        );
      },
      drop: (photo: Photo) => {
        setValue(
          "subOrders",
          getValues().subOrders.map((sub) => ({
            ...sub,
            weight: sub.photos
              .filter((subPhoto) => subPhoto.webUrl !== photo.webUrl)
              .reduce((sum, ph) => sum + ph.weight, 0),
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
              left: currentOffset?.x,
              top: currentOffset?.y,
            }}
          />
        </div>
      )}
      <div
        ref={drop}
        className="flex min-h-96 flex-row flex-wrap justify-center gap-2"
      >
        {unSelectedPhotos.map((photo) => (
          <DraggablePhotoCard photo={photo} key={photo.id} />
        ))}
        {unSelectedPhotos.length === 0 && t("allFilesSelected")}
      </div>
    </>
  );
};
