part of 'browse_courses_cubit.dart';

sealed class BrowseCoursesState {
  const BrowseCoursesState();
}

final class BrowseCoursesInitial extends BrowseCoursesState {
  const BrowseCoursesInitial();
}

final class BrowseCoursesLoading extends BrowseCoursesState {
  const BrowseCoursesLoading();
}

final class BrowseCoursesSuccess extends BrowseCoursesState {
  const BrowseCoursesSuccess(this.enrollments);

  final List<EnrollmentDto> enrollments;
}

final class BrowseCoursesEmpty extends BrowseCoursesState {
  const BrowseCoursesEmpty();
}

final class BrowseCoursesFailure extends BrowseCoursesState {
  const BrowseCoursesFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}
