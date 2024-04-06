import { FormInput } from "@/components/ui/form";
import { Text } from "@/components/ui/text";
import { phoneRegex } from "@/constants/regex";
import i18n from "@/lib/i18next";
import z from "@/lib/zod";
import { authDriverControllerSignup } from "@/services/api";
import { parseResponseError } from "@/utils/apiHelpers";
import { zodResolver } from "@hookform/resolvers/zod";
import { useMutation } from "@tanstack/react-query";
import { Stack, useRouter } from "expo-router";
import { FormProvider, useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { View } from "react-native";
import { Button } from "react-native-paper";

const schema = z.object({
  phone: z
    .string()
    .min(1)
    .regex(phoneRegex, { message: i18n.t("validation:phoneNumber") }),
  firstName: z.string().min(1),
  lastName: z.string().min(1),
});
const defaultValues: z.input<typeof schema> = {
  firstName: "",
  lastName: "",
  phone: "",
};
export default function Page() {
  const { t } = useTranslation("auth", { keyPrefix: "signup" });
  const form = useForm({ defaultValues, resolver: zodResolver(schema) });
  const router = useRouter();
  const signup = useMutation({
    mutationFn: authDriverControllerSignup,
  });
  const onSubmit = async (data: z.infer<typeof schema>) => {
    await signup.mutateAsync(data, {
      onSuccess: () => {
        router.push({ pathname: "/auth/signup/otp", params: { phone: data.phone } });
      },
      onError: parseResponseError({ setFormError: form.setError }),
    });
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
          <FormInput name="firstName" label={t("firstName")} />
          <FormInput name="lastName" label={t("lastName")} />
          <FormInput
            name="phone"
            label={t("phone")}
            inputMode="numeric"
            textContentType="telephoneNumber"
          />
          <View style={{ flex: 1 }} />
          <Button
            mode="contained"
            loading={form.formState.isSubmitting}
            onPress={form.handleSubmit(onSubmit)}
          >
            {t("next")}
          </Button>
        </View>
      </FormProvider>
    </>
  );
}
