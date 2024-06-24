class ApiRoutes {
  //////////////////?Base////////////////////
  static const String baseUrl = 'http://192.168.1.110:5500';

  //////////////////?Auth////////////////////
  static String login = '/api/v1/auth/user/login';
  static String signup = '/api/v1/auth/user/signup';
  static String confirm = '/api/v1/auth/user/confirm';
  static String updateMyNumber = '/api/v1/auth/user/updateMyNumber';

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
  static String orderAccepted = '/api/v1/orders/accepted';
  static String acceptance(String id) => '/api/v1/orders/$id/acceptance';
  static String cancelOrder(String id) => '/api/v1/orders/$id/refusal';
  static String subOrders(String id) => '/api/v1/orders/$id/sub-orders';
  static String setArrived(String id) => '/api/v1/sub-orders/$id/setArrivedAt';
  static String setPickedUp(String id) => '/api/v1/sub-orders/$id/setPickedUpAt';
  static String subOrderDetails(String id) => '/api/v1/sub-orders/$id';
}
