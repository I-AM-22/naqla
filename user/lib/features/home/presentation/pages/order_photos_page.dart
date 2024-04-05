import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';

import '../../../../generated/l10n.dart';

class OrderPhotosPage extends StatefulWidget {
  const OrderPhotosPage({super.key});

  static String get path => "OrderPhotosPage";

  static String get name => "OrderPhotosPage";

  @override
  State<OrderPhotosPage> createState() => _OrderPhotosPageState();
}

class _OrderPhotosPageState extends State<OrderPhotosPage> {
  final HomeBloc bloc = getIt<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).new_naqla),
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                13.verticalSpace,
                AppText.bodyLarge("يرجى إلتقاط صور للإغراض التي سيتم نقلها للمساعدة بالعثور على سيارة (او عدة سيارات) مناسبة."),
                19.verticalSpace,
                AppButton.gray(
                  title: "إضافة صورة +",
                  onPressed: () {
                    bloc.add(PickPhotosOrder(context: context));
                  },
                ),
                16.verticalSpace,
                Expanded(
                  child: AppCommonStateBuilder<HomeBloc, List<String>>(
                    index: HomeState.uploadPhotos,
                    onInit: const SizedBox(),
                    onSuccess: (data) => ListView.separated(
                        itemBuilder: (context, index) => Image(
                              image: NetworkImage(data[index]),
                              fit: BoxFit.contain,
                            ),
                        separatorBuilder: (context, index) => 10.verticalSpace,
                        itemCount: data.length),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
