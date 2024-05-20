class ApiRoutes {
  //////////////////?Base////////////////////
  static const String baseUrl = 'http://192.168.1.110:5500';

  //////////////////?Auth////////////////////
  static String login = '/api/v1/auth/driver/login';
  static String signup = '/api/v1/auth/driver/signup';
  static String confirm = '/api/v1/auth/driver/confirm';
  static String updateMyNumber = '/api/v1/auth/driver/updateMyNumber';

  //////////////////?File////////////////////
  static String single = '/api/v1/photos/single';
  static String multiple = '/api/v1/photos/multiple';

  //////////////////?Account////////////////////
  static String personalInfo = '/api/v1/users/me';

  //////////////////?Advantages////////////////////
  static String advantages = '/api/v1/advantages';

  //////////////////?Order////////////////////
  static String orderMine = '/api/v1/orders/mine';
  static String order = '/api/v1/orders';
}
