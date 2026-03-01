import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    this.phoneNumber,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final String? phoneNumber;
  final String? profileImage;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get fullName => '$firstName $lastName';

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
    String? phoneNumber,
    String? profileImage,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        createdAt: createdAt ?? this.createdAt,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profileImage: profileImage ?? this.profileImage,
      );
}
