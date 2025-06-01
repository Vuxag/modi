import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class Payment {
  final String id;
  final String bookingId;
  final double amount;
  final String currency;
  final String status; // PENDING, COMPLETED, FAILED, REFUNDED
  final String paymentMethod; // CREDIT_CARD, PAYPAL, WALLET, etc.
  final PaymentDetails details;
  final List<PaymentInstallment>? installments;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.details,
    this.installments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable()
class PaymentDetails {
  final String? cardLast4;
  final String? cardBrand;
  final String? transactionId;
  final String? receiptUrl;
  final Map<String, dynamic>? metadata;

  PaymentDetails({
    this.cardLast4,
    this.cardBrand,
    this.transactionId,
    this.receiptUrl,
    this.metadata,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentDetailsToJson(this);
}

@JsonSerializable()
class PaymentInstallment {
  final int number;
  final double amount;
  final DateTime dueDate;
  final String status; // PENDING, PAID, OVERDUE

  PaymentInstallment({
    required this.number,
    required this.amount,
    required this.dueDate,
    required this.status,
  });

  factory PaymentInstallment.fromJson(Map<String, dynamic> json) =>
      _$PaymentInstallmentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentInstallmentToJson(this);
}
