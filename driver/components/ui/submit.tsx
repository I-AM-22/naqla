import { FC } from "react";
import { useFormContext } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { KeyboardAvoidingView } from "react-native";
import { Button, ButtonProps } from "react-native-paper";
import { Loading } from "./loading";

export type SubmitProps = ButtonProps;
export const Submit: FC<SubmitProps> = (props) => {
  const { t } = useTranslation();
  const form = useFormContext();

  return (
    <KeyboardAvoidingView>
      <Button
        mode="contained"
        {...props}
        icon={(form.formState.isSubmitting && (() => <Loading color={"white"} />)) || props.icon}
      >
        {props.children ?? t("submit")}
      </Button>
    </KeyboardAvoidingView>
  );
};
