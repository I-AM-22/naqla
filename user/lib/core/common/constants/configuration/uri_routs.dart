abstract class EndPoints {
  EndPoints._();

  static const String baseUrl = 'http://192.168.1.102:3000/api/v1/';
  static const auth = Auth();
}

class Auth {
  const Auth();
  final login = '/users/login';
  final signup = '/users/signup';
  final forgotPassword = '/users/forgotPassword';
  final resetPassword = '/users/resetPassword';
  final updateMyPassword = '/users/updateMyPassword';
}
