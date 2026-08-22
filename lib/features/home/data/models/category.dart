import 'package:equatable/equatable.dart';

/// Course category shown as filter chips on the home screen.
class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    this.slug,
    this.icon = '',
  });

  final String id;
  final String name;
  final String? slug;
  final String icon;

  @override
  List<Object?> get props => [id, name, slug, icon];
}
