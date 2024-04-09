import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';

import '../../../../generated/l10n.dart';

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
      child: AppScaffold(
          appBar: AppAppBar(back: false, appBarParams: AppBarParams(title: S.of(context).home)),
          body: AppCommonStateBuilder<HomeBloc, List<OrderModel>>(
            stateName: HomeState.ordersActive,
            onSuccess: (data) {
              return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) => 16.verticalSpace,
                itemBuilder: (context, index) => Padding(
                  padding: UIConstants.screenPadding,
                  child: Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: context.colorScheme.primary.withOpacity(.1), offset: const Offset(0, 0), blurRadius: 1)]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: REdgeInsets.all(8),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.colorScheme.warning.withOpacity(.2)),
                            child: AppText(data[index].status)),
                        16.verticalSpace,
                        AppText("From"),
                        AppText(
                            "${data[index].locationEnd.region},${data[index].locationStart.street},${data[index].locationStart.latitude},${data[index].locationStart.longitude}"),
                        16.verticalSpace,
                        AppText("To"),
                        AppText(
                            "${data[index].locationEnd.region},${data[index].locationEnd.street},${data[index].locationEnd.latitude},${data[index].locationEnd.longitude}"),
                        16.verticalSpace,
                        SizedBox(
                          height: 200.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, indexPhoto) => SizedBox(
                              width: 200.w,
                              child: BlurHash(
                                  imageFit: BoxFit.cover,
                                  hash: data[index].photos[indexPhoto].blurHash,
                                  image: data[index].photos[indexPhoto].mobileUrl),
                            ),
                            separatorBuilder: (context, indexPhoto) => 8.horizontalSpace,
                            itemCount: data[index].photos.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
