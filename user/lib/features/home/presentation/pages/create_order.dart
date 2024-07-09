import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/core/global_widgets/app_date_picker.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/widget/first_step_create_order_button.dart';
import 'package:naqla/features/home/presentation/widget/end_location_card.dart';
import 'package:naqla/features/home/presentation/widget/order_advantages.dart';
import 'package:naqla/features/home/presentation/widget/porters_widget.dart';
import 'package:naqla/features/home/presentation/widget/start_location_card.dart';

import '../../../../generated/l10n.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  static const String path = "CreateOrderPage";
  static const String name = "CreateOrderPage";

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  bool porters = false;
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  final HomeBloc _bloc = getIt<HomeBloc>();
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    _bloc.add(GetCarAdvantageEvent());
    super.initState();
  }

  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: AppScaffold(
        bottomNavigationBar: FirstStepCreateOrderButton(
          currentValue: _currentValue,
          dateTime: dateTime,
          formKey: _key,
          porters: porters,
        ),
        appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).new_naqla)),
        body: SingleChildScrollView(
          padding:
              REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
          child: FormBuilder(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StartLocationCard(),
                16.verticalSpace,
                const EndLocationCard(),
                16.verticalSpace,
                AppDatePicker(
                  title: S.of(context).order_delivered_date,
                  validator: FormBuilderValidators.required(
                      errorText: S.of(context).this_field_is_required),
                  name: 'date',
                  onDateTimeChanged: (p0) => dateTime = p0,
                  minimumDate: DateTime.now(),
                ),
                20.verticalSpace,
                PortersWidget(
                  onChange: (p0, value) {
                    _currentValue = p0;
                    porters = value;
                  },
                ),
                18.verticalSpace,
                AppText.bodySmMedium(
                  S.of(context).additional_specifications_of_the_car,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                const OrderAdvantages()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
