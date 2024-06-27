import 'package:common_state/common_state.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:naqla/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:naqla/features/chat/domain/usecases/send_message_use_case.dart';

import '../../../orders/data/model/sub_order_model.dart';
import '../usecases/get_chats_use_case.dart';

abstract class ChatRepository {
  FutureResult<PaginationModel<SubOrderModel>> getChats(PaginationParam param);

  FutureResult<PaginationModel<MessageModel>> getMessages(GetMessagesParam params);

  FutureResult<MessageModel> sendMessages(SendMessageParam params);
}
