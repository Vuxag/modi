import 'package:json_annotation/json_annotation.dart';

part 'promotion_model.g.dart';

@JsonSerializable()
class Promotion {
  final String id;
  final String code;
  final String title;
  final String description;
  final double discountAmount;
  final String discountType; // PERCENTAGE or FIXED_AMOUNT
  final DateTime startDate;
  final DateTime endDate;
  final int? usageLimit;
  final int usageCount;
  final bool isActive;
  final List<String>? applicableServiceIds;
  final double? minimumOrderAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Promotion({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountAmount,
    required this.discountType,
    required this.startDate,
    required this.endDate,
    this.usageLimit,
    required this.usageCount,
    required this.isActive,
    this.applicableServiceIds,
    this.minimumOrderAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}
