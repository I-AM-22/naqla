part of 'profile_bloc.dart';

class ProfileState extends StateObject<ProfileState> {
  static String getPersonalInfo = "getPersonalInfo";
  static String pickImage = "pickImage";
  static String uploadSinglePhoto = "uploadSinglePhoto";
  static String editPersonalInfo = "editPersonalInfo";
  static String editPhoneNumber = "editPhoneNumber";
  static String deleteAccount = "deleteAccount";
  static String confirm = "confirm";

  ProfileState([States? states])
      : super([
          InitialState<User>(getPersonalInfo),
          InitialState<File?>(pickImage),
          InitialState<String>(uploadSinglePhoto),
          InitialState<User>(editPhoneNumber),
          InitialState<String>(editPersonalInfo),
          InitialState(deleteAccount),
          InitialState<AuthModel>(confirm),
        ], (states) => ProfileState(states), states);
}
