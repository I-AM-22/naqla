import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:naqla/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:naqla/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';

import '../../domain/usecases/get_chats_use_case.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase getChatUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  ChatBloc(this.getChatUseCase, this.getMessagesUseCase, this.sendMessageUseCase) : super(ChatState()) {
    multiStatePaginatedApiCall<GetChatsEvent, PaginationModel<SubOrderModel>>(
      ChatState.getChats,
      (event) => getChatUseCase(event.param),
      (event) => event.param.pageNumber,
    );

    multiStatePaginatedApiCall<GetMessagesEvent, PaginationModel<MessageModel>>(
      ChatState.getMessages,
      (event) => getMessagesUseCase(event.param),
      (event) => event.param.pageNumber,
    );

    multiStateApiCall<SendMessagesEvent, MessageModel>(
      ChatState.sendMessages,
      (event) => sendMessageUseCase(event.param),
      onSuccess: (data, event, emit) async {
        final list = state.getState(ChatState.getMessages).pagingController.itemList as List<MessageModel>;
        state.getState(ChatState.getMessages).pagingController.appendPage(list..insert(0, data), 1);

        event.onSuccess();
      },
    );
  }
}
