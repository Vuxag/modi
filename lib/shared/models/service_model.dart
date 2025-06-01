import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class Service {
  final String id;
  final String providerId;
  final String title;
  final String description;
  final String category;
  final List<String> images;
  final double price;
  final String currency;
  final String unit; // 'hour', 'day', 'service'
  final double? rating;
  final int? totalRatings;
  final bool isAvailable;
  final List<String>? tags;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  Service({
    required this.id,
    required this.providerId,
    required this.title,
    required this.description,
    required this.category,
    required this.images,
    required this.price,
    required this.currency,
    required this.unit,
    this.rating,
    this.totalRatings,
    required this.isAvailable,
    this.tags,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
