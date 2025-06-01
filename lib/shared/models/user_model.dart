import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String phone;
  final String fullName;
  final String? avatar;
  final String role; // 'user', 'provider', 'admin'
  final double? rating;
  final int? totalRatings;
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.fullName,
    this.avatar,
    required this.role,
    this.rating,
    this.totalRatings,
    this.address,
    this.latitude,
    this.longitude,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
