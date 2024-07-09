import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/widget/last_step_create_order_button.dart';
import 'package:naqla/features/home/presentation/widget/photos_order.dart';

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
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).new_naqla),
          ),
          bottomNavigationBar: LastStepCreateOrderButton(
            formKey: _key,
          ),
          body: Padding(
            padding:
                REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                13.verticalSpace,
                AppText.bodyLarge(S
                    .of(context)
                    .please_take_photos_of_the_items_to_be_transported),
                16.verticalSpace,
                PhotosOrder(formKey: _key, bloc: bloc),
                19.verticalSpace,
                AppButton.gray(
                  title: "${S.of(context).add_photo} +",
                  onPressed: () {
                    bloc.add(UpdateFormPhoto(add: true));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
