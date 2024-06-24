import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:naqla/features/home/presentation/widget/order_card.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';
import 'create_order.dart';
import 'order_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.comeFromSplash = false});

  static String get path => '/HomePage';
  static String get name => '/HomePage';

  final bool? comeFromSplash;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = getIt<HomeBloc>();
  final ScrollController _hideButtonController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    _bloc.add(GetOrdersActiveEvent());
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection == ScrollDirection.forward) {
          if (!_isVisible) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: AppScaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Visibility(
            visible: _isVisible,
            child: FloatingActionButton.extended(
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
          ),
          appBar: AppAppBar(back: false, appBarParams: AppBarParams(title: S.of(context).home)),
          body: RefreshIndicator(
            onRefresh: () async {
              _bloc.add(GetOrdersActiveEvent());
            },
            child: AppCommonStateBuilder<HomeBloc, List<OrderModel>>(
              stateName: HomeState.ordersActive,
              onSuccess: (data) => Padding(
                padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding20, horizontal: UIConstants.screenPadding16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(S.of(context).please_confirm_order),
                    16.verticalSpace,
                    Expanded(
                      child: ListView.separated(
                        controller: _hideButtonController,
                        itemCount: data.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) => OrderCard(
                          onTap: () => context.pushNamed(OrderDetailsPage.name, extra: data[index]),
                          showIndicator: true,
                          orderModel: data[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
