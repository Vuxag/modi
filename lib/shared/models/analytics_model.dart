import 'package:json_annotation/json_annotation.dart';

part 'analytics_model.g.dart';

@JsonSerializable()
class ServiceAnalytics {
  final String serviceId;
  final int totalViews;
  final int totalBookings;
  final double totalRevenue;
  final double averageRating;
  final int totalReviews;
  final Map<String, int> viewsByDay;
  final Map<String, int> bookingsByDay;
  final Map<String, double> revenueByDay;
  final List<ReviewAnalytics> recentReviews;
  final DateTime lastUpdated;

  ServiceAnalytics({
    required this.serviceId,
    required this.totalViews,
    required this.totalBookings,
    required this.totalRevenue,
    required this.averageRating,
    required this.totalReviews,
    required this.viewsByDay,
    required this.bookingsByDay,
    required this.revenueByDay,
    required this.recentReviews,
    required this.lastUpdated,
  });

  factory ServiceAnalytics.fromJson(Map<String, dynamic> json) =>
      _$ServiceAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceAnalyticsToJson(this);
}

@JsonSerializable()
class ReviewAnalytics {
  final String reviewId;
  final double rating;
  final String sentiment;
  final List<String> tags;
  final DateTime createdAt;

  ReviewAnalytics({
    required this.reviewId,
    required this.rating,
    required this.sentiment,
    required this.tags,
    required this.createdAt,
  });

  factory ReviewAnalytics.fromJson(Map<String, dynamic> json) =>
      _$ReviewAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewAnalyticsToJson(this);
}

@JsonSerializable()
class ProviderAnalytics {
  final String providerId;
  final int totalServices;
  final int totalBookings;
  final double totalRevenue;
  final double averageRating;
  final Map<String, ServiceAnalytics> serviceAnalytics;
  final DateTime lastUpdated;

  ProviderAnalytics({
    required this.providerId,
    required this.totalServices,
    required this.totalBookings,
    required this.totalRevenue,
    required this.averageRating,
    required this.serviceAnalytics,
    required this.lastUpdated,
  });

  factory ProviderAnalytics.fromJson(Map<String, dynamic> json) =>
      _$ProviderAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderAnalyticsToJson(this);
}
