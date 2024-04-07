import { NoData } from "@/components/ui/feedback";
import { Loading } from "@/components/ui/loading";
import { Text } from "@/components/ui/text";
import { ASPECT_RATIOS } from "@/constants/aspect-ratio";
import { toast } from "@/lib/toast";
import { Car } from "@/services/api.schemas";
import { carKeys, carQueries } from "@/services/car-queries";
import { parseResponseError } from "@/utils/apiHelpers";
import { useQueryClient } from "@tanstack/react-query";
import { Image } from "expo-image";
import { Link } from "expo-router";
import { FC, useState } from "react";
import { useTranslation } from "react-i18next";
import { FlatList, RefreshControl, StyleSheet, View } from "react-native";
import { FAB, IconButton, Menu, Surface } from "react-native-paper";
import Icon from "react-native-vector-icons/Entypo";
const styles = StyleSheet.create({
  fab: {
    position: "absolute",
    margin: 16,
    left: 0,
    bottom: 0,
  },
  list: {
    padding: 8,
  },
  car: {
    borderRadius: 5,
    display: "flex",
    flexDirection: "row",
    gap: 8,
    overflow: "hidden",
    marginBottom: 8,
    position: "relative",
  },
  carImage: {
    flex: 1,
    aspectRatio: ASPECT_RATIOS.CAR[0] / ASPECT_RATIOS.CAR[1],
  },
  carInfo: {
    flex: 1.2,
  },
  options: {
    position: "absolute",
    top: 0,
    zIndex: 10,
    right: 0,
  },
});
export default function Page() {
  const query = carQueries.useMine();
  return (
    <View style={{ flex: 1 }}>
      {query.isSuccess && query.data.data.length === 0 && <NoData />}
      <FlatList
        data={query.data?.data ?? []}
        style={styles.list}
        refreshControl={<RefreshControl refreshing={query.isFetching} onRefresh={query.refetch} />}
        renderItem={({ item: car }) => <CarCard car={car} />}
      />
      <Link asChild href="/cars/new">
        <FAB icon="plus" style={styles.fab} />
      </Link>
    </View>
  );
}
export type CarCardProps = { car: Car };
export const CarCard: FC<CarCardProps> = ({ car }) => {
  const { t } = useTranslation("cars");
  const removeCar = carQueries.useRemove();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const queryClient = useQueryClient();
  const handleRemove = () => {
    removeCar.mutate(
      { id: car.id },
      {
        onError: parseResponseError({}),
        onSuccess: () => {
          toast(t("removeSuccess"));
          queryClient.removeQueries({ queryKey: carKeys.details({ id: car.id }).queryKey });
          queryClient.invalidateQueries(carKeys.mine);
        },
      }
    );
  };
  return (
    <Surface elevation={1} mode="elevated" style={styles.car}>
      <View style={styles.options}>
        <Menu
          visible={isMenuOpen}
          onDismiss={() => setIsMenuOpen(false)}
          anchor={
            <IconButton
              onPress={() => setIsMenuOpen(true)}
              icon={() => <Icon name="dots-three-vertical" size={16} />}
            />
          }
        >
          <Menu.Item
            leadingIcon={() => <Icon name="trash" size={16} />}
            trailingIcon={() => removeCar.isPending && <Loading />}
            onPress={handleRemove}
            title={t("remove")}
          />
        </Menu>
      </View>
      <Image
        source={{ uri: car.photo.mobileUrl }}
        placeholder={car.photo.blurHash}
        style={styles.carImage}
      />
      <View style={styles.carInfo}>
        <Text>
          {t("model")}: {car.model}
        </Text>
        <Text>
          {t("brand")}: {car.brand}
        </Text>
        <Text>
          {t("color")}: {car.color}
        </Text>
      </View>
    </Surface>
  );
};
