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
  static String login = '/api/v1/auth/user/login';
  static String signup = '/api/v1/auth/user/signup';
  static String confirm = '/api/v1/auth/user/confirm';
  static String updateMyNumber = '/api/v1/auth/user/updateMyNumber';

  //?////////////////?File////////////////////
  static String single = '/api/v1/photos/single';
  static String multiple = '/api/v1/photos/multiple';

  //?////////////////?Account////////////////////
  static String personalInfo = '/api/v1/users/me';

  //?////////////////?Advantages////////////////////
  static String advantages = '/api/v1/advantages';

  //?////////////////?Chats////////////////////
  static String chats = '/api/v1/sub-orders/chats';
  static String messages(String id) => '/api/v1/suborders/$id/messages';
  static String sendMessage = '/api/v1/messages';

  //?////////////////?Order////////////////////
  static String orderMine = '/api/v1/orders/mine';
  static String order = '/api/v1/orders';
  static String orderAccepted = '/api/v1/orders/accepted';
  static String orderActive = '/api/v1/orders/active-user';
  static String orderDone = '/api/v1/orders/done-user';
  static String acceptance(String id) => '/api/v1/orders/$id/acceptance';
  static String cancelOrder(String id) => '/api/v1/orders/$id/refusal';
  static String subOrders(String id) => '/api/v1/orders/$id/sub-orders';
  static String setArrived(String id) => '/api/v1/sub-orders/$id/setArrivedAt';
  static String setPickedUp(String id) => '/api/v1/sub-orders/$id/setPickedUpAt';
  static String subOrderDetails(String id) => '/api/v1/sub-orders/$id';
  static String rating(String id) => '/api/v1/sub-orders/$id/rating';

  //?////////////////?Payment////////////////////
  static String paymentMethod = "/api/v1/payments/payment-methods";
  static String checkOut(String id) => "/api/v1/payments/$id/check-status";
  static String withDraw(String id) => "/api/v1/users/$id/wallet/deposit";
}
