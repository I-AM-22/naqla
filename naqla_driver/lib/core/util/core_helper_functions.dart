import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/presentation/pages/login_page.dart';
import '../../features/app/domain/repository/prefs_repository.dart';
import '../../features/app/presentation/widgets/animated_dialog.dart';
import '../../generated/l10n.dart';
import '../common/enums/order_status.dart';
import '../di/di_container.dart';

class CoreHelperFunctions {
  /// Cast to [T] if possible or return null
  T? castOrNull<T>(x) => x is T ? x : null;

  static void logOut(BuildContext context) => AnimatedDialog.show(context,
      child: Padding(
        padding: REdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.titleSmall(S.of(context).logOut),
            4.verticalSpace,
            AppText.bodyMedium(S.of(context).are_you_sure_you_want_to_log_out),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton.ghost(
                    style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => context.colorScheme.error)),
                    buttonSize: ButtonSize.medium,
                    child: AppText.bodySmall(
                      S.of(context).logOut,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await getIt<PrefsRepository>().clearUser();
                      if (!context.mounted) return;
                      context.goNamed(SignInPage.name);
                    }),
                AppButton.ghost(
                  buttonSize: ButtonSize.medium,
                  child: AppText.bodySmall(S.of(context).cancel),
                  onPressed: () {
                    context.pop(S.of(context).cancel);
                  },
                )
              ],
            )
          ],
        ),
      ));

  static String formatOrderTime(BuildContext context, SubOrderStatus status,
      {DateTime? acceptedAt, DateTime? arrivedAt, DateTime? deliveredAt, DateTime? driverAssignedAt, DateTime? pickedUpAt}) {
    if (status == SubOrderStatus.ready) return '${S.of(context).order_accepted_date}:\n${fromOrderDateTimeToString(acceptedAt!)}';
    if (status == SubOrderStatus.delivered) return '${S.of(context).order_delivered_date}:\n${fromOrderDateTimeToString(deliveredAt!)}';
    if (status == SubOrderStatus.taken) return '${S.of(context).order_driverAssigned_date}:\n${fromOrderDateTimeToString(driverAssignedAt!)}';
    if (status == SubOrderStatus.onTheWay) return '${S.of(context).order_pickedUp_date}:\n${fromOrderDateTimeToString(pickedUpAt!)}';
    return '';
  }

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    var ic = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer;

    return ic.asUint8List();
  }

  //?============================================ Date & Time helpers ============================================

  static String fromDateTimeToString(DateTime dateTime) => DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR}").format(dateTime);

  static String fromOrderDateTimeToString(DateTime dateTime) =>
      DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR} - ").add_Hm().format(dateTime);

  static String fromTimeToString(DateTime dateTime) => DateFormat.Hm().format(dateTime);

  static String timeOfDayToString(TimeOfDay time) => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

  ///Converts from [TimeOfDay] to [DateTime]
  static DateTime timeOfDayToDateTime(TimeOfDay timeOfDay) => DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
}
