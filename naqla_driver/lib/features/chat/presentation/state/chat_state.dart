part of 'chat_bloc.dart';

class ChatState extends StateObject<ChatState> {
  static String getChats = "getChats";
  static String getMessages = "getMessages";
  static String sendMessages = "sendMessages";
  static String messages = "messages";

  final SocketIo socketIo;

  ChatState({States? states})
      : socketIo = SocketIo(),
        super([
          PaginationState<PaginationModel<SubOrderModel>, SubOrderModel>(getChats),
          PaginationState<PaginationModel<MessageModel>, MessageModel>(getMessages),
          InitialState<MessageModel>(sendMessages),
          InitialState(messages),
        ], (states) => ChatState(states: states), states);

  @override
  List<Object?> get props => super.props..add(socketIo);
}
