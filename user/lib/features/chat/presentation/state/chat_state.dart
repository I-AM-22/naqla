part of 'chat_bloc.dart';

class ChatState extends StateObject<ChatState> {
  static String getChats = "getChats";
  static String getMessages = "getMessages";
  static String sendMessages = "sendMessages";

  ChatState({States? states})
      : super([
          PaginationState<PaginationModel<SubOrderModel>, SubOrderModel>(getChats),
          PaginationState<PaginationModel<MessageModel>, MessageModel>(getMessages),
          InitialState<MessageModel>(sendMessages)
        ], (states) => ChatState(states: states), states);
}
