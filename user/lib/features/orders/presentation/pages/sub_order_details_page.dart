import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di_container.dart';
import '../../../../core/util/core_helper_functions.dart';
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
                    child: data.status.displayStatus(context),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
                    child: AppText.subHeadMedium('${S.of(context).cost}: ${data.cost}'),
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
                    child: AppText.subHeadMedium(CoreHelperFunctions.formatOrderTime(context, data.status,
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
                        return Container(
                          height: 250.h,
                          width: 250.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: context.colorScheme.outline),
                          ),
                          child: BlurHash(
                            hash: data.photos[index].blurHash,
                            image: data.photos[index].mobileUrl,
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
    );
  }
}
