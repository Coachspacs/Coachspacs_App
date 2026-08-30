import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

/// `GET /api/catalog/categories` item.
///
/// Returned as a plain JSON array (not a paginated envelope). `name` is
/// already localized server-side from `Accept-Language`. `icon` may be empty.
@JsonSerializable()
class CategoryDto {
  const CategoryDto({required this.id, required this.name, this.icon = ''});

  final int id;
  final String name;

  @JsonKey(defaultValue: '')
  final String icon;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
