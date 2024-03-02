abstract class EndPoints {
  EndPoints._();

  static const String baseUrl = 'http://192.168.1.104:5500';
  static const auth = Auth();
  static const profile = Profile();
}

class Auth {
  const Auth();
  final login = '/api/v1/auth/login';
  final signup = '/api/v1/auth/signup';
  final confirm = '/api/v1/auth/confirm';
  final forgotPassword = '/api/v1/auth/forgotPassword';
  final resetPassword = '/api/v1/auth/resetPassword';
  final updateMyPassword = '/api/v1/auth/updateMyPassword';
}

class Profile {
  const Profile();

  final personalInfo = '/api/v1/users/me';
}
