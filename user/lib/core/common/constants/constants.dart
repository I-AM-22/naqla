import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:naqla/core/core.dart';

const Size designSize = Size(375, 812);

final formatter = NumberFormat('###,###,000', 'en');

typedef Json = Map<String, dynamic>;

class UIConstants {
  static final screenPadding = REdgeInsets.only(top: 30, right: 20, left: 20);

  static final screenPadding16 = 16.w;
  static final screenPadding30 = 30.h;
  static final screenPadding20 = 20.w;

  static getShadow(BuildContext context) => context.colorScheme.outlineVariant.withOpacity(0.25);
}
