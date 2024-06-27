import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:naqla/features/chat/domain/repositories/chat_repository.dart';

@injectable
class SendMessageUseCase extends UseCase<MessageModel, SendMessageParam> {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);
  @override
  FutureResult<MessageModel> call(SendMessageParam params) async {
    return _repository.sendMessages(params);
  }
}

class SendMessageParam {
  final String content;
  final bool isUser;
  final String subOrderId;

  SendMessageParam({required this.content, required this.isUser, required this.subOrderId});

  Map<String, dynamic> get toMap => {
        "content": content,
        "isUser": isUser,
        "subOrderId": subOrderId,
      };
}
