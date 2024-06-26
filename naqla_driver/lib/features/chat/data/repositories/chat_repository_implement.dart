import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/features/chat/data/datasource/chat_remote_data_source.dart';
import 'package:naqla_driver/features/chat/data/model/message_model.dart';
import 'package:naqla_driver/features/chat/domain/repositories/chat_repository.dart';
import 'package:naqla_driver/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:naqla_driver/features/chat/domain/usecases/send_message_use_case.dart';

import '../../../home/data/model/sub_order_model.dart';
import '../../domain/usecases/get_chats_use_case.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImplement implements ChatRepository {
  final ChatRemoteDataSource dataSource;

  ChatRepositoryImplement(this.dataSource);
  @override
  FutureResult<PaginationModel<SubOrderModel>> getChats(PaginationParam param) {
    return toApiResult(
      () async {
        return await dataSource.getChats(param);
      },
    );
  }

  @override
  FutureResult<PaginationModel<MessageModel>> getMessages(GetMessagesParam params) {
    return toApiResult(
      () async {
        return await dataSource.getMessages(params);
      },
    );
  }

  @override
  FutureResult<MessageModel> sendMessages(SendMessageParam params) {
    return toApiResult(
      () async {
        return await dataSource.sendMessages(params);
      },
    );
  }
}
