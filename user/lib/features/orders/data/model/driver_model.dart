class DriverModel {
  final String firstName;
  final String lastName;

  DriverModel({required this.firstName, required this.lastName});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
        firstName: json['firstName'], lastName: json['lastName']);
  }
}
