import { ImageUploader } from "@/components/image-uploader";
import { FormCheckbox, FormInput } from "@/components/ui/form";
import { Submit } from "@/components/ui/submit";
import { Text } from "@/components/ui/text";
import { ASPECT_RATIOS } from "@/constants/aspect-ratio";
import z from "@/lib/zod";
import { carKeys, carQueries } from "@/services/car-queries";
import { parseResponseError } from "@/utils/apiHelpers";
import { PriceFormatter } from "@/utils/numeric-format";
import { zodResolver } from "@hookform/resolvers/zod";
import { useQueryClient } from "@tanstack/react-query";
import { Stack, useRouter } from "expo-router";
import { FormProvider, useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { ScrollView, View } from "react-native";
const schema = z.object({
  model: z.string().min(1),
  brand: z.string().min(1),
  color: z.string().min(1),
  photo: z.string().min(1),
  advantages: z.array(z.record(z.string(), z.boolean().optional())),
});
const defaultValues: z.input<typeof schema> = {
  advantages: [],
  brand: "",
  color: "",
  model: "",
  photo: "",
};
const priceFormat = PriceFormatter();
export default function Page() {
  const { t } = useTranslation("cars");
  const form = useForm({ defaultValues, resolver: zodResolver(schema) });
  const router = useRouter();
  const advantagesQuery = carQueries.useAdvantages();
  const queryClient = useQueryClient();
  const createCar = carQueries.useCreate();
  const onSubmit = async (data: z.infer<typeof schema>) => {
    const advantages = data.advantages
      .map((a) => Object.entries(a))
      .filter((a) => a[0]?.[1])
      .map((a) => a[0][0]);
    await createCar.mutateAsync(
      { ...data, advantages },
      {
        onSuccess: (car) => {
          queryClient.setQueryData(carKeys.details({ id: car.data.id }).queryKey, car.data);
          queryClient.invalidateQueries(carKeys.mine);
          router.replace("/cars");
        },
        onError: parseResponseError({ setFormError: form.setError }),
      }
    );
  };

  return (
    <>
      <Stack.Screen
        options={{
          title: "",
          headerRight: () => <Text variant="titleLarge">{t("newTitle")}</Text>,
        }}
      />
      <FormProvider {...form}>
        <ScrollView
          style={{
            display: "flex",
            flexGrow: 1,
            gap: 10,
            padding: 16,
            flexDirection: "column",
          }}
        >
          <FormInput name="model" label={t("model")} placeholder={t("modelPlaceholder")} />
          <FormInput name="brand" label={t("brand")} placeholder={t("brandPlaceholder")} />
          <FormInput name="color" label={t("color")} placeholder={t("colorPlaceholder")} />
          <ImageUploader
            label={t("photo")}
            name="photo"
            options={{ aspect: ASPECT_RATIOS.CAR }}
            containerStyle={{ marginVertical: 8 }}
          />
          <View style={{ flex: 1 }} />
          <Text variant="titleMedium">{t("advantages")}</Text>
          {advantagesQuery.data?.data.map((advantage, index) => (
            <FormCheckbox
              key={advantage.id}
              name={`advantages.${index}.${advantage.id}`}
              label={`${advantage.name} (${priceFormat(advantage.cost)} )`}
            />
          ))}
          <Submit style={{ marginTop: 8, marginBottom: 20 }} onPress={form.handleSubmit(onSubmit)}>
            {t("submit")}
          </Submit>
        </ScrollView>
      </FormProvider>
    </>
  );
}
