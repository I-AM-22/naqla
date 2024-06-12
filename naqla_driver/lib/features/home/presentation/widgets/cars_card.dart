import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/state/bloc/app_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import '../../data/model/car_model.dart';

class CarsCard extends StatefulWidget {
  const CarsCard({super.key, required this.onSelected});
  final Function(CarModel?) onSelected;

  @override
  State<CarsCard> createState() => _CarsCardState();
}

class _CarsCardState extends State<CarsCard> {
  final ValueNotifier<CarModel?> isSelected = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return AppCommonStateBuilder<AppBloc, List<CarModel>>(
      stateName: AppState.getAllCars,
      onSuccess: (data) {
        return Expanded(
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: isSelected,
                  builder: (context, value, _) => SizedBox(
                    height: 200.h,
                    width: 200.w,
                    child: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: value?.id == data[index].id,
                      ignorePointer: false,
                      badgeContent: const Icon(Icons.check, color: Colors.white, size: 10),
                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: context.colorScheme.primary,
                        padding: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(4),
                        elevation: 0,
                      ),
                      child: InkWell(
                        onTap: () {
                          isSelected.value = data[index];
                          widget.onSelected(isSelected.value);
                        },
                        child: Container(
                          height: 150.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.colorScheme.outline)),
                          child: BlurHash(
                            hash: data[index].photo.blurHash,
                            image: data[index].photo.mobileUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 10.horizontalSpace,
              itemCount: data.length),
        );
      },
    );
  }
}
