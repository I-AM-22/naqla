"use client";

import { revalidatePath } from "@/actions/cache";
import { Card } from "@/components/ui/card";
import { Form } from "@/components/ui/form";
import { FormInput } from "@/components/ui/form-input";
import Submit from "@/components/ui/submit";
import { useMutation } from "@/hooks/use-mutation";
import { z } from "@/lib/zod";
import { advantagesControllerUpdate } from "@/service/api";
import { Advantage, UpdateAdvantageDto } from "@/service/api.schemas";
import { getDirtyValues } from "@/utils/react-form-hook";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";

const schema = z.object({
  name: z.string().min(1),
  cost: z.coerce.number().nonnegative(),
});
type Schema = z.infer<typeof schema>;
export type EditFormProps = { advantage: Advantage };
export function EditForm({ advantage }: EditFormProps) {
  const { t } = useTranslation("car-advantages");
  const form = useForm<z.input<typeof schema>>({
    resolver: zodResolver(schema),
    values: advantage,
  });
  const router = useRouter();
  const update = useMutation(
    (dto: UpdateAdvantageDto) =>
      advantagesControllerUpdate({ id: advantage.id }, dto),
    form,
  );
  const onSubmit = async (data: Schema) => {
    await update.mutate(getDirtyValues(form.formState.dirtyFields, data), {
      onSuccess: () => {
        revalidatePath("/car-advantages");
        router.push("/car-advantages");
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
          <h3 className="text-xl">{t("edit")}</h3>
          <div className="flex w-96 max-w-full flex-col">
            <FormInput label={t("name")} name="name" />
            <FormInput label={t("cost")} name="cost" />
            <Submit>{t("save")}</Submit>
          </div>
        </form>
      </Form>
    </Card>
  );
}
