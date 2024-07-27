import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/home/domain/use_case/accept_order_use_case.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:naqla/features/home/presentation/pages/home_page.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key, required this.id});
  final String id;

  static String path = "PaymentMethodPage";
  static String name = "PaymentMethodPage";

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final ValueNotifier<String?> isSelected = ValueNotifier(null);

  final HomeBloc bloc = getIt<HomeBloc>();
  @override
  void initState() {
    bloc.add(GetPaymentMethodEvent(onSuccess: () {}));
    super.initState();
  }

  List<String> icons = [
    Assets.icons.payments.mada.path,
    Assets.icons.payments.masterCard.path,
    Assets.icons.payments.visa.path,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: 'الدفع'),
          ),
          bottomNavigationBar: BlocSelector<HomeBloc, HomeState, CommonState>(
            selector: (state) {
              return state.getState(HomeState.acceptOrder);
            },
            builder: (context, state) {
              return Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding16),
                child: AppButton.dark(
                  isLoading: state.isLoading,
                  title: S.of(context).confirm_order,
                  onPressed: () {
                    if (isSelected.value != null) {
                      bloc.add(AcceptOrderEvent(
                        param: AcceptOrderParam(id: widget.id, methodType: isSelected.value),
                        onSuccess: () {
                          context.goNamed(HomePage.name);
                        },
                      ));
                    }
                  },
                ),
              );
            },
          ),
          body: AppCommonStateBuilder<HomeBloc, List<String>>(
            stateName: HomeState.getPaymentMethod,
            onSuccess: (data) {
              return ListView.separated(
                  clipBehavior: Clip.none,
                  padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding20),
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder(
                      valueListenable: isSelected,
                      builder: (context, value, child) => badges.Badge(
                        position: badges.BadgePosition.topEnd(top: -10, end: -12),
                        showBadge: value == data[index],
                        ignorePointer: false,
                        badgeContent: const Icon(Icons.check, color: Colors.white, size: 10),
                        badgeAnimation: const badges.BadgeAnimation.rotation(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: context.colorScheme.primary,
                          padding: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(4),
                          elevation: 0,
                        ),
                        child: InkWell(
                          onTap: () {
                            isSelected.value = data[index];
                          },
                          child: Container(
                              padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 8),
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: context.colorScheme.black.withOpacity(.24), offset: const Offset(0, 2), blurRadius: 5)],
                                borderRadius: BorderRadius.circular(8),
                                color: context.colorScheme.onPrimary,
                              ),
                              child: Row(
                                children: [
                                  AppImage.asset(
                                    icons[index],
                                    size: 50.r,
                                  ),
                                  8.horizontalSpace,
                                  AppText.bodyMedium(data[index]),
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 8.verticalSpace,
                  itemCount: data.length);
            },
          )),
    );
  }
}
