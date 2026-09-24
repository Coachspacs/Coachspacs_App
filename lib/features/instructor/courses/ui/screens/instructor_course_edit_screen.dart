import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/courses/ui/screens/instructor_courses_screen.dart';

import '../widgets/edit_course/instructor_edit_course_basic_info.dart';
import '../widgets/edit_course/instructor_edit_course_curriculum.dart';
import '../widgets/edit_course/instructor_edit_course_header.dart';
import '../widgets/edit_course/instructor_edit_course_status.dart';

class InstructorCourseEditScreen extends StatefulWidget {
  const InstructorCourseEditScreen({
    super.key,
    required this.course,
  });

  final InstructorCourse course;

  @override
  State<InstructorCourseEditScreen> createState() =>
      _InstructorCourseEditScreenState();
}

class _InstructorCourseEditScreenState
    extends State<InstructorCourseEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;

  late String _category;
  late String _level;
  late String _language;

  bool _editingBasicInfo = false;
  bool _isSaving = false;
  bool _isUploadingImage = false;

  bool _isFree = false;
  String? _lastPaidPrice;
  File? _pickedCoverImage;
  String _coverImageUrl = '';
  CourseStatus _status = CourseStatus.draft;
  String? _rejectionReason;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.course.title,
    );

    _descriptionController = TextEditingController(
      text: 'Build modern, production-ready applications '
          'using practical techniques and best practices.',
    );

    _priceController = TextEditingController(
      text: widget.course.price.replaceAll('\$', ''),
    );

    _isFree = widget.course.isFree;
    if (_isFree) {
      _priceController.text = '0';
    }

    _category = 'Development';
    _level = 'Intermediate';
    _language = 'English';

    _status = widget.course.status;
    _rejectionReason = widget.course.rejectionReason;
    _coverImageUrl = widget.course.image;

    _loadCourseDetails();
  }

  Future<void> _loadCourseDetails() async {
    try {
      final dto = await getIt<InstructorCoursesRepository>()
          .getCourse(widget.course.id);
      if (!mounted) return;
      setState(() {
        _descriptionController.text = dto.displayDescription;
        _priceController.text = dto.price.replaceAll('\$', '');
        _isFree = dto.price.isEmpty ||
            dto.price == '0' ||
            dto.price == '0.00' ||
            dto.price == '0.0';
        _coverImageUrl = dto.coverImage;
        _status = switch (dto.status) {
          'published' => CourseStatus.published,
          'pending' || 'pending_review' => CourseStatus.pendingReview,
          'rejected' => CourseStatus.rejected,
          'archived' => CourseStatus.archived,
          _ => CourseStatus.draft,
        };
        _rejectionReason = dto.rejectionReason;
      });
    } on NetworkException {
      // Keep the values passed in from the list.
    } catch (_) {
      // Keep the values passed in from the list.
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  // =========================================================
  // FREE TOGGLE
  // =========================================================

  void _toggleFree(bool value) {
    setState(() {
      _isFree = value;
      if (value) {
        _lastPaidPrice = _priceController.text;
        _priceController.text = '0';
      } else {
        _priceController.text = _lastPaidPrice ?? '';
      }
    });
  }

  // =========================================================
  // COVER IMAGE
  // =========================================================

  Future<void> _pickCoverImage() async {
    if (_isUploadingImage) return;

    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        maxHeight: 900,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;

      final file = File(picked.path);
      setState(() {
        _pickedCoverImage = file;
        _isUploadingImage = true;
      });

      await getIt<InstructorCoursesRepository>().uploadCoverImage(
        widget.course.id,
        file,
      );

      if (!mounted) return;
      setState(() {
        _isUploadingImage = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cover image updated.'),
          backgroundColor: Color(0xFF075E4D),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on NetworkException catch (error) {
      if (!mounted) return;
      setState(() {
        _pickedCoverImage = null;
        _isUploadingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizedFailureMessage(context, error.kind, error.message),
          ),
          backgroundColor: const Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _pickedCoverImage = null;
        _isUploadingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to upload cover image.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================================================
  // SAVE
  // =========================================================

  Future<void> _saveBasicInfo() async {
    if (_isSaving) return;

    setState(() {
      _editingBasicInfo = false;
      _isSaving = true;
    });

    try {
      await getIt<InstructorCoursesRepository>().updateCourse(
        widget.course.id,
        CoursePatchRequest(
          titleAr: _titleController.text.trim(),
          titleEn: _titleController.text.trim(),
          descriptionAr: _descriptionController.text.trim(),
          descriptionEn: _descriptionController.text.trim(),
          price: _isFree
              ? '0'
              : (_priceController.text.trim().isEmpty
                  ? '0'
                  : _priceController.text.trim()),
        ),
      );

      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Changes saved successfully.',
          ),
          backgroundColor: Color(0xFF075E4D),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on NetworkException catch (error) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _editingBasicInfo = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizedFailureMessage(context, error.kind, error.message),
          ),
          backgroundColor: const Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _editingBasicInfo = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            InstructorEditCourseHeader(
              onBack: () {
                Navigator.pop(context);
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  30,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit your course',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Update your course information and content.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7C8C87),
                      ),
                    ),

                    const SizedBox(height: 18),

                    InstructorEditCourseBasicInfo(
                      titleController: _titleController,
                      descriptionController:
                      _descriptionController,
                      priceController: _priceController,
                      category: _category,
                      level: _level,
                      language: _language,
                      isEditing: _editingBasicInfo,
                      isFree: _isFree,
                      onFreeChanged: _toggleFree,
                      coverImageUrl: _coverImageUrl,
                      coverImageFile: _pickedCoverImage,
                      isUploadingCoverImage: _isUploadingImage,
                      onPickCoverImage: _pickCoverImage,
                      onEdit: () {
                        setState(() {
                          _editingBasicInfo = true;
                        });
                      },
                      onSave: _saveBasicInfo,
                      onCategoryChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _category = value;
                        });
                      },
                      onLevelChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _level = value;
                        });
                      },
                      onLanguageChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _language = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    InstructorEditCourseCurriculum(
                      onEdit: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Curriculum editor will be added next.',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    InstructorEditCourseStatus(
                      status: _status,
                      rejectionReason: _rejectionReason,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}