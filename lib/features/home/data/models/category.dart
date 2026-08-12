import 'package:equatable/equatable.dart';

/// Course category shown as filter chips on the home screen.
class Category extends Equatable {
  const Category({required this.id, required this.name, this.slug});

  final String id;
  final String name;
  final String? slug;

  @override
  List<Object?> get props => [id, name, slug];
}
