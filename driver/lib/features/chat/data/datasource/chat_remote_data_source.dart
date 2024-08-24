import 'package:common_state/common_state.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/configuration/api_routes.dart';
import 'package:naqla_driver/features/chat/data/model/message_model.dart';
import 'package:naqla_driver/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:naqla_driver/features/chat/domain/usecases/send_message_use_case.dart';

import '../../../home/data/model/sub_order_model.dart';
import '../../domain/usecases/get_chats_use_case.dart';

@injectable
class ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSource(this.dio);

  Future<PaginationModel<SubOrderModel>> getChats(PaginationParam param) {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.chats, queryParameters: param.toMap);
        return PaginationModel.fromJson(
          result.data,
          (json) => SubOrderModel.fromJson(json),
        );
      },
    );
  }

  Future<PaginationModel<MessageModel>> getMessages(GetMessagesParam param) {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.messages(param.subOrderId), queryParameters: param.toMap);
        return PaginationModel.fromJson(
          result.data,
          (json) => MessageModel.fromJson(json),
        );
      },
    );
  }

  Future<MessageModel> sendMessages(SendMessageParam param) {
    return throwAppException(
      () async {
        final result = await dio.post(ApiRoutes.sendMessage, data: param.toMap);
        return MessageModel.fromJson(result.data);
      },
    );
  }
}
