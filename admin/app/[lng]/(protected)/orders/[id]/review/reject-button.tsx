"use client";
import { revalidatePath } from "@/actions/cache";
import { Button, ButtonProps } from "@/components/ui/button";
import {
  Inplace,
  InplaceClose,
  InplaceContent,
  InplaceDisplay,
} from "@/components/ui/in-place";
import LoadingButton from "@/components/ui/loading-button";
import { useMutation } from "@/hooks/use-mutation";
import { useTranslation } from "@/i18n/client";
import { orderControllerCancellation } from "@/service/api";
import { useRouter } from "next/navigation";
import { toast } from "sonner";

export type RejectButtonProps = { orderId: string } & ButtonProps;
export function RejectButton({ orderId, ...props }: RejectButtonProps) {
  const { t } = useTranslation("orders", { keyPrefix: "subOrderCreate" });
  const reject = useMutation(orderControllerCancellation);
  const router = useRouter();
  const handleReject = () => {
    reject.mutate(
      { id: orderId },
      {
        onSuccess: () => {
          toast.success(t("rejectedOrderSuccessfully"));
          revalidatePath("/orders");
          router.replace("/orders");
        },
      },
    );
  };
  return (
    <Inplace className="gap-1">
      <InplaceDisplay>
        <Button variant="destructive" {...props}>
          {t("reject")}
        </Button>
      </InplaceDisplay>
      <InplaceContent>
        <LoadingButton
          isLoading={reject.isPending}
          variant="destructive"
          onClick={handleReject}
        >
          {t("rejectConfirm")}
        </LoadingButton>
      </InplaceContent>
      <InplaceClose>
        <Button>{t("rejectCancel")}</Button>
      </InplaceClose>
    </Inplace>
  );
}
