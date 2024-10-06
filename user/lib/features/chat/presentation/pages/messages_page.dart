import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_loading_indicator.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_pagination_builder.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:naqla/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:naqla/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:naqla/features/chat/presentation/state/chat_bloc.dart';
import 'package:naqla/features/chat/presentation/widgets/message_card.dart';

import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../app/presentation/widgets/customer_appbar.dart';
import '../../../app/presentation/widgets/params_appbar.dart';

class MessageParam {
  final String subOrderId;
  final String driverName;

  MessageParam({required this.subOrderId, required this.driverName});
}

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key, required this.param});
  final MessageParam param;

  static const String name = 'MessagesPage';
  static const String path = 'MessagesPage';

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final ChatBloc bloc = getIt<ChatBloc>();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
              appBarParams: AppBarParams(
            title: widget.param.driverName,
          )),
          body: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: AppPagedBuilder<ChatBloc, MessageModel>.pagedListView(
                      reverse: true,
                      stateName: ChatState.getMessages,
                      itemBuilder: (context, item, index) {
                        return MessageCard(
                          item: item,
                          index: index,
                          previousItem: index == 0 ? null : state.getState(ChatState.getMessages).pagingController.itemList?[index - 1],
                          lastMessage: index == (state.getState(ChatState.getMessages).pagingController.itemList?.length ?? 1) - 1,
                        );
                      },
                      onPageKeyChanged: (value) {
                        bloc.add(GetMessagesEvent(param: GetMessagesParam(pageNumber: value, subOrderId: widget.param.subOrderId)));
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: context.colorScheme.surface,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              bloc.add(SendMessagesEvent(
                                param: SendMessageParam(subOrderId: widget.param.subOrderId, content: controller.text, isUser: true),
                                onSuccess: () {
                                  controller.text = '';
                                },
                              ));
                            }
                          },
                          icon: state.getState(ChatState.sendMessages).isLoading
                              ? AppLoadingIndicator(
                                  size: 25.r,
                                )
                              : Icon(IconlyBroken.send),
                        ),
                        Expanded(
                          child: AppTextFormField(
                            hintText: S.of(context).write_message,
                            controller: controller,
                            textInputAction: TextInputAction.newline,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: context.colorScheme.systemGray.shade300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
