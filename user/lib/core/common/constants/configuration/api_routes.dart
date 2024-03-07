class ApiRoutes {
  //////////////////?Base////////////////////
  static const String baseUrl = 'http://192.168.1.104:5500';

  //////////////////?Auth////////////////////
  static String login = '/api/v1/auth/login';
  static String signup = '/api/v1/auth/signup';
  static String confirm = '/api/v1/auth/confirm';
  static String updateMyNumber = '/api/v1/auth/updateMyNumber';

  //////////////////?File////////////////////
  static String single = '/api/v1/photos/single';

  //////////////////?Account////////////////////
  static String personalInfo = '/api/v1/users/me';
}
