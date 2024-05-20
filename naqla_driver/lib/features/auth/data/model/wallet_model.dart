class WalletModel {
  final String id;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final int total;
  final int pending;
  final int available;

  WalletModel({
    required this.id,
    // required this.createdAt,
    // required this.updatedAt,
    required this.total,
    required this.pending,
    required this.available,
  });

  WalletModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? total,
    int? pending,
    int? available,
  }) =>
      WalletModel(
        id: id ?? this.id,
        // createdAt: createdAt ?? this.createdAt,
        // updatedAt: updatedAt ?? this.updatedAt,
        total: total ?? this.total,
        pending: pending ?? this.pending,
        available: available ?? this.available,
      );

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json["id"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        total: json["total"],
        pending: json["pending"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        "total": total,
        "pending": pending,
        "available": available,
      };
}
