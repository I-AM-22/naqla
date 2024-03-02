import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';

import '../../../domain/use_cases/get_personal_info_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@LazySingleton()
class ProfileBloc extends Bloc<ProfileEvent, Map<int, CommonState>> {
  final GetPersonalInfoUseCase _personalInfoUseCase;
  ProfileBloc(this._personalInfoUseCase) : super(ProfileState.iniState) {
    on<GetPersonalInfoEvent>((event, emit) {
      return CoreHelperFunctions.handelMultiApiResult(
          callback: () async => _personalInfoUseCase(NoParams()),
          emit: emit,
          state: state,
          index: ProfileState.getPersonalInfo);
    });
  }
}
