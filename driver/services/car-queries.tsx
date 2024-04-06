import { createQueryKeys } from "@lukemorales/query-key-factory";
import { useQuery } from "@tanstack/react-query";
import { advantagesControllerFindAll, carControllerFindMine, carControllerFindOne } from "./api";
type CarDetailsParameters = Parameters<typeof carControllerFindOne>;
export const keys = createQueryKeys("car", {
  advantages: { queryFn: advantagesControllerFindAll, queryKey: [""] },
  mine: { queryFn: carControllerFindMine, queryKey: [""] },
  details: (...params: CarDetailsParameters) => ({
    queryFn: carControllerFindOne(...params),
    queryKey: [...params],
  }),
});

export const carQueries = {
  useAdvantages: () => useQuery({ ...keys.advantages, staleTime: Infinity }),
  useMine: () => useQuery({ ...keys.mine }),
  useDetails: (...params: CarDetailsParameters) => useQuery({ ...keys.details(...params) }),
};
