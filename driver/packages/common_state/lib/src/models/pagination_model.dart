import 'package:common_state/src/models/base_pagination.dart';

class PaginationModel<T> implements BasePagination<T> {
  final int? pageNumber;
  final int? totalPages;
  final int? totalDataCount;
  final List<T> data;

  PaginationModel({
    required this.data,
    this.pageNumber,
    this.totalPages,
    this.totalDataCount,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json, T Function(dynamic json) tFromJson) {
    return PaginationModel(
      pageNumber: json['pageNumber'],
      totalPages: json['totalPages'],
      totalDataCount: json['totalDataCount'],
      data: json['data'] is List ? (json['data'] as List).map((e) => tFromJson(e)).toList() : [],
    );
  }
}
