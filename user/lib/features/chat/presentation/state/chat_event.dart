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
