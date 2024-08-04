import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_pagination_builder.dart';
import 'package:naqla/features/chat/domain/usecases/get_chats_use_case.dart';
import 'package:naqla/features/chat/presentation/state/chat_bloc.dart';
import 'package:naqla/features/chat/presentation/widgets/chat_card.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/data/model/sub_order_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  static const String name = 'ChatPage';

  static const String path = '/ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatBloc bloc = getIt<ChatBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: AppScaffold(
          appBar: AppAppBar(appBarParams: AppBarParams(title: S.of(context).chat), back: false),
          body: Padding(
            padding: REdgeInsets.only(left: UIConstants.screenPadding16, right: UIConstants.screenPadding16, top: UIConstants.screenPadding30),
            child: RefreshIndicator(
              onRefresh: () async {
                bloc.state.getState(ChatState.getChats).pagingController.refresh();
              },
              child: AppPagedBuilder<ChatBloc, SubOrderModel>.pagedListView(
                stateName: ChatState.getChats,
                separatorBuilder: (context, index) => const Divider(),
                noItemsFoundIndicatorBuilder: AppImage.asset(Assets.images.svg.noDataRafiki1.path),
                itemBuilder: (context, item, index) => ChatCard(item: item),
                onPageKeyChanged: (value) {
                  bloc.add(GetChatsEvent(param: PaginationParam(pageNumber: value)));
                },
              ),
            ),
          )),
    );
  }
}
