import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/presentation/pages/add_car_page.dart';
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
    return BlocProvider(
      create: (context) => bloc,
      child: AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).home),
          back: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.pushNamed(AddCarPage.name);
          },
          icon: const Icon(
            IconlyBroken.plus,
            color: Colors.white,
          ),
          backgroundColor: context.colorScheme.primary,
          label: AppText.labelMedium(
            S.of(context).add_car,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        body: AppCommonStateBuilder<HomeBloc, List<SubOrderModel>>(
          stateName: HomeState.subOrders,
          onSuccess: (data) {
            return ListView.separated(
              separatorBuilder: (context, index) => 16.verticalSpace,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return OrderCard(subOrderModel: data[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
