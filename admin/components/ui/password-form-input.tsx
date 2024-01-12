import { Button } from "@/components/ui/button";
import { FormInput, FormInputProps } from "@/components/ui/form-input";
import { Eye, EyeOff } from "lucide-react";
import { FC, useState } from "react";
import { useTranslation } from "react-i18next";
type Props = FormInputProps;
const PasswordFormInput: FC<Props> = ({ ...props }) => {
  const [showPassword, setShowPassword] = useState(false);
  const { t } = useTranslation("common", { keyPrefix: "input" });
  return (
    <FormInput
      {...props}
      label={t("password")}
      type={showPassword ? "text" : "password"}
      onInput={(e) => {
        const input = e.target as HTMLInputElement;
        input.value = input.value.trim();
      }}
      FormItemProps={{
        className: "relative",
        children: (
          <Button
            variant="ghost"
            className="absolute end-1 top-[26px] h-8 w-8"
            type="button"
            size="icon"
            onClick={() => setShowPassword((prev) => !prev)}
          >
            {showPassword ? (
              <EyeOff className="h-4 w-4" />
            ) : (
              <Eye className="h-4 w-4" />
            )}
          </Button>
        ),
      }}
      {...props}
    />
  );
};
export default PasswordFormInput;
