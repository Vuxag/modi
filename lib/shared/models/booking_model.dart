import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class Booking {
  final String id;
  final String userId;
  final String serviceId;
  final String providerId;
  final DateTime scheduledAt;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final double totalAmount;
  final String currency;
  final String? notes;
  final String? cancellationReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.providerId,
    required this.scheduledAt,
    required this.status,
    required this.totalAmount,
    required this.currency,
    this.notes,
    this.cancellationReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
