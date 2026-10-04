part of 'attachments_cubit.dart';

/// Lifecycle of the "Course Materials" list (US-21).
sealed class AttachmentsState {
  const AttachmentsState();

  static const String fallbackMessage =
      'Something went wrong. Please try again.';
}

final class AttachmentsInitial extends AttachmentsState {
  const AttachmentsInitial();
}

final class AttachmentsLoading extends AttachmentsState {
  const AttachmentsLoading();
}

final class AttachmentsSuccess extends AttachmentsState {
  const AttachmentsSuccess({
    required this.attachments,
    this.uploadProgress,
    this.performingAction = false,
    this.lastFailure,
  });

  /// The course (or lesson) materials, oldest first as returned by the API.
  final List<AttachmentDto> attachments;

  /// Progress of an in-flight Cloudinary file upload, `0..1`; `null` when no
  /// upload is running. Kept alongside [attachments] so the list stays
  /// visible while a file is being uploaded.
  final double? uploadProgress;

  /// Whether a non-upload mutation (create link / delete) is in flight.
  final bool performingAction;

  /// Most recent mutation failure, surfaced as a snackbar by the section
  /// while keeping [attachments] on screen.
  final NetworkException? lastFailure;

  bool get isBusy => uploadProgress != null || performingAction;
}

final class AttachmentsFailure extends AttachmentsState {
  const AttachmentsFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}
