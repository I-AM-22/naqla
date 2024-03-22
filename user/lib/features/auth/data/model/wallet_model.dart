class Wallet {
  final String id;
  final int total;
  final int pending;
  final int available;

  Wallet({
    required this.id,
    required this.total,
    required this.pending,
    required this.available,
  });

  Wallet copyWith({
    String? id,
    int? total,
    int? pending,
    int? available,
  }) =>
      Wallet(
        id: id ?? this.id,
        total: total ?? this.total,
        pending: pending ?? this.pending,
        available: available ?? this.available,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        total: json["total"],
        pending: json["pending"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "pending": pending,
        "available": available,
      };
}
