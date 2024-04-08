class Photo {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String blurHash;
  final String profileUrl;
  final String mobileUrl;
  final String webUrl;

  Photo({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.blurHash,
    required this.profileUrl,
    required this.mobileUrl,
    required this.webUrl,
  });

  Photo copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? blurHash,
    String? profileUrl,
    String? mobileUrl,
    String? webUrl,
  }) =>
      Photo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        blurHash: blurHash ?? this.blurHash,
        profileUrl: profileUrl ?? this.profileUrl,
        mobileUrl: mobileUrl ?? this.mobileUrl,
        webUrl: webUrl ?? this.webUrl,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
        blurHash: json["blurHash"],
        profileUrl: json["profileUrl"],
        mobileUrl: json["mobileUrl"],
        webUrl: json["webUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "blurHash": blurHash,
        "profileUrl": profileUrl,
        "mobileUrl": mobileUrl,
        "webUrl": webUrl,
      };
}
