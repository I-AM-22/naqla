import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:naqla/features/chat/domain/repositories/chat_repository.dart';
import 'package:naqla/features/chat/domain/usecases/get_chats_use_case.dart';

@injectable
class GetMessagesUseCase extends UseCase<PaginationModel<MessageModel>, GetMessagesParam> {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);
  @override
  FutureResult<PaginationModel<MessageModel>> call(GetMessagesParam params) async {
    return _repository.getMessages(params);
  }
}

class GetMessagesParam extends PaginationParam {
  final String subOrderId;
  GetMessagesParam({required super.pageNumber, required this.subOrderId});
}
