part of 'profile_bloc.dart';

class ProfileState extends StateObject<ProfileState> {
  static String getProfile = "getProfile";
  static String deleteAccount = "deleteAccount";
  static String editPhoneNumber = "editPhoneNumber";
  static String uploadSinglePhoto = "uploadSinglePhoto";
  static String editPersonalInfo = "editPersonalInfo";
  static String pickImage = "pickImage";
  static String confirm = "confirm";

  final String phone;
  ProfileState({States? states, String? phone})
      : phone = phone ?? '',
        super([
          InitialState<DriverModel>(getProfile),
          InitialState<void>(deleteAccount),
          InitialState<DriverModel>(editPhoneNumber),
          InitialState<String>(uploadSinglePhoto),
          InitialState<DriverModel>(editPersonalInfo),
          InitialState<File?>(pickImage),
          InitialState<LoginModel>(confirm),
        ], (states) => ProfileState(states: states, phone: phone), states);

  ProfileState copyWith({String? phone}) => ProfileState(phone: phone ?? this.phone, states: states);

  @override
  List<Object?> get props => super.props..addAll([phone]);
}
