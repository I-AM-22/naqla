import 'dart:ui' as ui;

import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/presentation/pages/login_page.dart';
import 'package:naqla_driver/features/home/presentation/state/home_bloc.dart';
import 'package:naqla_driver/features/profile/presentation/state/profile_bloc.dart';
import '../../features/app/domain/repository/prefs_repository.dart';
import '../../features/app/presentation/widgets/animated_dialog.dart';
import '../../features/cars/presentation/state/cars_bloc.dart';
import '../../generated/l10n.dart';
import '../common/constants/constants.dart';
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
                      await getIt.resetLazySingleton<HomeBloc>();
                      await getIt.resetLazySingleton<ProfileBloc>();
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

  static void deleteCar(BuildContext context, String id, CarsBloc bloc) => AnimatedDialog.show(context,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding20),
        child: BlocProvider.value(
          value: bloc,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.subHeadRegular(S.of(context).delete_car),
              16.verticalSpace,
              AppText.subHeadMedium(S.of(context).are_you_sure_delete_this_car),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: AppButton.dark(
                    title: S.of(context).no,
                    onPressed: () {
                      context.pop();
                    },
                  )),
                  5.horizontalSpace,
                  Expanded(
                      child: BlocSelector<CarsBloc, CarsState, CommonState>(
                    selector: (state) => state.getState(CarsState.deleteCar),
                    builder: (context, state) {
                      return AppButton.gray(
                        isLoading: state.isLoading,
                        title: S.of(context).yes,
                        textStyle: TextStyle(color: context.colorScheme.error),
                        onPressed: () {
                          context.read<CarsBloc>().add(DeleteCarEvent(
                                id: id,
                                onSuccess: () => context.pop(),
                              ));
                        },
                      );
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ));

  static String formatOrderTime(BuildContext context, SubOrderStatus status,
      {DateTime? acceptedAt, DateTime? deliveredAt, DateTime? driverAssignedAt, DateTime? pickedUpAt}) {
    if (status == SubOrderStatus.ready && acceptedAt != null) {
      return '${S.of(context).order_accepted_date}:\n${fromOrderDateTimeToString(acceptedAt)}';
    }
    if (status == SubOrderStatus.delivered && deliveredAt != null) {
      return '${S.of(context).order_delivered_date}:\n${fromOrderDateTimeToString(deliveredAt)}';
    }
    if (status == SubOrderStatus.taken && driverAssignedAt != null) {
      return '${S.of(context).order_driverAssigned_date}:\n${fromOrderDateTimeToString(driverAssignedAt)}';
    }
    if (status == SubOrderStatus.onTheWay && pickedUpAt != null) {
      return '${S.of(context).order_pickedUp_date}:\n${fromOrderDateTimeToString(pickedUpAt)}';
    }
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

  static String fromDateTimeToString(DateTime dateTime) =>
      DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR}").format(dateTime.toLocal());

  static String fromOrderDateTimeToString(DateTime dateTime) =>
      DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR} - ").add_jm().format(dateTime.toLocal());

  static String fromMessageDateTimeToString(DateTime dateTime) => DateFormat().add_jm().format(dateTime.toLocal());

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

  static String fromTimeToString(DateTime dateTime) => DateFormat.Hm().format(dateTime.toLocal());

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
