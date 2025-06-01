import 'package:json_annotation/json_annotation.dart';

part 'referral_model.g.dart';

@JsonSerializable()
class Referral {
  final String id;
  final String referrerId;
  final String? referredId;
  final String code;
  final String status; // PENDING, COMPLETED, EXPIRED
  final double rewardAmount;
  final String rewardType; // CASH, CREDIT, DISCOUNT
  final DateTime expiryDate;
  final DateTime createdAt;
  final DateTime? completedAt;

  Referral({
    required this.id,
    required this.referrerId,
    this.referredId,
    required this.code,
    required this.status,
    required this.rewardAmount,
    required this.rewardType,
    required this.expiryDate,
    required this.createdAt,
    this.completedAt,
  });

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralToJson(this);
}

@JsonSerializable()
class ShareContent {
  final String type; // SERVICE, PROFILE, PROMOTION
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String? deepLink;
  final Map<String, dynamic>? metadata;

  ShareContent({
    required this.type,
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.deepLink,
    this.metadata,
  });

  factory ShareContent.fromJson(Map<String, dynamic> json) =>
      _$ShareContentFromJson(json);
  Map<String, dynamic> toJson() => _$ShareContentToJson(this);
}

@JsonSerializable()
class ReferralStats {
  final String userId;
  final int totalReferrals;
  final int successfulReferrals;
  final double totalRewards;
  final List<Referral> recentReferrals;
  final DateTime lastUpdated;

  ReferralStats({
    required this.userId,
    required this.totalReferrals,
    required this.successfulReferrals,
    required this.totalRewards,
    required this.recentReferrals,
    required this.lastUpdated,
  });

  factory ReferralStats.fromJson(Map<String, dynamic> json) =>
      _$ReferralStatsFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralStatsToJson(this);
}
