import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/curriculum_lesson_tile.dart';

class CreateCourseCurriculum extends StatefulWidget {
  const CreateCourseCurriculum({
    super.key,
    required this.courseId,
    required this.language,
    required this.onChanged,
  });

  final int courseId;
  final String language;
  final ValueChanged<List<InstructorSectionDto>> onChanged;

  @override
  State<CreateCourseCurriculum> createState() =>
      _CreateCourseCurriculumState();
}

class _CreateCourseCurriculumState
    extends State<CreateCourseCurriculum> {
  final InstructorCoursesRepository _repo =
      getIt<InstructorCoursesRepository>();

  List<InstructorSectionDto> _sections = [];
  bool _isLoading = false;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  String _titleFor(String titleAr, String titleEn) =>
      widget.language == 'ar' ? titleAr : titleEn;

  Future<void> _loadSections() async {
    setState(() => _isLoading = true);
    try {
      final course = await _repo.getCourse(widget.courseId);
      if (!mounted) return;
      final sections = [...course.sections]
        ..sort((a, b) => a.order.compareTo(b.order));
      setState(() {
        _sections = sections
            .map(
              (section) => InstructorSectionDto(
                id: section.id,
                titleAr: section.titleAr,
                titleEn: section.titleEn,
                order: section.order,
                lessons: [...section.lessons]
                  ..sort((a, b) => a.order.compareTo(b.order)),
              ),
            )
            .toList();
        _isLoading = false;
      });
      widget.onChanged(_sections);
    } on NetworkException catch (error) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError(error);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showMessage('Unable to load curriculum.', isError: true);
    }
  }

  void _showError(NetworkException error) {
    _showMessage(
      localizedFailureMessage(context, error.kind, error.message),
      isError: true,
    );
  }

  void _showMessage(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor:
            isError ? const Color(0xFFB3261E) : const Color(0xFF075E4D),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<bool> _guardBusy(Future<void> Function() action) async {
    if (_isBusy) return false;
    setState(() => _isBusy = true);
    try {
      await action();
      return true;
    } on NetworkException catch (error) {
      if (mounted) _showError(error);
      return false;
    } catch (_) {
      if (mounted) {
        _showMessage('Something went wrong. Please try again.', isError: true);
      }
      return false;
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _addSection() async {
    final title = await _showTitleSheet(
      title: 'Add Section',
      confirmLabel: 'Add Section',
      initial: '',
    );
    if (title == null || title.isEmpty) return;

    final ok = await _guardBusy(() async {
      final created = await _repo.createSection(
        widget.courseId,
        SectionWriteRequest(
          titleAr: title,
          titleEn: title,
          order: _sections.length,
        ),
      );
      setState(() {
        _sections = [
          ..._sections,
          InstructorSectionDto(
            id: created.id,
            titleAr: created.titleAr,
            titleEn: created.titleEn,
            order: created.order,
            lessons: const [],
          ),
        ];
      });
      widget.onChanged(_sections);
    });
    if (ok) _showMessage('Section added.', isError: false);
  }

  Future<void> _editSection(InstructorSectionDto section) async {
    final title = await _showTitleSheet(
      title: 'Edit Section',
      confirmLabel: 'Save',
      initial: _titleFor(section.titleAr, section.titleEn),
    );
    if (title == null || title.isEmpty) return;

    final ok = await _guardBusy(() async {
      await _repo.updateSection(
        section.id,
        SectionPatchRequest(titleAr: title, titleEn: title),
      );
      setState(() {
        _sections = _sections
            .map(
              (s) => s.id == section.id
                  ? InstructorSectionDto(
                      id: s.id,
                      titleAr: title,
                      titleEn: title,
                      order: s.order,
                      lessons: s.lessons,
                    )
                  : s,
            )
            .toList();
      });
      widget.onChanged(_sections);
    });
    if (ok) _showMessage('Section updated.', isError: false);
  }

  Future<void> _deleteSection(InstructorSectionDto section) async {
    final confirmed = await _confirmDelete(
      message:
          'Delete "${_titleFor(section.titleAr, section.titleEn)}" '
          'and all of its lessons?',
    );
    if (confirmed != true) return;

    final ok = await _guardBusy(() async {
      await _repo.deleteSection(section.id);
      setState(() {
        _sections = _sections.where((s) => s.id != section.id).toList();
      });
      widget.onChanged(_sections);
    });
    if (ok) _showMessage('Section deleted.', isError: false);
  }

  Future<void> _addLesson(InstructorSectionDto section) async {
    final draft = await _showLessonSheet(
      title: 'Add Lesson',
      confirmLabel: 'Add Lesson',
    );
    if (draft == null) return;

    final ok = await _guardBusy(() async {
      final created = await _repo.createLesson(
        section.id,
        LessonWriteRequest(
          titleAr: draft.title,
          titleEn: draft.title,
          videoUrl: draft.videoUrl.isEmpty ? null : draft.videoUrl,
          durationMinutes: draft.durationMinutes,
          order: section.lessons.length,
          isPreview: draft.isPreview,
        ),
      );
      setState(() {
        _sections = _sections.map((s) {
          if (s.id != section.id) return s;
          return InstructorSectionDto(
            id: s.id,
            titleAr: s.titleAr,
            titleEn: s.titleEn,
            order: s.order,
            lessons: [...s.lessons, created],
          );
        }).toList();
      });
      widget.onChanged(_sections);
    });
    if (ok) _showMessage('Lesson added.', isError: false);
  }

  Future<void> _editLesson(
    InstructorSectionDto section,
    InstructorLessonDto lesson,
  ) async {
    final draft = await _showLessonSheet(
      title: 'Edit Lesson',
      confirmLabel: 'Save',
      initial: _LessonDraft(
        title: _titleFor(lesson.titleAr, lesson.titleEn),
        videoUrl: lesson.videoUrl,
        durationMinutes: lesson.durationMinutes,
        isPreview: lesson.isPreview,
      ),
    );
    if (draft == null) return;

    final ok = await _guardBusy(() async {
      final updated = await _repo.updateLesson(
        lesson.id,
        LessonPatchRequest(
          titleAr: draft.title,
          titleEn: draft.title,
          videoUrl: draft.videoUrl.isEmpty
              ? null
              : draft.videoUrl,
          durationMinutes: draft.durationMinutes,
          isPreview: draft.isPreview,
        ),
      );
      setState(() {
        _sections = _sections.map((s) {
          if (s.id != section.id) return s;
          return InstructorSectionDto(
            id: s.id,
            titleAr: s.titleAr,
            titleEn: s.titleEn,
            order: s.order,
            lessons: s.lessons
                .map((l) => l.id == lesson.id ? updated : l)
                .toList(),
          );
        }).toList();
      });
      widget.onChanged(_sections);
    });
    if (ok) _showMessage('Lesson updated.', isError: false);
  }

  Future<void> _deleteLesson(
    InstructorSectionDto section,
    InstructorLessonDto lesson,
  ) async {
    final confirmed = await _confirmDelete(
      message:
          'Delete "${_titleFor(lesson.titleAr, lesson.titleEn)}"?',
    );
    if (confirmed != true) return;

    final ok = await _guardBusy(() async {
      await _repo.deleteLesson(lesson.id);
      setState(() {
        _sections = _sections.map((s) {
          if (s.id != section.id) return s;
          return InstructorSectionDto(
            id: s.id,
            titleAr: s.titleAr,
            titleEn: s.titleEn,
            order: s.order,
            lessons:
                s.lessons.where((l) => l.id != lesson.id).toList(),
          );
        }).toList();
      });
      widget.onChanged(_sections);
    });
    if (ok) _showMessage('Lesson deleted.', isError: false);
  }

  Future<bool?> _confirmDelete({required String message}) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        title: Text(
          'Delete?',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 12,
            height: 1.4,
            color: const Color(0xFF55736C),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF788681),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB3261E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showTitleSheet({
    required String title,
    required String confirmLabel,
    required String initial,
  }) {
    final controller = TextEditingController(text: initial);
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            18,
            18,
            18,
            MediaQuery.of(sheetContext).viewInsets.bottom + 18,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF073F38),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: controller,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Section title',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF9AA8A4),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF7FAF9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFDCE7E4),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFDCE7E4),
                    ),
                  ),
                ),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF263C38),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    final value = controller.text.trim();
                    if (value.isEmpty) return;
                    Navigator.pop(sheetContext, value);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF075E4D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    confirmLabel,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<_LessonDraft?> _showLessonSheet({
    required String title,
    required String confirmLabel,
    _LessonDraft? initial,
  }) {
    final titleController = TextEditingController(
      text: initial?.title ?? '',
    );
    final videoController = TextEditingController(
      text: initial?.videoUrl ?? '',
    );
    final durationController = TextEditingController(
      text: initial == null
          ? ''
          : initial.durationMinutes > 0
          ? '${initial.durationMinutes}'
          : '',
    );
    bool isPreview = initial?.isPreview ?? false;

    return showModalBottomSheet<_LessonDraft>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                18,
                18,
                MediaQuery.of(sheetContext).viewInsets.bottom + 18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _sheetField(
                    controller: titleController,
                    label: 'Lesson title',
                    autofocus: true,
                  ),
                  const SizedBox(height: 12),
                  _sheetField(
                    controller: videoController,
                    label: 'Video URL',
                    hint: 'https://…',
                  ),
                  const SizedBox(height: 12),
                  _sheetField(
                    controller: durationController,
                    label: 'Duration (minutes)',
                    hint: '0',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: isPreview,
                    onChanged: (value) =>
                        setSheetState(() => isPreview = value),
                    title: Text(
                      'Preview lesson',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263C38),
                      ),
                    ),
                    activeTrackColor: const Color(0xFF075E4D),
                    activeThumbColor: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        final lessonTitle = titleController.text.trim();
                        if (lessonTitle.isEmpty) return;
                        final duration =
                            int.tryParse(durationController.text.trim()) ??
                                0;
                        Navigator.pop(
                          sheetContext,
                          _LessonDraft(
                            title: lessonTitle,
                            videoUrl: videoController.text.trim(),
                            durationMinutes:
                                duration < 0 ? 0 : duration,
                            isPreview: isPreview,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF075E4D),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        confirmLabel,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _sheetField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool autofocus = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF667570),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          autofocus: autofocus,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF9AA8A4),
            ),
            filled: true,
            fillColor: const Color(0xFFF7FAF9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFDCE7E4)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFDCE7E4)),
            ),
          ),
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF263C38),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: CircularProgressIndicator(
            color: Color(0xFF075E4D),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Curriculum Builder',
          style: GoogleFonts.inter(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Organize your course into sections and lessons.',
          style: GoogleFonts.inter(
            fontSize: 11.5,
            height: 1.4,
            color: const Color(0xFF788681),
          ),
        ),
        const SizedBox(height: 16),
        if (_sections.isEmpty && !_isBusy)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDCE7E4)),
            ),
            child: Text(
              'No sections yet. Add your first section to start building the curriculum.',
              style: GoogleFonts.inter(
                fontSize: 12,
                height: 1.4,
                color: const Color(0xFF788681),
              ),
            ),
          ),
        ..._sections.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SectionCard(
                  index: entry.key + 1,
                  section: entry.value,
                  language: widget.language,
                  isBusy: _isBusy,
                  onEdit: () => _editSection(entry.value),
                  onDelete: () => _deleteSection(entry.value),
                  onAddLesson: () => _addLesson(entry.value),
                  onEditLesson: (lesson) =>
                      _editLesson(entry.value, lesson),
                  onDeleteLesson: (lesson) =>
                      _deleteLesson(entry.value, lesson),
                ),
              ),
            ),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: OutlinedButton.icon(
            onPressed: _isBusy ? null : _addSection,
            icon: const Icon(Icons.add, size: 15),
            label: Text(
              'Add New Section',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF075E4D),
              backgroundColor: Colors.white,
              disabledForegroundColor: const Color(0xFF9AA8A4),
              side: const BorderSide(color: Color(0xFFD3E2DE)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LessonDraft {
  const _LessonDraft({
    required this.title,
    required this.videoUrl,
    required this.durationMinutes,
    required this.isPreview,
  });

  final String title;
  final String videoUrl;
  final int durationMinutes;
  final bool isPreview;
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.index,
    required this.section,
    required this.language,
    required this.isBusy,
    required this.onEdit,
    required this.onDelete,
    required this.onAddLesson,
    required this.onEditLesson,
    required this.onDeleteLesson,
  });

  final int index;
  final InstructorSectionDto section;
  final String language;
  final bool isBusy;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onAddLesson;
  final ValueChanged<InstructorLessonDto> onEditLesson;
  final ValueChanged<InstructorLessonDto> onDeleteLesson;

  String _titleFor(String titleAr, String titleEn) =>
      language == 'ar' ? titleAr : titleEn;

  @override
  Widget build(BuildContext context) {
    final number = index.toString().padLeft(2, '0');
    final sectionTitle = _titleFor(section.titleAr, section.titleEn);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE7E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.drag_indicator_rounded,
                size: 14,
                color: Color(0xFFA2B1AD),
              ),
              const SizedBox(width: 3),
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFFE4F4EF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF075E4D),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  sectionTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF263C38),
                  ),
                ),
              ),
              IconButton(
                onPressed: isBusy ? null : onEdit,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 13,
                  color: Color(0xFF8A9995),
                ),
              ),
              IconButton(
                onPressed: isBusy ? null : onDelete,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 13,
                  color: Color(0xFF8A9995),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          if (section.lessons.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 4),
              child: Text(
                'No lessons yet.',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: const Color(0xFF8A9995),
                ),
              ),
            ),
          ...section.lessons.map(
            (lesson) => CurriculumLessonTile(
              lesson: CurriculumLesson(
                title: _titleFor(lesson.titleAr, lesson.titleEn),
                type: 'Video',
                duration: lesson.durationMinutes > 0
                    ? '${lesson.durationMinutes} min'
                    : '',
              ),
              trailing: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                iconSize: 14,
                icon: const Icon(
                  Icons.more_vert,
                  size: 14,
                  color: Color(0xFF9AA8A4),
                ),
                color: Colors.white,
                onSelected: (value) {
                  if (value == 'edit') onEditLesson(lesson);
                  if (value == 'delete') onDeleteLesson(lesson);
                },
                itemBuilder: (menuContext) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text(
                      'Edit',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB3261E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 2),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: OutlinedButton.icon(
              onPressed: isBusy ? null : onAddLesson,
              icon: const Icon(Icons.add, size: 12),
              label: Text(
                'Add Lesson',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF075E4D),
                disabledForegroundColor: const Color(0xFF9AA8A4),
                side: const BorderSide(color: Color(0xFFD5E4DF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
