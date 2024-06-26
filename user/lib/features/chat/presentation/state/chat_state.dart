part of 'chat_bloc.dart';

class ChatState extends StateObject<ChatState> {
  static String getChats = "getChats";
  static String getMessages = "getMessages";

  ChatState({States? states})
      : super([
          PaginationState<PaginationModel<SubOrderModel>, SubOrderModel>(getChats),
          PaginationState<PaginationModel<MessageModel>, MessageModel>(getMessages),
        ], (states) => ChatState(states: states), states);
}
