import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIo {
  static IO.Socket socket = IO.io(ApiRoutes.realTimeUrl, <String, dynamic>{
    'autoConnect': false,
    'transports': ['websocket'],
  });

  static connection() {
    socket.connect();
    socket.onConnect(
      (data) {
        print('connect $data');
        // socket.emit(ApiRoutes.setup, data);
      },
    );
  }

  static joinChat(String subOrderId) {
    socket.emit(ApiRoutes.joinChat, subOrderId);
  }

  static newMessage(MessageModel param) {
    socket.emit(ApiRoutes.newMessage, param);
  }

  static error() {
    socket.on(
      ApiRoutes.error,
      (data) {
        showMessage(data['message']);
      },
    );
  }
}
