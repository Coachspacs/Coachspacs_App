import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

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

    _category = 'Development';
    _level = 'Intermediate';
    _language = 'English';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  // =========================================================
  // SAVE
  // =========================================================

  void _saveBasicInfo() {
    setState(() {
      _editingBasicInfo = false;
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
                      status: _statusText,
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

  // =========================================================
  // STATUS
  // =========================================================

  String get _statusText {
    switch (widget.course.status) {
      case CourseStatus.published:
        return 'Published';

      case CourseStatus.pendingReview:
        return 'Pending';

      case CourseStatus.draft:
        return 'Draft';

      case CourseStatus.rejected:
        return 'Rejected';
    }
  }
}