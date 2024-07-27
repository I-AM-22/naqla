"use client";

import { revalidatePath } from "@/actions/cache";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import Submit from "@/components/ui/submit";
import { useMutation } from "@/hooks/use-mutation";
import { z } from "@/lib/zod";
import { settingsControllerUpdate } from "@/service/api";
import { Setting, UpdateSettingDto } from "@/service/api.schemas";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { toast } from "sonner";

const schema = z.object({
  cost: z.coerce.number().positive(),
});
type Schema = z.infer<typeof schema>;
export type SetttingFormProps = { setting: Setting };
export function SettingForm({ setting }: SetttingFormProps) {
  const { t, i18n } = useTranslation("settings");
  const form = useForm<z.input<typeof schema>>({
    resolver: zodResolver(schema),
    values: {
      cost: setting.cost,
    },
  });
  const updateSetting = useMutation(
    (dto: UpdateSettingDto) =>
      settingsControllerUpdate({ id: setting.id }, dto),
    form,
  );
  const onSubmit = async (data: Schema) => {
    if (data.cost === setting.cost) return;
    await updateSetting.mutate(data, {
      onSuccess: async () => {
        await revalidatePath(`/settings`);
        toast.success(t("settingUpdated"));
      },
    });
  };
  return (
    <Form {...form}>
      <form
        className="flex w-full flex-row flex-wrap justify-between gap-x-1"
        onSubmit={form.handleSubmit(onSubmit)}
      >
        <FormField
          name={"cost"}
          render={({ field }) => {
            return (
              <FormItem>
                <FormLabel>{t(setting.name)}</FormLabel>
                <div className="flex flex-row flex-wrap items-center gap-x-2">
                  <FormControl className="w-[300px] max-w-fit">
                    <Input {...field} />
                  </FormControl>
                  {form.watch("cost") != setting.cost && (
                    <Submit>{t("save")}</Submit>
                  )}
                </div>
                <FormDescription />
                <FormMessage />
              </FormItem>
            );
          }}
        />
      </form>
    </Form>
  );
}
