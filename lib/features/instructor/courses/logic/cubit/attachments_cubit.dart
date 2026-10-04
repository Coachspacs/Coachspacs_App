import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/instructor/courses/data/attachment_cloudinary_uploader.dart';
import 'package:coach_space/features/instructor/courses/data/models/attachment_dto.dart';
import 'package:coach_space/features/instructor/courses/data/models/attachment_write_request.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';

part 'attachments_state.dart';

/// Loads, creates and deletes attachments for a single course — the
/// "Course Materials" list (US-21) — or for a single lesson of that course
/// when a [lessonId] is given.
///
/// Creating from a file uploads it directly to Cloudinary through
/// [AttachmentCloudinaryUploader] using the short-lived signature from the
/// repository, then registers the resulting public id. Creating from a link
/// registers the user-provided URL without any upload. Mutations keep the
/// current list on screen and surface failures through
/// [AttachmentsSuccess.lastFailure] so the section can show a snackbar
/// instead of losing the list.
class AttachmentsCubit extends Cubit<AttachmentsState> {
  AttachmentsCubit({
    required int courseId,
    required InstructorCoursesRepository repository,
    required AttachmentCloudinaryUploader uploader,
  }) : _courseId = courseId,
       _repository = repository,
       _uploader = uploader,
       super(const AttachmentsInitial());

  final int _courseId;
  final InstructorCoursesRepository _repository;
  final AttachmentCloudinaryUploader _uploader;

  /// Lesson scope remembered from the last [load] so [refresh] and
  /// [delete] operate on the list that is actually on screen.
  int? _lessonId;

  bool get _isBusy {
    final state = this.state;
    return state is AttachmentsSuccess && state.isBusy;
  }

  /// Loads the attachment list: lesson attachments when [lessonId] is given,
  /// course-level materials otherwise.
  Future<void> load({int? lessonId}) async {
    if (_isBusy) return;
    _lessonId = lessonId;

    emit(const AttachmentsLoading());
    try {
      final attachments = await _fetch(lessonId);
      emit(AttachmentsSuccess(attachments: attachments));
    } on NetworkException catch (error) {
      emit(AttachmentsFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const AttachmentsFailure(
          kind: FailureKind.unknown,
          message: AttachmentsState.fallbackMessage,
        ),
      );
    }
  }

  /// Silent reload, keeping whatever list is already on screen.
  Future<void> refresh() => load(lessonId: _lessonId);

  /// Registers a user-provided public URL without any Cloudinary upload.
  ///
  /// The backend stores the file reference in `file_public_id`, so the URL is
  /// sent as the public id; [title] names the material and falls back to the
  /// URL's last path segment.
  Future<void> createFromUrl({
    required String url,
    required String title,
    int? lessonId,
  }) async {
    if (_isBusy) return;

    final state = this.state;
    final current = state is AttachmentsSuccess
        ? state.attachments
        : const <AttachmentDto>[];

    emit(
      AttachmentsSuccess(
        attachments: current,
        performingAction: true,
      ),
    );

    try {
      final trimmedUrl = url.trim();
      final fileName = title.trim().isNotEmpty
          ? title.trim()
          : trimmedUrl.split('/').last.trim();
      final request = AttachmentWriteRequest(
        fileName: fileName,
        filePublicId: trimmedUrl,
      );

      if (lessonId != null) {
        await _repository.createLessonAttachment(lessonId, request);
      } else {
        await _repository.createCourseAttachment(_courseId, request);
      }

      await _reload();
    } on NetworkException catch (error) {
      _reportFailure(error, current);
    } catch (_) {
      const error = NetworkException(
        kind: FailureKind.unknown,
        message: AttachmentsState.fallbackMessage,
      );
      _reportFailure(error, current);
    }
  }

  /// Uploads a picked file directly to Cloudinary with the course-scoped
  /// signature, then registers the attachment under its public id.
  /// [title] names the material and falls back to the file name without its
  /// extension.
  Future<void> createFromFile({
    required File file,
    required String fileName,
    String title = '',
    int? lessonId,
  }) async {
    if (_isBusy) return;

    final state = this.state;
    final current = state is AttachmentsSuccess
        ? state.attachments
        : const <AttachmentDto>[];

    emit(
      AttachmentsSuccess(
        attachments: current,
        uploadProgress: 0,
      ),
    );

    try {
      final signature = await _repository.getAttachmentUploadSignature(
        _courseId,
      );

      final upload = await _uploader.upload(
        signature,
        file: file,
        fileName: fileName,
        onProgress: (progress) {
          if (!isClosed) {
            emit(
              AttachmentsSuccess(
                attachments: current,
                uploadProgress: progress,
              ),
            );
          }
        },
      );

      final request = AttachmentWriteRequest(
        fileName: title.trim().isNotEmpty ? title.trim() : fileName,
        filePublicId: upload.publicId,
      );

      if (lessonId != null) {
        await _repository.createLessonAttachment(lessonId, request);
      } else {
        await _repository.createCourseAttachment(_courseId, request);
      }

      await _reload();
    } on NetworkException catch (error) {
      _reportFailure(error, current);
    } catch (_) {
      const error = NetworkException(
        kind: FailureKind.unknown,
        message: AttachmentsState.fallbackMessage,
      );
      _reportFailure(error, current);
    }
  }

  /// Deletes an attachment and reloads the list that is on screen.
  Future<void> delete(int attachmentId) async {
    if (_isBusy) return;

    final state = this.state;
    if (state is! AttachmentsSuccess) return;
    final current = state.attachments;

    emit(
      AttachmentsSuccess(
        attachments: current,
        performingAction: true,
      ),
    );

    try {
      await _repository.deleteAttachment(attachmentId);
      await _reload();
    } on NetworkException catch (error) {
      _reportFailure(error, current);
    } catch (_) {
      const error = NetworkException(
        kind: FailureKind.unknown,
        message: AttachmentsState.fallbackMessage,
      );
      _reportFailure(error, current);
    }
  }

  Future<List<AttachmentDto>> _fetch(int? lessonId) async {
    if (lessonId != null) {
      return _repository.getLessonAttachments(lessonId);
    }
    return _repository.getCourseAttachments(_courseId);
  }

  Future<void> _reload() async {
    final attachments = await _fetch(_lessonId);
    if (!isClosed) {
      emit(AttachmentsSuccess(attachments: attachments));
    }
  }

  void _reportFailure(NetworkException error, List<AttachmentDto> current) {
    if (isClosed) return;

    if (current.isEmpty) {
      emit(AttachmentsFailure(kind: error.kind, message: error.message));
    } else {
      emit(
        AttachmentsSuccess(
          attachments: current,
          lastFailure: error,
        ),
      );
    }
  }
}
