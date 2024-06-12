class PaymentModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? cost;
  final int? additionalCost;
  final DateTime? deliveredDate;
  final int? total;

  PaymentModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.cost,
    required this.additionalCost,
    required this.deliveredDate,
    required this.total,
  });

  PaymentModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? cost,
    int? additionalCost,
    dynamic deliveredDate,
    int? total,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        cost: cost ?? this.cost,
        additionalCost: additionalCost ?? this.additionalCost,
        deliveredDate: deliveredDate ?? this.deliveredDate,
        total: total ?? this.total,
      );

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        createdAt: DateTime.tryParse(json["createdAt"] ?? ''),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? ''),
        cost: json["cost"],
        additionalCost: json["additionalCost"],
        deliveredDate: DateTime.tryParse(json["deliveredDate"] ?? ''),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "cost": cost,
        "additionalCost": additionalCost,
        "deliveredDate": deliveredDate?.toIso8601String(),
        "total": total,
      };
}
