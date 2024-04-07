import { createQueryKeys } from "@lukemorales/query-key-factory";
import { useMutation, useQuery } from "@tanstack/react-query";
import {
  advantagesControllerFindAll,
  carControllerCreate,
  carControllerDelete,
  carControllerFindMine,
  carControllerFindOne,
} from "./api";
type CarDetailsParameters = Parameters<typeof carControllerFindOne>;
export const carKeys = createQueryKeys("car", {
  advantages: { queryFn: advantagesControllerFindAll, queryKey: [""] },
  mine: { queryFn: carControllerFindMine, queryKey: [""] },
  details: (...params: CarDetailsParameters) => ({
    queryFn: carControllerFindOne(...params),
    queryKey: [...params],
  }),
});

export const carQueries = {
  useAdvantages: () => useQuery({ ...carKeys.advantages, staleTime: Infinity }),
  useMine: () => useQuery({ ...carKeys.mine }),
  useDetails: (...params: CarDetailsParameters) => useQuery({ ...carKeys.details(...params) }),

  useCreate: () =>
    useMutation({
      mutationFn: carControllerCreate,
    }),
  useRemove: () => useMutation({ mutationFn: carControllerDelete }),
};
