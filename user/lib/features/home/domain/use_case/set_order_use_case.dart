import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/location_model.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';

@injectable
class SetOrderUseCase extends UseCase<OrderModel, SetOrderParam> {
  final HomeRepository _repository;

  SetOrderUseCase(this._repository);
  @override
  FutureResult<OrderModel> call(SetOrderParam params) {
    return _repository.setOrder(params);
  }
}

class SetOrderParam {
  final String desiredDate;
  final LocationModel locationStart;
  final LocationModel locationEnd;
  final int porters;
  final List<OrderItemsParam> items;
  final List<String>? advantages;

  SetOrderParam(
      {required this.desiredDate,
      required this.locationStart,
      required this.locationEnd,
      required this.porters,
      required this.items,
      required this.advantages});

  SetOrderParam copyWith(
    final String? desiredDate,
    final LocationModel? locationStart,
    final LocationModel? locationEnd,
    final int? porters,
    final List<OrderItemsParam>? items,
    final List<String>? advantages,
  ) =>
      SetOrderParam(
        desiredDate: desiredDate ?? this.desiredDate,
        locationStart: locationStart ?? this.locationStart,
        locationEnd: locationEnd ?? this.locationEnd,
        porters: porters ?? this.porters,
        items: items ?? this.items,
        advantages: advantages ?? this.advantages,
      );

  factory SetOrderParam.empty() => SetOrderParam(
        desiredDate: "",
        locationStart: LocationModel(latitude: 0, longitude: 0, region: "", street: ""),
        locationEnd: LocationModel(latitude: 0, longitude: 0, region: "", street: ""),
        porters: 0,
        items: [],
        advantages: [],
      );

  Map<String, dynamic> get toMap => {
        "desiredDate": desiredDate,
        "locationStart": locationStart.toJson(),
        "locationEnd": locationEnd.toJson(),
        "items": items
            .map(
              (e) => e.toMap,
            )
            .toList(),
        "porters": porters,
        "advantages": advantages ?? [],
      };
}

class OrderItemsParam {
  final String photo;
  final String width;
  final String length;
  final String weight;

  OrderItemsParam({required this.photo, required this.width, required this.length, required this.weight});

  Map<String, dynamic> get toMap => {
        "photo": photo,
        "weight": weight,
        "length": length,
        "width": width,
      };
}
