class DriverInfo {
  final String firstName;
  final String lastName;

  DriverInfo({required this.firstName, required this.lastName});

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(firstName: json['firstName'], lastName: json['lastName']);
  }
}
