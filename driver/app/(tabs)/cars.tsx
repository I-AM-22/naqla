import { Text } from "@/components/ui/text";
import { ASPECT_RATIOS } from "@/constants/aspect-ratio";
import { carQueries } from "@/services/car-queries";
import { Image } from "expo-image";
import { Link } from "expo-router";
import { useTranslation } from "react-i18next";
import { FlatList, RefreshControl, StyleSheet, View } from "react-native";
import { FAB, Surface } from "react-native-paper";
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
    overflow: "hidden",
    marginBottom: 8,
  },
  carImage: {
    flex: 1,
    aspectRatio: ASPECT_RATIOS.CAR[0] / ASPECT_RATIOS.CAR[1],
  },
  carInfo: {
    flex: 1.2,
  },
});
export default function Page() {
  const query = carQueries.useMine();
  const { t } = useTranslation("cars");

  return (
    <View style={{ position: "relative", flex: 1 }}>
      <FlatList
        data={query.data?.data ?? []}
        style={styles.list}
        refreshControl={<RefreshControl refreshing={query.isFetching} onRefresh={query.refetch} />}
        renderItem={({ item: car }) => (
          <Surface elevation={1} mode="elevated" style={styles.car}>
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
        )}
      />
      <Link asChild href="/cars/new">
        <FAB icon="plus" style={styles.fab} />
      </Link>
    </View>
  );
}
