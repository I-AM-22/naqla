part of 'profile_bloc.dart';

class ProfileState {
  static int getPersonalInfo = 0;
  static int pickImage = 1;
  static int uploadSinglePhoto = 2;
  static int editPersonalInfo = 3;

  static Map<int, CommonState> get iniState => {
        getPersonalInfo: const InitialState<User>(),
        pickImage: const InitialState<File?>(),
        uploadSinglePhoto: const InitialState<String>(),
        editPersonalInfo: const InitialState<User>(),
      };
}
