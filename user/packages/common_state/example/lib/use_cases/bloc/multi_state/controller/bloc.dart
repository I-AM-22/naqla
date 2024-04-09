import 'package:common_state/common_state.dart';
import 'package:example/models/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/utils.dart';

part 'event.dart';
part 'state.dart';

class MultiStateBloc extends Bloc<CommonStateEvent, MultiStateBlocState> {
  MultiStateBloc() : super(MultiStateBlocState()) {
    // Use this
    multiStateApiCall<Fetch, String>('state1', (event) => someUseCase());

    multiStatePaginatedApiCall<FetchPagination, SomPaginatedData>(
      'state3Pagination',
      (event) => somePaginationUseCase(event.pageKey),
      (event) => event.pageKey,
    );

    on<UpdateSomeProperty>((event, emit) {
      emit(state.copyWith(someProperty: event.newValue));
    });

    on<UpdateExampleProperty>((event, emit) {
      emit(state.copyWith(exampleProperty: event.newExampleProperty));
    });
  }

  Future<Either<CustomErrorType, String>> someUseCase() {
    return Future.delayed(const Duration(seconds: 2), () {
      return const Right('success');
    });
  }

  Future<Either<CustomErrorType, SomPaginatedData>> somePaginationUseCase(int pageKey) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return Right(
          SomPaginatedData(
            1,
            PaginationModel(
              pageNumber: pageKey,
              totalPages: 3,
              totalDataCount: 15,
              data: ['Paged data', 'Paged data', 'Paged data', 'Paged data', 'Paged data'],
            ),
          ),
        );
      },
    );
  }
}
