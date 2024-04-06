import { sm } from "@/utils/ui";
import * as React from "react";
import { Controller, FormProvider, useFormContext, useWatch } from "react-hook-form";
import { View } from "react-native";
import { CheckboxProps, HelperText, TextInput, TextInputProps } from "react-native-paper";
const Form = FormProvider;

const FormInput = ({ name, ...props }: TextInputProps & { name: string }) => {
  const form = useFormContext();
  return (
    <Controller
      control={form.control}
      rules={{
        required: true,
      }}
      render={({ field: { onChange, onBlur, value } }) => (
        <View>
          <TextInput
            mode="outlined"
            onBlur={onBlur}
            onChangeText={onChange}
            value={value}
            {...props}
            style={sm(props.style)}
            placeholderTextColor={"#0006"}
          />
          {form.formState.errors[name] && (
            <HelperText type="error">{form.formState.errors[name]?.message?.toString()}</HelperText>
          )}
        </View>
      )}
      name={name}
    />
  );
};

import { Checkbox } from "react-native-paper";
import { Text } from "./text";
const FormCheckbox = ({
  name,
  label,
  ...props
}: Omit<CheckboxProps, "status"> & { label?: string; name: string }) => {
  const form = useFormContext();
  const isChecked = useWatch({ name }) as boolean;
  return (
    <Controller
      control={form.control}
      rules={{
        required: true,
      }}
      render={({ field: { onChange, onBlur, value } }) => (
        <View>
          <View style={{ display: "flex", flexDirection: "row", gap: 6, alignItems: "center" }}>
            <Checkbox
              onPress={() => form.setValue(name, !isChecked)}
              status={isChecked ? "checked" : "unchecked"}
              {...props}
            />
            <Text>{label}</Text>
          </View>
          {form.formState.errors[name] && (
            <HelperText type="error">{form.formState.errors[name]?.message?.toString()}</HelperText>
          )}
        </View>
      )}
      name={name}
    />
  );
};

export { Form, FormCheckbox, FormInput };
