class LocationModel {
  final String region;
  final String street;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.region,
    required this.street,
    required this.latitude,
    required this.longitude,
  });

  LocationModel copyWith({
    String? region,
    String? street,
    double? latitude,
    double? longitude,
  }) =>
      LocationModel(
        region: region ?? this.region,
        street: street ?? this.street,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        region: json["region"],
        street: json["street"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "region": region,
        "street": street,
        "latitude": latitude,
        "longitude": longitude,
      };
}
