import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/core/util/media_form_field.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/domain/use_case/set_order_use_case.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';

import '../../../../generated/l10n.dart';
import 'home_page.dart';

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
          bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 10),
                child: AppButton.dark(
                  isLoading: state.getState(HomeState.setOrder).isLoading,
                  title: S.of(context).next,
                  onPressed: () {
                    _key.currentState?.save();
                    _key.currentState?.validate();
                    if (_key.currentState?.isValid ?? false) {
                      context.read<HomeBloc>().add(SetOrderParamEvent(
                              items: List<OrderItemsParam>.generate(
                            state.formCount,
                            (index) => OrderItemsParam(
                                photo: _key.currentState?.value['$photo$index'],
                                width: _key.currentState?.value['$width$index'],
                                length: _key.currentState?.value['$length$index'],
                                weight: _key.currentState?.value['$weight$index']),
                          )));
                      context.read<HomeBloc>().add(SetOrderEvent(
                        onSuccess: () {
                          context.goNamed(HomePage.name, extra: false);
                        },
                      ));
                    }
                  },
                ),
              );
            },
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                13.verticalSpace,
                AppText.bodyLarge(S.of(context).please_take_photos_of_the_items_to_be_transported),
                16.verticalSpace,
                BlocSelector<HomeBloc, HomeState, int>(
                  selector: (state) => state.formCount,
                  builder: (context, state) {
                    return Expanded(
                      child: FormBuilder(
                        key: _key,
                        child: ListView.separated(
                          itemCount: state,
                          separatorBuilder: (context, index) => 10.verticalSpace,
                          itemBuilder: (context, index) => Container(
                            padding: REdgeInsets.all(8),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.colorScheme.outline)),
                            child: Column(
                              children: [
                                if (state != 1)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        bloc.add(UpdateFormPhoto(add: false));
                                      },
                                      icon: Icon(IconlyLight.delete),
                                      color: context.colorScheme.error,
                                    ),
                                  ),
                                10.verticalSpace,
                                MediaFormField(
                                  height: 200.h,
                                  title: S.of(context).select_photo,
                                  placeHolderDecoration:
                                      BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
                                  name: '$photo$index',
                                  validator: FormBuilderValidators.required(),
                                ),
                                10.verticalSpace,
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextFormField(
                                        validator: FormBuilderValidators.required(),
                                        name: '$width$index',
                                        title: S.of(context).item_width,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                      ),
                                    ),
                                    5.horizontalSpace,
                                    Expanded(
                                      child: AppTextFormField(
                                        validator: FormBuilderValidators.required(),
                                        name: '$weight$index',
                                        title: S.of(context).item_weight,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                      ),
                                    ),
                                    5.horizontalSpace,
                                    Expanded(
                                      child: AppTextFormField(
                                        validator: FormBuilderValidators.required(),
                                        name: '$length$index',
                                        title: S.of(context).item_length,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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

  String get photo => "photo";
  String get width => "width";
  String get weight => "weight";
  String get length => "length";
}
