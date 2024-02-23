class PaginationModel<T> {
  final int pageNumber;
  final int totalPages;
  final int totalDataCount;
  final List<T> data;

  PaginationModel({
    required this.pageNumber,
    required this.totalPages,
    required this.totalDataCount,
    required this.data,
  });

  factory PaginationModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) tFromJson) {
    return PaginationModel(
      pageNumber: json['pageNumber'] as int,
      totalPages: json['totalPages'] as int,
      totalDataCount: json['totalDataCount'] as int,
      data: (json['data'] as List).map((e) => tFromJson(e)).toList(),
    );
  }
}
