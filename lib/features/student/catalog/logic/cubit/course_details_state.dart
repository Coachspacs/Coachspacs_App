part of 'course_details_cubit.dart';

sealed class CourseDetailsState {
  const CourseDetailsState();
}

final class CourseDetailsInitial extends CourseDetailsState {
  const CourseDetailsInitial();
}

final class CourseDetailsLoading extends CourseDetailsState {
  const CourseDetailsLoading();
}

final class CourseDetailsSuccess extends CourseDetailsState {
  const CourseDetailsSuccess({
    required this.course,
    this.enrollment,
    this.isAddingToCart = false,
    this.isEnrollingFree = false,
  });

  final CourseDetailDto course;
  final EnrollmentDto? enrollment;
  final bool isAddingToCart;
  final bool isEnrollingFree;

  bool get isEnrolled => enrollment != null;
  bool get isBusy => isAddingToCart || isEnrollingFree;

  CourseDetailsSuccess copyWith({
    EnrollmentDto? enrollment,
    bool? isAddingToCart,
    bool? isEnrollingFree,
  }) => CourseDetailsSuccess(
    course: course,
    enrollment: enrollment ?? this.enrollment,
    isAddingToCart: isAddingToCart ?? this.isAddingToCart,
    isEnrollingFree: isEnrollingFree ?? this.isEnrollingFree,
  );
}

final class CourseDetailsFailure extends CourseDetailsState {
  const CourseDetailsFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}
