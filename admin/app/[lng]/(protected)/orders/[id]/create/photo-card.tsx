import { LabelValue } from "@/components/composites/label-value";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import { useTranslation } from "@/i18n/client";
import { cn } from "@/lib/utils";
import { ComponentPropsWithoutRef, FC, useEffect } from "react";
import { useDrag } from "react-dnd";
import { getEmptyImage } from "react-dnd-html5-backend";
import { Photo } from "./sub-orders-form";
export type PhotoCardProps = {
  photo: Photo;
} & ComponentPropsWithoutRef<"div">;
export const PhotoCard: FC<PhotoCardProps> = ({ photo, ...props }) => {
  const { t } = useTranslation("orders", {
    keyPrefix: "subOrderCreate",
  });

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
            label={`${t("weight")}:`}
            valueProps={{
              className: cn("text-primary-foreground/80"),
            }}
          >
            {photo.weight}
          </LabelValue>
        </Badge>
        <Badge variant="default">
          <LabelValue
            label={`${t("length")}:`}
            valueProps={{
              className: cn("text-primary-foreground/80"),
            }}
          >
            {photo.length}
          </LabelValue>
        </Badge>
        <Badge variant="default">
          <LabelValue
            label={`${t("width")}:`}
            valueProps={{
              className: cn("text-primary-foreground/80"),
            }}
          >
            {photo.width}
          </LabelValue>
        </Badge>
      </div>
      <a href={photo.webUrl} target="_blank">
        <img
          alt=""
          className="h-80 rounded-sm border-2 border-border object-contain"
          src={photo.webUrl}
        />
      </a>
    </Card>
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
