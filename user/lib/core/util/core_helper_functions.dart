import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:naqla/core/common/enums/sub_order_status.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/auth/presentation/pages/sign_in_page.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';
import 'package:naqla/features/profile/presentation/state/bloc/profile_bloc.dart';
import '../../features/app/domain/repository/prefs_repository.dart';
import '../../features/app/presentation/widgets/animated_dialog.dart';
import '../../generated/l10n.dart';
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
                      await getIt.resetLazySingleton<HomeBloc>();
                      await getIt.resetLazySingleton<OrderBloc>();
                      await getIt.resetLazySingleton<ProfileBloc>();
                      if (!context.mounted) return;
                      context.goNamed(SignInPage.name, extra: true);
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
      {DateTime? acceptedAt, DateTime? deliveredAt, DateTime? driverAssignedAt, DateTime? pickedUpAt}) {
    if (status == SubOrderStatus.ready && acceptedAt != null) {
      return '${S.of(context).order_accepted_date}:\n ${fromOrderDateTimeToString(acceptedAt)}';
    } else if (status == SubOrderStatus.delivered && deliveredAt != null) {
      return '${S.of(context).order_delivered_date}:\n ${fromOrderDateTimeToString(deliveredAt)}';
    } else if (status == SubOrderStatus.taken && driverAssignedAt != null) {
      return '${S.of(context).order_driverAssigned_date}:\n ${fromOrderDateTimeToString(driverAssignedAt)}';
    } else if (status == SubOrderStatus.onTheWay && pickedUpAt != null) {
      return '${S.of(context).order_pickedUp_date}:\n ${fromOrderDateTimeToString(pickedUpAt)}';
    } else {
      return '';
    }
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

  static String getTitleButton(BuildContext context, {DateTime? arrivedAt, DateTime? driverAssignedAt}) {
    if (arrivedAt != null) return S.of(context).set_order_picked_up;
    if (driverAssignedAt != null) return S.of(context).driver_arrived;
    return '';
  }

  //?============================================ Date & Time helpers ============================================

  static String fromDateTimeToString(DateTime dateTime) =>
      DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR}").format(dateTime.toLocal());

  static String fromOrderDateTimeToString(DateTime dateTime) =>
      DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR} - ").add_jm().format(dateTime.toLocal());

  static String fromMessageDateTimeToString(DateTime dateTime) => DateFormat().add_jm().format(dateTime.toLocal());

  static String fromTimeToString(DateTime dateTime) => DateFormat.Hm().format(dateTime.toLocal());

  static String formatDateChat(DateTime date, BuildContext context) {
    final DateTime dateTime = DateTime.now();
    DateTime yesterday = dateTime.subtract(const Duration(days: 1));
    if (DateFormat('d MMMM y').format(date) == DateFormat('d MMMM y').format(yesterday)) {
      return S.of(context).yesterday;
    } else if (DateFormat('d MMMM y').format(date) != DateFormat('d MMMM y').format(dateTime)) {
      return DateFormat('d MMMM y').format(date);
    } else {
      return S.of(context).today;
    }
  }

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
