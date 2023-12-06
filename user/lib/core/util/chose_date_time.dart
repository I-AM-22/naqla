import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';

class ChoseDateTime {
  String chose(DateTime createdAt) {
    final date = DateTime.now().difference(createdAt);
    if (date.inMinutes < 60) {
      return ' ${LocaleKeys.date_ago.tr()} ${date.inMinutes} ${LocaleKeys.date_minute.tr()} ';
    } else if (date.inHours < 24) {
      return '  ${LocaleKeys.date_ago.tr()} ${date.inHours} ${LocaleKeys.date_hour.tr()} ';
    } else if (date.inDays < 7) {
      return ' ${LocaleKeys.date_ago.tr()} ${date.inDays} ${LocaleKeys.date_day.tr()} ';
    } else if (date.inSeconds < 60) {
      return ' ${LocaleKeys.date_ago.tr()} ${date.inDays} ${LocaleKeys.date_second.tr()} ';
    } else {
      return '${createdAt.year}-'
          '${createdAt.month}-'
          '${createdAt.day}';
    }
  }
}
