import 'package:flutter/material.dart';
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
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/presentation/pages/add_car_page.dart';
import 'package:naqla_driver/features/home/presentation/state/home_bloc.dart';
import 'package:naqla_driver/generated/l10n.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import 'order_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String path = "/HomePage";
  static String name = "/HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc bloc = getIt<HomeBloc>();
  @override
  void initState() {
    bloc.add(GetSubOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).home),
          back: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.pushNamed(AddCarPage.name);
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
        body: AppCommonStateBuilder<HomeBloc, List<SubOrderModel>>(
          stateName: HomeState.subOrders,
          onSuccess: (data) {
            return ListView.separated(
              separatorBuilder: (context, index) => 16.verticalSpace,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding20, horizontal: UIConstants.screenPadding16),
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(OrderDetailsPage.name, extra: data[index]);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: context.colorScheme.outline.withOpacity(.4),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: context.colorScheme.outline)),
                                    padding: REdgeInsets.all(10),
                                    child: AppText.subHeadRegular(data[index].status.name)),
                                10.verticalSpace,
                                AppText.subHeadRegular('الوزن: ${data[index].weight.toString()}'),
                                10.verticalSpace,
                                AppText.subHeadRegular('الكلفة: ${data[index].cost.toString()}'),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Stack(
                            children: [
                              SizedBox(
                                  height: 150.h,
                                  width: 150.w,
                                  child:
                                      BlurHash(imageFit: BoxFit.cover, hash: data[index].photos[0].blurHash, image: data[index].photos[0].mobileUrl)),
                              if (data[index].photos.length > 1)
                                Container(
                                  color: context.colorScheme.primary.withOpacity(.5),
                                  child: SizedBox(
                                    width: 150.w,
                                    height: 150.w,
                                    child: Center(
                                        child: AppText.titleMedium(
                                      '+${data[index].photos.length - 1}',
                                      color: Colors.white,
                                    )),
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
