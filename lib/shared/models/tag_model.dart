import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class Tag {
  final String id;
  final String name;
  final String slug;
  final String? parentId;
  final String? iconUrl;
  final int? serviceCount;
  final List<Tag>? children;

  Tag({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
    this.iconUrl,
    this.serviceCount,
    this.children,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}
