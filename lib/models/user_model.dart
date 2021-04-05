class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.dateOfBirth,
  });

  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;

  UserModel copyWith({
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
  }) =>
      UserModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"] as String),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
  };
}