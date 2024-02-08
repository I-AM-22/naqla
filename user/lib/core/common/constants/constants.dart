import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

const Size designSize = Size(375, 812);

final formatter = NumberFormat('###,###,000', 'en');

typedef Json = Map<String, dynamic>;

class UIConstants {
  static final screenPadding = REdgeInsets.only(top: 30, right: 20, left: 20);
}
