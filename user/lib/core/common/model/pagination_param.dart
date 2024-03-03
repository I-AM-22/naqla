class PaginationParam {
  final int pageNumber;

  final int pageSize;

  PaginationParam({
    required this.pageNumber,
     this.pageSize =20,
  });

  Map<String, dynamic> get toJson => {
    "PageNumber": pageNumber,
    "PageSize": pageSize,
  };
}