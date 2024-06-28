"use client";

import { revalidatePath } from "@/actions/cache";
import { LabelValue } from "@/components/composites/label-value";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Form } from "@/components/ui/form";
import { FormInput } from "@/components/ui/form-input";
import Submit from "@/components/ui/submit";
import { useMutation } from "@/hooks/use-mutation";
import { cn, priceFormatter } from "@/lib/utils";
import { z } from "@/lib/zod";
import { driversControllerWithdraw } from "@/service/api";
import { Driver, UpdateWalletDto } from "@/service/api.schemas";
import { zodResolver } from "@hookform/resolvers/zod";
import { ChevronsLeft } from "lucide-react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { toast } from "sonner";

const schema = (allowedAmount: number) =>
  z.object({
    cost: z.coerce.number().positive().max(allowedAmount),
  });
type Schema = z.infer<ReturnType<typeof schema>>;
export type WithdrawFormProps = { driver: Driver };
export function WithdrawForm({ driver }: WithdrawFormProps) {
  const { t, i18n } = useTranslation("drivers");
  const form = useForm<z.input<ReturnType<typeof schema>>>({
    // @ts-ignore
    resolver: zodResolver(schema(driver.wallet.available)),
    defaultValues: {
      cost: 0,
    },
  });
  const router = useRouter();
  const withdraw = useMutation(
    (dto: UpdateWalletDto) => driversControllerWithdraw({ id: driver.id }, dto),
    form,
  );
  const onSubmit = async (data: Schema) => {
    await withdraw.mutate(data, {
      onSuccess: () => {
        revalidatePath(`/drivers/${driver.id}/withdraw`);
        revalidatePath(`/drivers`);
        router.push("/drivers");
        toast.success(t("withdrawSuccess", { amount: data.cost }));
      },
    });
  };
  return (
    <Card className="mx-auto mt-5 p-4">
      <Form {...form}>
        <form
          className="flex flex-col gap-3 "
          onSubmit={form.handleSubmit(onSubmit)}
        >
          <h3 className="text-xl">{t("withdraw")}</h3>
          <div className="flex w-96 max-w-full flex-col">
            <LabelValue
              label={t`name`}
              labelProps={{ className: cn("w-20") }}
            >{`${driver.firstName} ${driver.lastName}`}</LabelValue>
            <LabelValue label={t`phone`} labelProps={{ className: cn("w-20") }}>
              {driver.phone}
            </LabelValue>
            <h4 className=" mt-2 font-bold">{t("wallet")}</h4>
            <LabelValue
              className="ms-2"
              label={t("walletAvailable")}
              labelProps={{ className: cn("w-16") }}
            >
              {/* @ts-ignore */}
              {priceFormatter(driver.wallet.available, i18n.language)}
            </LabelValue>
            <LabelValue
              className="ms-2"
              label={t("walletPending")}
              labelProps={{ className: cn("w-16") }}
            >
              {priceFormatter(driver.wallet.pending, i18n.language)}
            </LabelValue>
            <LabelValue
              className="ms-2"
              label={t("walletTotal")}
              labelProps={{ className: cn("w-16") }}
            >
              {priceFormatter(driver.wallet.total, i18n.language)}
            </LabelValue>
            <FormInput
              className="my-2"
              label={
                <div className="flex items-center gap-1">
                  {t("withdrawAvailable")}
                  <Button
                    size={"icon"}
                    onClick={() => {
                      // @ts-ignore
                      form.setValue("cost", driver.wallet.available);
                      form.trigger("cost");
                    }}
                    className="h-6 w-6"
                    variant={"ghost"}
                  >
                    <ChevronsLeft />
                  </Button>
                </div>
              }
              name="cost"
            />
            <Submit>{t("withdrawAvailable")}</Submit>
          </div>
        </form>
      </Form>
    </Card>
  );
}
