class PhotoModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String blurHash;
  final String profileUrl;
  final String mobileUrl;
  final String webUrl;

  PhotoModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.blurHash,
    required this.profileUrl,
    required this.mobileUrl,
    required this.webUrl,
  });

  PhotoModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? blurHash,
    String? profileUrl,
    String? mobileUrl,
    String? webUrl,
  }) =>
      PhotoModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        blurHash: blurHash ?? this.blurHash,
        profileUrl: profileUrl ?? this.profileUrl,
        mobileUrl: mobileUrl ?? this.mobileUrl,
        webUrl: webUrl ?? this.webUrl,
      );

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        blurHash: json["blurHash"],
        profileUrl: json["profileUrl"],
        mobileUrl: json["mobileUrl"],
        webUrl: json["webUrl"],
      );

  Map<String, dynamic> get toJson => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "blurHash": blurHash,
        "profileUrl": profileUrl,
        "mobileUrl": mobileUrl,
        "webUrl": webUrl,
      };
}
