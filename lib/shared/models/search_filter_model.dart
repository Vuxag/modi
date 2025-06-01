import 'package:json_annotation/json_annotation.dart';

part 'search_filter_model.g.dart';

@JsonSerializable()
class SearchFilter {
  final String? query;
  final double? latitude;
  final double? longitude;
  final double? radius; // in kilometers
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final List<String>? categories;
  final List<String>? tags;
  final String? sortBy; // PRICE, RATING, DISTANCE, POPULARITY
  final String? sortOrder; // ASC, DESC
  final bool? isAvailable;
  final DateTime? availableFrom;
  final DateTime? availableTo;

  SearchFilter({
    this.query,
    this.latitude,
    this.longitude,
    this.radius,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.categories,
    this.tags,
    this.sortBy,
    this.sortOrder,
    this.isAvailable,
    this.availableFrom,
    this.availableTo,
  });

  factory SearchFilter.fromJson(Map<String, dynamic> json) =>
      _$SearchFilterFromJson(json);
  Map<String, dynamic> toJson() => _$SearchFilterToJson(this);

  SearchFilter copyWith({
    String? query,
    double? latitude,
    double? longitude,
    double? radius,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    List<String>? categories,
    List<String>? tags,
    String? sortBy,
    String? sortOrder,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableTo,
  }) {
    return SearchFilter(
      query: query ?? this.query,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      isAvailable: isAvailable ?? this.isAvailable,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
    );
  }
}
