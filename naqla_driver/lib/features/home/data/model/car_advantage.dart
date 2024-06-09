class CarAdvantage {
  final String id;
  final String name;
  final String cost;
  final bool isSelect;

  CarAdvantage({
    required this.id,
    required this.name,
    required this.cost,
    required this.isSelect,
  });

  CarAdvantage copyWith({
    String? id,
    String? name,
    String? cost,
    bool? isSelect,
  }) =>
      CarAdvantage(
        id: id ?? this.id,
        name: name ?? this.name,
        cost: cost ?? this.cost,
        isSelect: isSelect ?? this.isSelect,
      );

  factory CarAdvantage.fromJson(Map<String, dynamic> json) => CarAdvantage(
        id: json["id"],
        name: json["name"],
        cost: json["cost"],
        isSelect: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
      };
}
