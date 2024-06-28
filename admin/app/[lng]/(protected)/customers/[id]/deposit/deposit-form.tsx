"use client";

import { revalidatePath } from "@/actions/cache";
import { LabelValue } from "@/components/composites/label-value";
import { Card } from "@/components/ui/card";
import { Form } from "@/components/ui/form";
import { FormInput } from "@/components/ui/form-input";
import Submit from "@/components/ui/submit";
import { useMutation } from "@/hooks/use-mutation";
import { cn, priceFormatter } from "@/lib/utils";
import { z } from "@/lib/zod";
import { usersControllerDeposit } from "@/service/api";
import { UpdateWalletDto, User } from "@/service/api.schemas";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { toast } from "sonner";

const schema = z.object({
  cost: z.coerce.number().positive(),
});
type Schema = z.infer<typeof schema>;
export type DepositFormProps = { customer: User };
export function DepositForm({ customer }: DepositFormProps) {
  const { t, i18n } = useTranslation("customers");
  const form = useForm<z.input<typeof schema>>({
    resolver: zodResolver(schema),
    defaultValues: {
      cost: 0,
    },
  });
  const router = useRouter();
  const deposit = useMutation(
    (dto: UpdateWalletDto) => usersControllerDeposit({ id: customer.id }, dto),
    form,
  );
  const onSubmit = async (data: Schema) => {
    await deposit.mutate(data, {
      onSuccess: async () => {
        await revalidatePath(`/customers`);
        await revalidatePath(`/customers/${customer.id}/deposit`);
        toast.success(t("depositSuccess", { amount: data.cost }));
        router.push("/customers");
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
          <h3 className="text-xl">{t("deposit")}</h3>
          <div className="flex w-96 max-w-full flex-col">
            <LabelValue
              label={t`name`}
              labelProps={{ className: cn("w-20") }}
            >{`${customer.firstName} ${customer.lastName}`}</LabelValue>
            <LabelValue label={t`phone`} labelProps={{ className: cn("w-20") }}>
              {customer.phone}
            </LabelValue>
            <h4 className=" mt-2 font-bold">{t("wallet")}</h4>
            <LabelValue
              className="ms-2"
              label={t("walletAvailable")}
              labelProps={{ className: cn("w-16") }}
            >
              {/* @ts-ignore */}
              {priceFormatter(customer.wallet.available, i18n.language)}
            </LabelValue>
            <LabelValue
              className="ms-2"
              label={t("walletPending")}
              labelProps={{ className: cn("w-16") }}
            >
              {priceFormatter(customer.wallet.pending, i18n.language)}
            </LabelValue>
            <LabelValue
              className="ms-2"
              label={t("walletTotal")}
              labelProps={{ className: cn("w-16") }}
            >
              {priceFormatter(customer.wallet.total, i18n.language)}
            </LabelValue>
            <FormInput
              className="my-2"
              label={t("depositAvailable")}
              name="cost"
            />
            <Submit>{t("depositAvailable")}</Submit>
          </div>
        </form>
      </Form>
    </Card>
  );
}
