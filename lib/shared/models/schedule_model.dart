import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class Schedule {
  final String id;
  final String serviceId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String status; // PENDING, CONFIRMED, CANCELLED, COMPLETED
  final List<Reminder> reminders;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Schedule({
    required this.id,
    required this.serviceId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.reminders,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable()
class Reminder {
  final String id;
  final DateTime time;
  final String type; // PUSH, EMAIL, SMS
  final String message;
  final bool isSent;
  final DateTime? sentAt;

  Reminder({
    required this.id,
    required this.time,
    required this.type,
    required this.message,
    required this.isSent,
    this.sentAt,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
  Map<String, dynamic> toJson() => _$ReminderToJson(this);
}
