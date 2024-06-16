class CarAdvantage {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String cost;
  final bool isSelect;

  CarAdvantage({
    required this.id,
    required this.name,
    required this.cost,
    required this.isSelect,
    required this.updatedAt,
    required this.createdAt,
  });

  CarAdvantage copyWith({
    String? id,
    String? name,
    String? cost,
    bool? isSelect,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CarAdvantage(
        id: id ?? this.id,
        name: name ?? this.name,
        cost: cost ?? this.cost,
        isSelect: isSelect ?? this.isSelect,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CarAdvantage.fromJson(Map<String, dynamic> json, bool isSelect) => CarAdvantage(
        id: json["id"],
        name: json["name"],
        cost: json["cost"] ?? '0',
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse(json["updatedAt"]),
        isSelect: isSelect,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
