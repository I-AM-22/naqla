import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/chat/domain/repositories/chat_repository.dart';

import '../../../orders/data/model/sub_order_model.dart';

@injectable
class GetChatsUseCase extends UseCase<PaginationModel<SubOrderModel>, PaginationParam> {
  final ChatRepository _repository;

  GetChatsUseCase(this._repository);
  @override
  FutureResult<PaginationModel<SubOrderModel>> call(PaginationParam params) async {
    return _repository.getChats(params);
  }
}

class PaginationParam {
  final int pageNumber;
  final int limit;

  PaginationParam({required this.pageNumber, this.limit = 10});

  Map<String, dynamic> get toMap => {
        "page": pageNumber,
        "limit": limit,
      };
}
