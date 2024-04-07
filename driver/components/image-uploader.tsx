import { theme } from "@/providers/theme-provider";
import { photosControllerUploadSingle } from "@/services/api";
import { parseResponseError } from "@/utils/apiHelpers";
import { useMutation } from "@tanstack/react-query";
import { Image } from "expo-image";
import * as ImagePicker from "expo-image-picker";

import { ReactNode, useState } from "react";
import { useFormContext } from "react-hook-form";
import { StyleProp, StyleSheet, View, ViewStyle } from "react-native";
import { ActivityIndicator, HelperText, IconButton, TouchableRipple } from "react-native-paper";
import Icon from "react-native-vector-icons/MaterialCommunityIcons";
import { Text } from "./ui/text";
export type ImageUploaderProps = {
  onUpload?: (url: string) => void;
  onRemove?: () => void;
  options?: ImagePicker.ImagePickerOptions;
  label: ReactNode;
  name?: string;
  defaultValue?: string;
  containerStyle?: StyleProp<ViewStyle>;
};

export function ImageUploader({
  onUpload,
  onRemove,
  options,
  label,
  name,
  defaultValue,
  containerStyle,
}: ImageUploaderProps) {
  const form = useFormContext();
  const uploadImage = useMutation({ mutationFn: photosControllerUploadSingle });
  const [image, setImage] = useState<null | string>(
    defaultValue ?? (name ? form.getValues()[name] : null) ?? null
  );
  const pickImage = async () => {
    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      quality: 1,
      ...options,
    });

    if (result.canceled || !result.assets?.[0].uri) return;

    let imageUri = result.assets[0].uri;

    const res = await uploadImage
      .mutateAsync({
        photo: {
          uri: imageUri,
          type: "image/jpeg",
          name: "profile-picture",
        } as unknown as File,
      })
      .catch(parseResponseError({}));

    if (typeof res.data === "string") {
      name && form?.setValue(name, res.data);
      onUpload?.(res.data);
      setImage(res.data);
    }
  };

  return (
    <>
      <View style={[styles.container, containerStyle]}>
        <View style={[styles.input]}>
          <TouchableRipple disabled={!!image} onPress={!image ? pickImage : () => {}}>
            <>
              <Text
                variant="titleMedium"
                style={{ paddingTop: 10, paddingRight: 13, color: theme.colors?.primary }}
              >
                {label}
              </Text>
              <View
                style={{
                  height: 200,
                  position: "relative",
                  paddingBottom: 1,
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                {image && (
                  <IconButton
                    icon={"delete"}
                    style={styles.delete}
                    iconColor="red"
                    mode="contained"
                    size={16}
                    onPress={() => {
                      setImage(null);
                      onRemove?.();
                      name && form?.setValue(name, null);
                    }}
                  />
                )}
                {!image && !uploadImage.isPending && (
                  <Icon name="file-upload-outline" style={{}} size={100} />
                )}
                {uploadImage.isPending && (
                  <ActivityIndicator animating={true} size={50} color={theme.colors?.primary} />
                )}
                {image && (
                  <Image source={{ uri: image }} contentFit="contain" style={styles.image} />
                )}
              </View>
            </>
          </TouchableRipple>
        </View>
        {name && form.formState.errors[name] && (
          <HelperText type="error">{form.formState.errors[name].message?.toString()}</HelperText>
        )}
      </View>
    </>
  );
}
const styles = StyleSheet.create({
  container: {
    display: "flex",
    flexDirection: "column",
    gap: 1,
  },
  input: {
    borderWidth: 1,
    borderRadius: theme.roundness,
    borderColor: theme.colors?.primary,
    display: "flex",
    flexDirection: "column",
    gap: 1,
  },
  button: {
    height: 200,
  },
  delete: {
    position: "absolute",
    top: 3,
    right: 12,
    zIndex: 1,
  },
  image: {
    width: "100%",
    height: "100%",
  },
});
const urlToObject = async (url: string) => {
  const response = await fetch(url);
  // here image is url/location of image
  const blob = await response.blob();
  const file = new File([blob], "image", { type: blob.type });
  return file;
};
