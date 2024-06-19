import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';
import 'package:naqla_driver/features/orders/presentation/widgets/location_map.dart';

import '../../../../generated/l10n.dart';
import 'image_page.dart';

class SubOrderDetailsPage extends StatefulWidget {
  const SubOrderDetailsPage({super.key, required this.id});
  final String id;

  static String path = "SubOrderDetailsPage";

  static String name = "SubOrderDetailsPage";

  @override
  State<SubOrderDetailsPage> createState() => _SubOrderDetailsPageState();
}

class _SubOrderDetailsPageState extends State<SubOrderDetailsPage> {
  final OrderBloc bloc = getIt<OrderBloc>();

  @override
  void initState() {
    bloc.add(GetSubOrderDetailsEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
        body: AppCommonStateBuilder<OrderBloc, SubOrderModel>(
          stateName: OrderState.getSuOrderDetails,
          onSuccess: (data) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LocationMap(locationStart: data.order!.locationStart, locationEnd: data.order!.locationEnd),
                  16.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
                    child: data.status!.displayStatus(context),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
                    child: RichText(
                      text: TextSpan(style: context.textTheme.subHeadMedium.copyWith(color: context.colorScheme.primary), children: [
                        TextSpan(text: '${S.of(context).weight}${data.weight},'),
                        WidgetSpan(child: 5.horizontalSpace),
                        TextSpan(text: '${S.of(context).cost}${formatter.format(data.cost)} ${S.of(context).syp},'),
                        if ((data.order?.porters ?? 0) > 0) ...{
                          WidgetSpan(child: 5.horizontalSpace),
                          TextSpan(text: '${S.of(context).the_number_of_floors}: ${(data.order?.porters ?? 1) - 1}'),
                        }
                      ]),
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
                    child: AppText.subHeadMedium(
                        '${S.of(context).order_date}: ${CoreHelperFunctions.fromOrderDateTimeToString(data.order!.desiredDate)}'),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
                    child: AppText.subHeadMedium(CoreHelperFunctions.formatOrderTime(context, data.status!,
                        deliveredAt: data.deliveredAt,
                        acceptedAt: data.acceptedAt,
                        arrivedAt: data.arrivedAt,
                        driverAssignedAt: data.driverAssignedAt,
                        pickedUpAt: data.pickedUpAt)),
                  ),
                  SizedBox(
                    width: 200.w,
                    height: 200.h,
                    child: ListView.separated(
                        padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding16),
                        scrollDirection: Axis.horizontal,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => context.pushNamed(ImagePage.name, extra: data.photos[index].mobileUrl),
                            child: Container(
                              height: 250.h,
                              width: 250.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: context.colorScheme.outline),
                              ),
                              child: Center(
                                child: AppImage.network(
                                  data.photos[index].mobileUrl,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => 8.horizontalSpace,
                        itemCount: data.photos.length),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
