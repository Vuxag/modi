import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class Chat {
  final String id;
  final String bookingId;
  final String customerId;
  final String providerId;
  final DateTime createdAt;
  final DateTime? lastMessageAt;
  final bool isActive;
  final List<ChatMessage> messages;

  Chat({
    required this.id,
    required this.bookingId,
    required this.customerId,
    required this.providerId,
    required this.createdAt,
    this.lastMessageAt,
    required this.isActive,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class ChatMessage {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final String type; // 'text', 'image', 'location', 'file'
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? metadata; // Cho các loại tin nhắn đặc biệt

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.metadata,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

@JsonSerializable()
class Notification {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type; // 'booking', 'chat', 'promotion', 'system'
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.data,
    required this.isRead,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
