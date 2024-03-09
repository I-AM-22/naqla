import { sm } from "@/utils/ui";
import * as React from "react";
import { Controller, FormProvider, useFormContext } from "react-hook-form";
import { View } from "react-native";
import { HelperText, TextInput, TextInputProps } from "react-native-paper";
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

export { Form, FormInput };
