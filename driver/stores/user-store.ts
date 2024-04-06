import { createUseStore } from "@/lib/zustand";
import { User as UserDto } from "@/services/api.schemas";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { createJSONStorage, devtools, persist } from "zustand/middleware";
import { immer } from "zustand/middleware/immer";
import { createStore } from "zustand/vanilla";
export type User = {
  token: string;
} & UserDto;
export type UserState = {
  user: User | null;
  set: (user: User) => void;
  isAuthed: boolean;
  clear: () => void;
};

export const userStore = createStore<UserState>()(
  devtools(
    persist(
      immer((set) => ({
        isAuthed: false,
        user: null,
        clear: () => set({ user: null, isAuthed: false }),
        set: (user) => {
          set({ user, isAuthed: true });
        },
      })),
      {
        name: "user",
        storage: createJSONStorage(() => AsyncStorage),
        merge: (persist, currentState) => {
          const persistState = persist as Partial<UserState>;
          currentState.isAuthed = persistState.isAuthed ?? currentState.isAuthed;
          currentState.user = persistState.user ?? currentState.user;
          return currentState;
        },
      }
    ),
    { name: "devtools", store: "user" }
  )
);

const useUserStore = createUseStore(userStore);
export default useUserStore;
