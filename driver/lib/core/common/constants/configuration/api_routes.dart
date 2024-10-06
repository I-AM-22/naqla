class ApiRoutes {
  //?////////////////?Base////////////////////
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String realTimeUrl = String.fromEnvironment('REAL_TIME_URL');

  //?////////////////?RealTime////////////////////
  static const String joinChat = 'join-chat';
  static const String setup = 'setup';
  static const String newMessage = 'new-message';
  static const String messageReceived = 'message-received';
  static const String error = 'error';

  //?////////////////?Auth////////////////////
  static String login = '/api/v1/auth/driver/login';
  static String signup = '/api/v1/auth/driver/signup';
  static String confirm = '/api/v1/auth/driver/confirm';
  static String updateMyNumber = '/api/v1/auth/driver/updateMyNumber';

  //?////////////////?File////////////////////
  static String single = '/api/v1/photos/single';
  static String multiple = '/api/v1/photos/multiple';

  //?////////////////?Driver////////////////////
  static String myProfile = '/api/v1/drivers/me';

  //?////////////////?Advantages////////////////////
  static String advantages = '/api/v1/advantages';

  //?////////////////?Order////////////////////
  static String orderMine = '/api/v1/orders/mine';
  static String order = '/api/v1/orders';

  //?////////////////Car////////////////////
  static String cars = '/api/v1/cars';
  static String carsMine = '/api/v1/cars/mine';
  static String deleteCar(String id) => '/api/v1/cars/$id';
  static String editCar(String id) => '/api/v1/cars/$id';
  static String getOrderCars(String id) => '/api/v1/orders/$id/cars/mine';
  static String addAdvantage(String id) => '/api/v1/cars/$id/advantages';

  //?////////////////?Chats////////////////////
  static String chats = '/api/v1/sub-orders/chats';
  static String messages(String id) => '/api/v1/suborders/$id/messages';
  static String sendMessage = '/api/v1/messages';

  //?////////////////?Sub-Order////////////////////
  static String subOrders = '/api/v1/sub-orders';
  static String subOrderDetails(String id) => '/api/v1/sub-orders/$id';
  static String subOrdersForDriver = '/api/v1/sub-orders/for-driver';
  static String setDriver(String id) => '/api/v1/sub-orders/$id/setDriver';
  static String setDelivered(String id) => '/api/v1/sub-orders/$id/setDeliveredAt';
  static String ordersDone = '/api/v1/sub-orders/done-driver';
  static String activeOrders = '/api/v1/sub-orders/active-driver';
}
