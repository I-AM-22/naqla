import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/cars/presentation/state/cars_bloc.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/cars/presentation/pages/add_car_page.dart';
import 'package:naqla_driver/features/cars/presentation/widgets/cars_section.dart';

import '../../../../generated/l10n.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});
  static String path = "/CarsPage";

  static String name = "CarsPage";

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final CarsBloc bloc = getIt<CarsBloc>();
  final ScrollController _hideButtonController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    bloc.add(GetAllCarsEvent());
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection == ScrollDirection.forward) {
          if (!_isVisible) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: AppScaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Visibility(
            visible: _isVisible,
            child: FloatingActionButton.extended(
              onPressed: () {
                context.pushNamed(AddCarPage.name, extra: AddCaraParam(bloc: bloc));
              },
              icon: const Icon(
                IconlyBroken.plus,
                color: Colors.white,
              ),
              backgroundColor: context.colorScheme.primary,
              label: AppText.labelMedium(
                S.of(context).add_car,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).cars),
            back: false,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              bloc.add(GetAllCarsEvent());
            },
            child: AppCommonStateBuilder<CarsBloc, List<CarModel>>(
              stateName: CarsState.getAllCars,
              onSuccess: (data) => ListView.separated(
                  controller: _hideButtonController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: context.colorScheme.primary.withOpacity(.2), blurRadius: 10, offset: const Offset(0, 2))],
                      ),
                      child: CarsSection(
                        carModel: data[index],
                        bloc: bloc,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemCount: data.length),
            ),
          )),
    );
  }
}
