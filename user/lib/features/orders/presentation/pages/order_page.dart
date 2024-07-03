import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/orders/presentation/pages/active_orders_page.dart';
import 'package:naqla/features/orders/presentation/pages/done_orders_page.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';

import '../../../../generated/l10n.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  static const String name = 'OrderPage';

  static const String path = '/OrderPage';

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final OrderBloc bloc = getIt<OrderBloc>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).orders),
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
              Expanded(child: TabBarView(controller: tabController, children: const [ActiveOrdersPage(), DoneOrdersPage()]))
            ],
          )),
    );
  }
}
