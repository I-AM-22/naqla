abstract class EndPoints {
  EndPoints._();

  static const String baseUrl = 'http://192.168.1.104:5500';
  static const auth = Auth();
  static const profile = Profile();
  static const photo = Photos();
}

class Auth {
  const Auth();
  final login = '/api/v1/auth/login';
  final signup = '/api/v1/auth/signup';
  final confirm = '/api/v1/auth/confirm';
  final updateMyNumber = '/api/v1/auth/updateMyNumber';
}

class Photos {
  const Photos();

  final single = '/api/v1/photos/single';
}

class Profile {
  const Profile();

  final personalInfo = '/api/v1/users/me';
}
