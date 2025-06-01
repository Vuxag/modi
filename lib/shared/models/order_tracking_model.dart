import 'package:json_annotation/json_annotation.dart';

part 'order_tracking_model.g.dart';

@JsonSerializable()
class OrderTracking {
  final String id;
  final String bookingId;
  final String status; // PENDING, ACCEPTED, IN_PROGRESS, COMPLETED, CANCELLED
  final String? providerId;
  final String? providerName;
  final String? providerPhone;
  final double? providerLatitude;
  final double? providerLongitude;
  final DateTime? estimatedArrivalTime;
  final DateTime? actualArrivalTime;
  final DateTime? completionTime;
  final String? cancellationReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderTracking({
    required this.id,
    required this.bookingId,
    required this.status,
    this.providerId,
    this.providerName,
    this.providerPhone,
    this.providerLatitude,
    this.providerLongitude,
    this.estimatedArrivalTime,
    this.actualArrivalTime,
    this.completionTime,
    this.cancellationReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderTracking.fromJson(Map<String, dynamic> json) =>
      _$OrderTrackingFromJson(json);
  Map<String, dynamic> toJson() => _$OrderTrackingToJson(this);
}
