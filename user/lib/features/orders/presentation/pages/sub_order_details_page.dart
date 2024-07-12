import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/enums/sub_order_status.dart';
import 'package:naqla/features/orders/presentation/pages/rating_page.dart';
import 'package:naqla/features/orders/presentation/widgets/car_details_section.dart';
import 'package:naqla/features/orders/presentation/widgets/sub_order_details_section.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di_container.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../data/model/sub_order_model.dart';
import '../state/order_bloc.dart';
import 'location_map.dart';

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
        body: RefreshIndicator(
          onRefresh: () async {
            bloc.add(GetSubOrderDetailsEvent(id: widget.id));
          },
          child: AppCommonStateBuilder<OrderBloc, SubOrderModel>(
            stateName: OrderState.getSuOrderDetails,
            onSuccess: (data) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LocationMap(
                        locationStart: data.order!.locationStart!,
                        locationEnd: data.order!.locationEnd!),
                    16.verticalSpace,
                    Padding(
                      padding: REdgeInsets.symmetric(
                          horizontal: UIConstants.screenPadding20),
                      child: Row(
                        children: [
                          Expanded(
                              child: data.status.displayStatus(context,
                                  arrivedAt: data.arrivedAt)),
                          if (data.status == SubOrderStatus.delivered) ...{
                            8.horizontalSpace,
                            Expanded(
                              child: InkWell(
                                onTap: () => context.pushNamed(RatingPage.name,
                                    extra: data.id),
                                child: Container(
                                  padding: REdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.colorScheme.delivered,
                                  ),
                                  child: Center(
                                    child: AppText.subHeadMedium(
                                      S.of(context).rate_the_driver,
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          },
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    SubOrderDetailsSection(data: data),
                    if (data.carModel != null) ...{
                      16.verticalSpace,
                      CarDetailsSection(data: data),
                    },
                    16.verticalSpace,
                    SizedBox(
                      width: 200.w,
                      height: 200.h,
                      child: ListView.separated(
                        padding: REdgeInsets.symmetric(
                            horizontal: UIConstants.screenPadding20,
                            vertical: UIConstants.screenPadding16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 250.h,
                            width: 250.h,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: context.colorScheme.outline),
                            ),
                            child: AppImage.network(
                              data.photos[index].mobileUrl,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => 8.horizontalSpace,
                        itemCount: data.photos.length,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
