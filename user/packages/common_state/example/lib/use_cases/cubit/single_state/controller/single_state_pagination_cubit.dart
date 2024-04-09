import 'package:common_state/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleStatePaginationCubit extends Cubit<PaginationState<PaginationModel, String>> {
  SingleStatePaginationCubit() : super(PaginationState());

  void fetch(int pageKey) => paginatedApiCall<PaginationModel, String>(
        () async {
          await Future.delayed(const Duration(seconds: 2));

          return Right(
            PaginationModel<String>(
              pageNumber: pageKey,
              totalPages: 1,
              totalDataCount: 3,
              data: List.generate(3, (index) => 'data'),
            ),
          );
        },
        pageKey,
      );
}
