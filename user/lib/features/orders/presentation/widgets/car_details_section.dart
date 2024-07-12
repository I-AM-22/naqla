import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/generated/l10n.dart';

class CarDetailsSection extends StatelessWidget {
  const CarDetailsSection({super.key, required this.data});
  final SubOrderModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
      child: Container(
        padding: REdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.primary.withOpacity(.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(
              style: context.textTheme.subHeadMedium
                  .copyWith(color: context.colorScheme.primary, height: 1.5),
              children: [
                TextSpan(
                    text:
                        '${S.of(context).vehicle_advantages}: ${data.order?.advantages?.map(
                  (e) => e,
                )}\n'),
                TextSpan(
                    text:
                        '${S.of(context).driver_name}: ${data.carModel?.driver?.firstName} ${data.carModel?.driver?.lastName}\n'),
                TextSpan(
                    text:
                        '${S.of(context).car_model}: ${data.carModel?.model}\n'),
                TextSpan(
                    text:
                        '${S.of(context).car_brand}: ${data.carModel?.brand}\n'),
                WidgetSpan(
                    child: Padding(
                  padding: REdgeInsets.symmetric(vertical: 10),
                )),
                TextSpan(text: '${S.of(context).car_color}:\n'),
                WidgetSpan(
                    child: Container(
                  width: 70.w,
                  height: 20.h,
                  color: CoreHelperFunctions.hexToColor(
                      data.carModel?.color ?? ''),
                ))
              ]),
        ),
      ),
    );
  }
}
