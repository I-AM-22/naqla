class OrderPhotosModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String blurHash;
  final String profileUrl;
  final String mobileUrl;
  final String webUrl;
  final int weight;
  final int length;
  final int width;

  OrderPhotosModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.blurHash,
    required this.profileUrl,
    required this.mobileUrl,
    required this.webUrl,
    required this.weight,
    required this.length,
    required this.width,
  });

  OrderPhotosModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? blurHash,
    String? profileUrl,
    String? mobileUrl,
    String? webUrl,
    int? weight,
    int? length,
    int? width,
  }) =>
      OrderPhotosModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        blurHash: blurHash ?? this.blurHash,
        profileUrl: profileUrl ?? this.profileUrl,
        mobileUrl: mobileUrl ?? this.mobileUrl,
        webUrl: webUrl ?? this.webUrl,
        weight: weight ?? this.weight,
        length: length ?? this.length,
        width: width ?? this.width,
      );

  factory OrderPhotosModel.fromJson(Map<String, dynamic> json) => OrderPhotosModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        blurHash: json["blurHash"],
        profileUrl: json["profileUrl"],
        mobileUrl: json["mobileUrl"],
        webUrl: json["webUrl"],
        weight: json["weight"],
        length: json["length"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "blurHash": blurHash,
        "profileUrl": profileUrl,
        "mobileUrl": mobileUrl,
        "webUrl": webUrl,
        "weight": weight,
        "length": length,
        "width": width,
      };
}
