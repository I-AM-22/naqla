import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/orders/presentation/pages/active_orders_page.dart';
import 'package:naqla_driver/features/orders/presentation/pages/orders_done_page.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';

import '../../../../core/core.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../app/presentation/widgets/customer_appbar.dart';
import '../../../app/presentation/widgets/params_appbar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});
  static String path = "/OrdersPage";
  static String name = "/OrdersPage";

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final OrderBloc bloc = getIt<OrderBloc>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(
            title: S.of(context).orders,
          ),
          back: false,
        ),
        body: Column(
          children: [
            TabBar(
              labelStyle: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
              unselectedLabelColor: context.colorScheme.primary.withOpacity(.3),
              dividerColor: context.colorScheme.primary.withOpacity(.3),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: context.colorScheme.primary,
              splashFactory: NoSplash.splashFactory,
              controller: tabController,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
              labelColor: context.colorScheme.primary,
              onTap: (value) {},
              tabs: [
                Tab(text: S.of(context).active_orders),
                Tab(text: S.of(context).done_orders),
              ],
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                ActiveOrdersPage(),
                OrdersDonePage(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
