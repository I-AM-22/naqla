part of 'auth_bloc.dart';

class AuthState extends StateObject<AuthState> {
  static String login = "login";
  static String signUp = "signUp";
  static String confirm = "confirm";

  final String phoneNumber;
  AuthState({States? states, String? phoneNumber})
      : phoneNumber = phoneNumber ?? '',
        super([
          InitialState<String>(login),
          InitialState<String>(signUp),
          InitialState<LoginModel>(confirm),
        ], (states) => AuthState(states: states, phoneNumber: phoneNumber), states);

  AuthState copyWith({String? phoneNumber}) => AuthState(phoneNumber: phoneNumber ?? this.phoneNumber, states: states);

  @override
  List<Object?> get props => super.props..addAll([phoneNumber]);
}
