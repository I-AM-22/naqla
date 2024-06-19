"use client";

import { revalidatePath } from "@/actions/cache";
import { Card } from "@/components/ui/card";
import { Form } from "@/components/ui/form";
import { FormInput } from "@/components/ui/form-input";
import Submit from "@/components/ui/submit";
import { useMutation } from "@/hooks/use-mutation";
import { z } from "@/lib/zod";
import { advantagesControllerCreate } from "@/service/api";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";

const schema = z.object({
  name: z.string().min(1),
  cost: z.coerce.number().nonnegative(),
});
type Schema = z.infer<typeof schema>;
export default function Page() {
  const { t } = useTranslation("car-advantages");
  const form = useForm<z.input<typeof schema>>({
    resolver: zodResolver(schema),
    defaultValues: {
      name: "",
      cost: 0,
    },
  });
  const router = useRouter();
  const add = useMutation(advantagesControllerCreate, form);
  const onSubmit = async (data: Schema) => {
    await add(data, {
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
          <h3 className="text-xl">{t("new")}</h3>
          <div className="flex w-96 max-w-full flex-col">
            <FormInput label={t("name")} name="name" />
            <FormInput label={t("cost")} name="cost" />
            <Submit />
          </div>
        </form>
      </Form>
    </Card>
  );
}
