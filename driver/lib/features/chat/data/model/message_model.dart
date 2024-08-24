class MessageModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;
  final bool isUser;

  MessageModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
    required this.isUser,
  });

  MessageModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? content,
    bool? isUser,
  }) =>
      MessageModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        content: content ?? this.content,
        isUser: isUser ?? this.isUser,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        content: json["content"],
        isUser: json["isUser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "content": content,
        "isUser": isUser,
      };
}
