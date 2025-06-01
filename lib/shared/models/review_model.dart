import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class Review {
  final String id;
  final String serviceId;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final int rating;
  final String comment;
  final List<String> tags;
  final List<ReviewMedia> media;
  final ReviewReply? reply;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.serviceId,
    required this.userId,
    required this.userName,
    required this.userAvatarUrl,
    required this.rating,
    required this.comment,
    required this.tags,
    required this.media,
    this.reply,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class ReviewMedia {
  final String id;
  final String url;
  final String type;
  final DateTime createdAt;

  ReviewMedia({
    required this.id,
    required this.url,
    required this.type,
    required this.createdAt,
  });

  factory ReviewMedia.fromJson(Map<String, dynamic> json) =>
      _$ReviewMediaFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewMediaToJson(this);
}

@JsonSerializable()
class ReviewReply {
  final String id;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewReply({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewReply.fromJson(Map<String, dynamic> json) =>
      _$ReviewReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewReplyToJson(this);
}
