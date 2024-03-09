import { FormInput } from "@/components/ui/form";
import { Text } from "@/components/ui/text";
import z from "@/lib/zod";
import useUserStore from "@/stores/userStore";
import { authControllerConfirm } from "@/swagger/api";
import { ConfirmDto } from "@/swagger/api.schemas";
import { zodResolver } from "@hookform/resolvers/zod";
import { useMutation } from "@tanstack/react-query";
import { Redirect, Stack, useLocalSearchParams, useRouter } from "expo-router";
import { FormProvider, useForm } from "react-hook-form";

import { useTranslation } from "react-i18next";
import { View } from "react-native";
import { Button } from "react-native-paper";

const schema = z.object({
  otp: z.string().length(6),
});
const defaultValues: z.input<typeof schema> = {
  otp: "",
};
export default function Page() {
  const { t } = useTranslation("auth", { keyPrefix: "login" });
  const form = useForm({ defaultValues, resolver: zodResolver(schema) });
  const phone = useLocalSearchParams()["phone"];
  const user = useUserStore();
  const router = useRouter();
  const confirm = useMutation({
    mutationFn: (dto: ConfirmDto) => authControllerConfirm(dto, { phoneConfirm: false }),
  });
  if (!phone || typeof phone !== "string") return <Redirect href={"/auth/login"} />;
  const onSubmit = (data: z.infer<typeof schema>) => {
    confirm.mutate(
      { ...data, phone },
      {
        onSuccess: ({ data }) => {
          user.set({ token: data.token, ...data.user });
          router.push("/");
        },
      }
    );
  };

  return (
    <>
      <Stack.Screen
        options={{
          title: "",
          headerRight: () => (
            <Text variant="titleLarge" style={{ paddingTop: 2 }}>
              {t("title")}
            </Text>
          ),
          headerShadowVisible: false,
          headerShown: true,
          headerBackButtonMenuEnabled: true,
        }}
      />
      <FormProvider {...form}>
        <View style={{ display: "flex", flex: 1, gap: 10, padding: 16, flexDirection: "column" }}>
          <Text style={{ textAlign: "center" }} variant="bodyLarge">
            {t("otp")}
          </Text>
          <FormInput name="otp" />

          <View style={{ flex: 1 }} />
          <Button
            mode="contained"
            onPress={form.handleSubmit(onSubmit)}
            loading={confirm.isPending}
          >
            {t("submit")}
          </Button>
        </View>
      </FormProvider>
    </>
  );
}
