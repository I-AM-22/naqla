import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget({
    super.key,
    this.number,
    this.holderName,
    this.expiryDate,
    this.numberWidget,
    this.holderNameWidget,
    this.expiryDateWidget,
  })  : assert(number != null || numberWidget != null),
        assert(holderName != null || holderNameWidget != null),
        assert(expiryDate != null || expiryDateWidget != null);

  final Widget? numberWidget;
  final Widget? holderNameWidget;
  final Widget? expiryDateWidget;

  final String? number;
  final String? holderName;
  final String? expiryDate;

  @override
  State<CreditCardWidget> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: context.isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        const Icon(
          Icons.credit_card,
          color: Colors.white,
        ),
        Padding(
          padding: REdgeInsets.only(left: 13, bottom: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.number != null)
                AppText(
                  widget.number!,
                  color: context.colorScheme.surface,
                  style: boldWIthShadow(context),
                )
              else
                widget.numberWidget!,
              60.verticalSpace,
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.headlineSmall(
                        S.of(context).card_holder_name,
                        color: context.colorScheme.surface,
                        style: lightWithShadow(context),
                      ),
                      4.verticalSpace,
                      if (widget.holderName != null)
                        AppText(
                          widget.holderName!,
                          color: context.colorScheme.surface,
                          style: boldWIthShadow(context),
                        )
                      else
                        widget.holderNameWidget!,
                    ],
                  ),
                  60.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.headlineSmall(
                        S.of(context).expiry_Date,
                        color: context.colorScheme.surface,
                        style: lightWithShadow(context),
                      ),
                      4.verticalSpace,
                      if (widget.expiryDate != null)
                        AppText(
                          widget.expiryDate!,
                          color: context.colorScheme.surface,
                          style: boldWIthShadow(context),
                        )
                      else
                        widget.expiryDateWidget!,
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 25.h,
            right: context.isArabic ? null : 35.w,
            left: context.isArabic ? 35.w : null,
            child: AppImage.asset(
              Assets.icons.payments.visa.path,
              size: 40.r,
            ))
      ],
    );
  }

  TextStyle boldWIthShadow(BuildContext context) => context.textTheme.titleMedium!.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: .4,
        shadows: [
          Shadow(
            color: context.colorScheme.shadow.withOpacity(.4),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      );

  TextStyle lightWithShadow(BuildContext context) => context.textTheme.bodySmMedium.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: .4,
        color: context.colorScheme.primary,
        shadows: [
          Shadow(
            color: context.colorScheme.shadow.withOpacity(.4),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      );
}
