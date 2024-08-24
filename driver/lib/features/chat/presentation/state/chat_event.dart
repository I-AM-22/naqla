part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetChatsEvent extends ChatEvent {
  final PaginationParam param;

  GetChatsEvent({required this.param});
}

class GetMessagesEvent extends ChatEvent {
  final GetMessagesParam param;

  GetMessagesEvent({required this.param});
}

class SendMessagesEvent extends ChatEvent {
  final SendMessageParam param;
  final VoidCallback onSuccess;

  SendMessagesEvent({required this.param, required this.onSuccess});
}

class UpdateWebSocketMessagesEvent extends ChatEvent {
  final MessageModel messageModel;

  UpdateWebSocketMessagesEvent({required this.messageModel});
}
