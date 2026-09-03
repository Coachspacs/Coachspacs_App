import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

/// Django REST Framework-style page shared by every paginated endpoint.
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}
