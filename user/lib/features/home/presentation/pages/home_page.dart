import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/widget/order_status_card.dart';

import '../../../../generated/l10n.dart';
import 'create_order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.comeFromSplash});

  static String get path => '/HomePage';
  static String get name => '/HomePage';

  final bool comeFromSplash;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = getIt<HomeBloc>();
  @override
  void initState() {
    _bloc.add(GetOrdersActiveEvent());
    if (widget.comeFromSplash) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: RSizedBox(
            width: context.fullWidth - 16,
            child: Column(
              children: [
                AppText.titleMedium(S.of(context).congratulations),
                7.verticalSpace,
                AppText.bodySmMedium(
                  S.of(context).your_account_is_ready_to_use,
                ),
              ],
            ),
          ),
          btnOkColor: context.colorScheme.primary,
          btnOkOnPress: () {},
        ).show();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: RefreshIndicator(
        onRefresh: () async => _bloc.add(GetOrdersActiveEvent()),
        child: AppScaffold(
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: context.colorScheme.primary,
              onPressed: () => context.pushNamed(CreateOrderPage.name),
              label: AppText(
                S.of(context).new_naqla,
                color: Colors.white,
              ),
              icon: const Icon(
                IconlyBroken.plus,
                color: Colors.white,
              ),
            ),
            appBar: AppAppBar(back: false, appBarParams: AppBarParams(title: S.of(context).home)),
            body: AppCommonStateBuilder<HomeBloc, List<OrderModel>>(
              stateName: HomeState.ordersActive,
              onSuccess: (data) => OrderStatusCard(orders: data),
            )),
      ),
    );
  }
}
