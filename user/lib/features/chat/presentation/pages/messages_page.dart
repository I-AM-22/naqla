import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_pagination_builder.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';
import 'package:naqla/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:naqla/features/chat/presentation/state/chat_bloc.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../app/presentation/widgets/customer_appbar.dart';
import '../../../app/presentation/widgets/params_appbar.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key, required this.subOrderId});
  final String subOrderId;

  static const String name = 'MessagesPage';
  static const String path = 'MessagesPage';

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final ChatBloc bloc = getIt<ChatBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
              appBarParams: AppBarParams(
            title: 'islam',
          )),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: AppImage.asset(
                    Assets.icons.essential.sendIcon.path,
                    size: 20.w,
                  ),
                ),
                Expanded(
                  child: AppTextFormField(
                    hintText: S.of(context).write_message,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: context.colorScheme.systemGray.shade300),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: REdgeInsets.only(left: UIConstants.screenPadding16, right: UIConstants.screenPadding16, top: UIConstants.screenPadding30),
            child: AppPagedBuilder<ChatBloc, MessageModel>.pagedListView(
              stateName: ChatState.getMessages,
              itemBuilder: (context, item, index) => Column(
                crossAxisAlignment: item.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: REdgeInsets.only(bottom: 8),
                    padding: REdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: item.isUser ? context.colorScheme.systemGray.shade100 : context.colorScheme.primary50,
                        borderRadius: BorderRadius.only(
                            topRight: item.isUser ? const Radius.circular(16) : Radius.zero,
                            topLeft: item.isUser ? const Radius.circular(16) : Radius.zero,
                            bottomLeft: const Radius.circular(16),
                            bottomRight: const Radius.circular(16)),
                        border: item.isUser ? null : Border.all(color: context.colorScheme.primary)),
                    child: AppText.bodyRegular(
                      item.content,
                      style: TextStyle(fontSize: 14.sp),
                      color: item.isUser ? context.colorScheme.tertiary : context.colorScheme.systemGray.shade700,
                    ),
                  ),
                  AppText.bodyRegular(
                    CoreHelperFunctions.fromDateTimeToString(item.createdAt),
                    style: TextStyle(fontSize: 12.sp),
                    color: context.colorScheme.tertiary,
                  ),
                ],
              ),
              onPageKeyChanged: (value) {
                bloc.add(GetMessagesEvent(param: GetMessagesParam(pageNumber: value, subOrderId: widget.subOrderId)));
              },
            ),
          )),
    );
  }
}
