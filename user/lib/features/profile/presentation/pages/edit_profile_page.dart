import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/profile/domain/use_cases/edit_personal_info_use_case.dart';

import '../../../../core/api/api_utils.dart';
import '../../../../core/common/constants/constants.dart';
import '../../../../core/di/di_container.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../app/presentation/widgets/customer_appbar.dart';
import '../../../app/presentation/widgets/params_appbar.dart';
import '../../../auth/data/model/auth_model.dart';
import '../state/bloc/profile_bloc.dart';

class EditProfileParam {
  final ProfileBloc bloc;
  final User user;

  EditProfileParam({required this.bloc, required this.user});
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.param});
  final EditProfileParam param;

  static String name = 'EditProfilePage';
  static String path = 'EditProfilePage';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final ProfileBloc bloc;
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  String photo = '';
  @override
  void initState() {
    bloc = widget.param.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(
            title: S.of(context).edit_profile,
          ),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding30, horizontal: UIConstants.screenPadding16),
          child: FormBuilder(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        AppCommonStateBuilder<ProfileBloc, String>(
                          index: ProfileState.uploadSinglePhoto,
                          onInit: Container(
                            clipBehavior: Clip.hardEdge,
                            width: 138.w,
                            height: 138.w,
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.colorScheme.primary)),
                            child:
                                BlurHash(imageFit: BoxFit.cover, hash: widget.param.user.photo.blurHash, image: widget.param.user.photo.profileUrl),
                          ),
                          onSuccess: (data) {
                            photo = data;
                            return Container(
                              clipBehavior: Clip.hardEdge,
                              width: 138.w,
                              height: 138.w,
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.colorScheme.primary)),
                              child: Image(
                                image: NetworkImage(data),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return RSizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppButton.ghost(
                                            title: 'camera',
                                            postfixIcon: AppImage.asset(Assets.icons.essential.camera.path),
                                            onPressed: () {
                                              bloc.add((PickImageEvent(
                                                ImageSource.camera,
                                                context,
                                                (p0) => context.pop(),
                                              )));
                                            },
                                          ),
                                          Divider(),
                                          AppButton.ghost(
                                            onPressed: () {
                                              bloc.add((PickImageEvent(
                                                ImageSource.gallery,
                                                context,
                                                (p0) => context.pop(),
                                              )));
                                            },
                                            title: 'gallery',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            margin: REdgeInsets.only(right: 10),
                            width: 25.h,
                            height: 25.h,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA), border: Border.all(color: context.colorScheme.primary), shape: BoxShape.circle),
                            child: Center(
                              child: AppImage.asset(
                                Assets.icons.essential.edit.path,
                                size: 15.r,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  AppTextFormField(
                    initialValue: widget.param.user.firstName,
                    name: 'firstName',
                    validator: FormBuilderValidators.required(),
                    keyboardType: TextInputType.name,
                  ),
                  24.verticalSpace,
                  AppTextFormField(
                    name: 'lastName',
                    title: S.of(context).last_name,
                    initialValue: widget.param.user.lastName,
                    validator: FormBuilderValidators.required(),
                    keyboardType: TextInputType.name,
                  ),
                  32.verticalSpace,
                  BlocSelector<ProfileBloc, Map<int, CommonState>, CommonState>(
                    selector: (state) => state[ProfileState.editPersonalInfo]!,
                    builder: (context, state) {
                      return AppButton.dark(
                        isLoading: state.isLoading(),
                        stretch: true,
                        title: S.of(context).Save,
                        onPressed: () {
                          _key.currentState?.save();
                          _key.currentState?.validate();
                          if (_key.currentState?.isValid ?? false) {
                            bloc.add(EditPersonalInfoEvent(
                                EditPersonalInfoParam(
                                    firstName: _key.currentState?.value['firstName'],
                                    lastName: _key.currentState?.value['lastName'],
                                    photo: photo), (p0) {
                              showMessage('edit successfully', isSuccess: true);
                              context.pop();
                            }));
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectImageOption extends StatelessWidget {
  const SelectImageOption({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }
}
