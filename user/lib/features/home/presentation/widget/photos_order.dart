import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/media_form_field.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/generated/l10n.dart';

class PhotosOrder extends StatelessWidget {
  const PhotosOrder({super.key, required this.formKey, required this.bloc});
  final GlobalKey<FormBuilderState> formKey;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, int>(
      selector: (state) => state.formCount,
      builder: (context, state) {
        return Expanded(
          child: FormBuilder(
            key: formKey,
            child: ListView.separated(
              itemCount: state,
              separatorBuilder: (context, index) => 10.verticalSpace,
              itemBuilder: (context, index) => Container(
                padding: REdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.colorScheme.outline)),
                child: Column(
                  children: [
                    if (state != 1)
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            bloc.add(UpdateFormPhoto(add: false));
                          },
                          icon: const Icon(IconlyLight.delete),
                          color: context.colorScheme.error,
                        ),
                      ),
                    10.verticalSpace,
                    MediaFormField(
                      height: 200.h,
                      title: S.of(context).select_photo,
                      placeHolderDecoration: BoxDecoration(
                          border:
                              Border.all(color: context.colorScheme.primary),
                          borderRadius: BorderRadius.circular(8)),
                      name: 'photo$index',
                      validator: FormBuilderValidators.required(
                          errorText: S.of(context).this_field_is_required),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            validator: FormBuilderValidators.required(
                                errorText:
                                    S.of(context).this_field_is_required),
                            name: 'width$index',
                            title: S.of(context).item_width,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        5.horizontalSpace,
                        Expanded(
                          child: AppTextFormField(
                            validator: FormBuilderValidators.required(
                                errorText:
                                    S.of(context).this_field_is_required),
                            name: 'weight$index',
                            title: S.of(context).item_weight,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        5.horizontalSpace,
                        Expanded(
                          child: AppTextFormField(
                            validator: FormBuilderValidators.required(),
                            name: 'length$index',
                            title: S.of(context).item_length,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
    );
  }
}
