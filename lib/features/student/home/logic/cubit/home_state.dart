import 'package:equatable/equatable.dart';


import '../../data/models/home_data.dart';

/// UI state for the home feature.
///
/// Every asynchronous home flow transitions through these states:
/// [HomeLoading] → [HomeSuccess] | [HomeEmpty] | [HomeError] | [HomeOffline].
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => const [];
}

/// No interaction has happened yet.
final class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Content is being fetched.
final class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Content loaded successfully and is non-empty.
final class HomeSuccess extends HomeState {
  const HomeSuccess({required this.data});

  final HomeData data;

  @override
  List<Object?> get props => [data];
}

/// Content loaded but every collection is empty.
final class HomeEmpty extends HomeState {
  const HomeEmpty();
}

/// Request failed for a server/unknown reason.
final class HomeError extends HomeState {
  const HomeError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Device has no network connectivity.
final class HomeOffline extends HomeState {
  const HomeOffline();
}
