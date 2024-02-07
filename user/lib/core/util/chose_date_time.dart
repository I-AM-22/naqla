import 'package:flutter/cupertino.dart';

import '../../generated/l10n.dart';

class ChoseDateTime {
  String chose(DateTime createdAt, BuildContext context) {
    final date = DateTime.now().difference(createdAt);
    if (date.inSeconds < 60) {
      return ' ${S.of(context).ago} ${date.inDays} ${S.of(context).second} ';
    } else if (date.inMinutes < 60) {
      return ' ${S.of(context).ago} ${date.inMinutes} ${S.of(context).minute} ';
    } else if (date.inHours < 24) {
    } else if (date.inDays < 7) {
      return ' ${S.of(context).ago} ${date.inDays} ${S.of(context).day} ';
    } else {
      return '${createdAt.year}-'
          '${createdAt.month}-'
          '${createdAt.day}';
    }
    return ' ${S.of(context).ago} ${date.inHours} ${S.of(context).hour} ';
  }
}
