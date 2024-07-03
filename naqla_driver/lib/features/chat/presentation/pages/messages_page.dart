import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_loading_indicator.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_pagination_builder.dart';
import 'package:naqla_driver/features/chat/data/model/message_model.dart';
import 'package:naqla_driver/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:naqla_driver/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:naqla_driver/features/chat/presentation/state/chat_bloc.dart';
import 'package:naqla_driver/features/chat/presentation/widgets/message_card.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../app/presentation/widgets/customer_appbar.dart';
import '../../../app/presentation/widgets/params_appbar.dart';

class MessageParam {
  final String subOrderId;
  final String userName;

  MessageParam({required this.subOrderId, required this.userName});
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
            title: widget.param.userName,
          )),
          body: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              print(state.toString());
              return Column(
                children: [
                  Expanded(
                    child: AppPagedBuilder<ChatBloc, MessageModel>.pagedListView(
                      reverse: true,
                      noItemsFoundIndicatorBuilder: Center(child: AppText.titleSmall('لا يوجد رسائل لعرضها')),
                      stateName: ChatState.getMessages,
                      itemBuilder: (context, item, index) => MessageCard(item: item),
                      onPageKeyChanged: (value) {
                        bloc.add(GetMessagesEvent(param: GetMessagesParam(pageNumber: value, subOrderId: widget.param.subOrderId)));
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              bloc.add(SendMessagesEvent(
                                param: SendMessageParam(subOrderId: widget.param.subOrderId, content: controller.text, isUser: false),
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
                              : AppImage.asset(
                                  Assets.icons.essential.sendIcon.path,
                                  size: 20.w,
                                ),
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
