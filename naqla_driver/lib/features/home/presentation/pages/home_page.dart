import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/presentation/state/home_bloc.dart';
import 'package:naqla_driver/features/home/presentation/widgets/order_card.dart';
import 'package:naqla_driver/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String path = "/HomePage";
  static String name = "/HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc bloc = getIt<HomeBloc>();
  @override
  void initState() {
    bloc.add(GetSubOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).home),
          back: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            bloc.add(GetSubOrdersEvent());
          },
          child: AppCommonStateBuilder<HomeBloc, List<SubOrderModel>>(
            stateName: HomeState.subOrders,
            onSuccess: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: REdgeInsets.symmetric(vertical: 8),
                    child: OrderCard(subOrderModel: data[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
