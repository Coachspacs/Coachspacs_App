import 'package:equatable/equatable.dart';

/// Instructor (course author) summary shown on course cards.
class Instructor extends Equatable {
  const Instructor({required this.id, required this.name, this.avatarUrl});

  final String id;
  final String name;
  final String? avatarUrl;

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
