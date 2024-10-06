import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../core/di/di_container.dart';

class SocketIo {
  static late IO.Socket socket;

  SocketIo() {
    socket = IO.io(
      ApiRoutes.realTimeUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders(
              {'authorization': 'Bearer ${getIt<PrefsRepository>().token}'})
          .setAuth(
              {'authorization': 'Bearer ${getIt<PrefsRepository>().token}'})
          .build(),
    );
  }

  connection() {
    socket.connect();
    socket.onConnect(
      (data) {
        // socket.emit(ApiRoutes.setup, data);
      },
    );
  }

  joinChat(String subOrderId) {
    socket.emit(ApiRoutes.joinChat, {'subOrderId': subOrderId});

    socket.on(
      'joined',
      (data) {},
    );
  }

  newMessage(MessageModel param, String subOrderId) {
    socket.emit(ApiRoutes.newMessage,
        param.toJson()..addAll({'subOrderId': subOrderId}));
  }

  messageReceived(Function(dynamic data) getData) {
    socket.on(ApiRoutes.messageReceived, getData);
  }

  error() {
    socket.on(
      ApiRoutes.error,
      (data) {
        showMessage(data['message']);
      },
    );
  }
}
