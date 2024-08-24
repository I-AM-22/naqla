import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:badges/badges.dart' as badges;
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/home/presentation/state/home_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../cars/data/model/car_model.dart';

class CarsCard extends StatefulWidget {
  const CarsCard({super.key, required this.onSelected, required this.id});
  final Function(CarModel?) onSelected;
  final String id;

  @override
  State<CarsCard> createState() => _CarsCardState();
}

class _CarsCardState extends State<CarsCard> {
  final ValueNotifier<CarModel?> isSelected = ValueNotifier(null);
  @override
  void initState() {
    context.read<HomeBloc>().add(GetOrderCarEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCommonStateBuilder<HomeBloc, List<CarModel>>(
      stateName: HomeState.orderCars,
      onEmpty: Center(child: AppText.subHeadMedium(S.of(context).there_is_nothing_to_show)),
      onSuccess: (data) {
        return ListView.separated(
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
                        child: Center(
                          child: AppImage.network(
                            data[index].photo.mobileUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => 10.horizontalSpace,
            itemCount: data.length);
      },
    );
  }
}
