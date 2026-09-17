import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/course_creation_step_indicator.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/create_course_basic_info.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/create_course_curriculum.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/create_course_review.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({
    super.key,

    // =====================================================
    // EDIT MODE
    // =====================================================

    this.isEditing = false,

    this.initialTitle,
    this.initialDescription,
    this.initialCategory,
    this.initialLevel,
    this.initialLanguage,
    this.initialPrice,
  });

  // =====================================================
  // EDIT MODE DATA
  // =====================================================

  final bool isEditing;

  final String? initialTitle;
  final String? initialDescription;
  final String? initialCategory;
  final String? initialLevel;
  final String? initialLanguage;
  final String? initialPrice;

  @override
  State<CreateCourseScreen> createState() =>
      _CreateCourseScreenState();
}

class _CreateCourseScreenState
    extends State<CreateCourseScreen> {
  // =====================================================
  // CURRENT STEP
  // =====================================================

  int _currentStep = 0;

  // =====================================================
  // CONTROLLERS
  // =====================================================

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;

  // =====================================================
  // SELECTED VALUES
  // =====================================================

  late String _selectedCategory;
  late String _selectedLevel;
  late String _selectedLanguage;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.initialTitle ?? '',
    );

    _descriptionController = TextEditingController(
      text: widget.initialDescription ?? '',
    );

    _priceController = TextEditingController(
      text: _cleanPrice(widget.initialPrice),
    );

    _selectedCategory =
        widget.initialCategory ?? 'Select a category';

    _selectedLevel =
        widget.initialLevel ?? 'Beginner';

    _selectedLanguage =
        widget.initialLanguage ?? 'English';
  }

  // =====================================================
  // CLEAN PRICE
  // =====================================================

  String _cleanPrice(String? price) {
    if (price == null || price.isEmpty) {
      return '';
    }

    return price
        .replaceAll('\$', '')
        .trim();
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  // =====================================================
  // NEXT STEP
  // =====================================================

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      return;
    }

    _saveCourse();
  }

  // =====================================================
  // PREVIOUS STEP
  // =====================================================

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      return;
    }

    Navigator.pop(context);
  }

  // =====================================================
  // SAVE / SUBMIT
  // =====================================================

  void _saveCourse() {
    if (widget.isEditing) {
      // ===================================================
      // EDIT MODE
      // ===================================================

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Changes saved successfully.',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor:
          const Color(0xFF075E4D),
          behavior:
          SnackBarBehavior.floating,
          duration:
          const Duration(seconds: 2),
        ),
      );

      // Go back to Instructor Courses.
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.instructorCourses,
            (route) => false,
      );

      return;
    }

    // =====================================================
    // CREATE MODE
    // =====================================================

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Course submitted for review.',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor:
        const Color(0xFF075E4D),
        behavior:
        SnackBarBehavior.floating,
      ),
    );
  }

  // =====================================================
  // STEP TITLE
  // =====================================================

  String _stepTitle() {
    if (_currentStep == 0) {
      return widget.isEditing
          ? 'Edit Course'
          : 'Create New Course';
    }

    if (_currentStep == 1) {
      return 'Curriculum Builder';
    }

    return widget.isEditing
        ? 'Review & Save'
        : 'Review & Publish';
  }

  // =====================================================
  // STEP SUBTITLE
  // =====================================================

  String _stepSubtitle() {
    if (_currentStep == 0) {
      return widget.isEditing
          ? 'Update your course information and make the changes you need.'
          : 'Start with the basics. You can always change these later.';
    }

    if (_currentStep == 1) {
      return 'Organize your course into sections, lessons and activities.';
    }

    return widget.isEditing
        ? 'Review your changes before saving the updated course.'
        : 'Check everything one last time before submitting your course.';
  }

  // =====================================================
  // BOTTOM BUTTON TEXT
  // =====================================================

  String _bottomButtonText() {
    if (_currentStep == 0) {
      return 'Save & Continue  →';
    }

    if (_currentStep == 1) {
      return 'Save & Continue  →';
    }

    return widget.isEditing
        ? 'Save Changes  →'
        : 'Submit for Review  →';
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.fromLTRB(
                16,
                10,
                16,
                14,
              ),
              decoration:
              const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE4ECE9),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  // =============================================
                  // BACK + TITLE
                  // =============================================

                  Row(
                    children: [
                      IconButton(
                        onPressed:
                        _previousStep,
                        padding:
                        EdgeInsets.zero,
                        constraints:
                        const BoxConstraints(
                          minWidth: 28,
                          minHeight: 28,
                        ),
                        icon:
                        const Icon(
                          Icons.arrow_back_rounded,
                          size: 21,
                          color:
                          Color(0xFF263C38),
                        ),
                      ),

                      const SizedBox(
                        width: 7,
                      ),

                      Expanded(
                        child: Text(
                          _stepTitle(),
                          style:
                          GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.w800,
                            color:
                            const Color(
                              0xFF073F38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // =============================================
                  // SUBTITLE
                  // =============================================

                  Padding(
                    padding:
                    const EdgeInsets.only(
                      left: 35,
                      top: 3,
                    ),
                    child: Text(
                      _stepSubtitle(),
                      style:
                      GoogleFonts.inter(
                        fontSize: 11.5,
                        height: 1.4,
                        color:
                        const Color(
                          0xFF788681,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 13,
                  ),

                  // =============================================
                  // STEP INDICATOR
                  // =============================================

                  CourseCreationStepIndicator(
                    currentStep:
                    _currentStep,
                  ),
                ],
              ),
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child:
              SingleChildScrollView(
                padding:
                const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  24,
                ),
                child:
                _buildCurrentStep(),
              ),
            ),

            // =================================================
            // BOTTOM ACTION
            // =================================================

            Container(
              padding:
              const EdgeInsets.fromLTRB(
                16,
                10,
                16,
                14,
              ),
              decoration:
              const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFE1EAE7),
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(
                      0xFF075E4D,
                    ),
                    foregroundColor:
                    Colors.white,
                    elevation: 0,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Text(
                    _bottomButtonText(),
                    style:
                    GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // CURRENT STEP
  // =====================================================

  Widget _buildCurrentStep() {
    switch (_currentStep) {
    // ===================================================
    // STEP 1
    // ===================================================

      case 0:
        return CreateCourseBasicInfo(
          titleController:
          _titleController,
          descriptionController:
          _descriptionController,
          priceController:
          _priceController,
          selectedCategory:
          _selectedCategory,
          selectedLevel:
          _selectedLevel,
          selectedLanguage:
          _selectedLanguage,

          onCategoryChanged:
              (value) {
            setState(() {
              _selectedCategory =
                  value;
            });
          },

          onLevelChanged:
              (value) {
            setState(() {
              _selectedLevel =
                  value;
            });
          },

          onLanguageChanged:
              (value) {
            setState(() {
              _selectedLanguage =
                  value;
            });
          },
        );

    // ===================================================
    // STEP 2
    // ===================================================

      case 1:
        return const CreateCourseCurriculum();

    // ===================================================
    // STEP 3
    // ===================================================

      case 2:
        return CreateCourseReview(
          title:
          _titleController.text.isEmpty
              ? 'Mastering Leadership Communication'
              : _titleController.text,

          description:
          _descriptionController.text,

          category:
          _selectedCategory,

          level:
          _selectedLevel,

          language:
          _selectedLanguage,

          price:
          _priceController.text.isEmpty
              ? '\$299.00'
              : '\$${_priceController.text}',
        );
    }

    return const SizedBox.shrink();
  }
}