import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/course_creation_step_indicator.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/create_course_basic_info.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/create_course_curriculum.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/create_course_review.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({
    super.key,
  });

  @override
  State<CreateCourseScreen> createState() =>
      _CreateCourseScreenState();
}

class _CreateCourseScreenState
    extends State<CreateCourseScreen> {
  int _currentStep = 0;

  final TextEditingController _titleController =
  TextEditingController();

  final TextEditingController _descriptionController =
  TextEditingController();

  final TextEditingController _priceController =
  TextEditingController();

  String _selectedCategory = 'Select a category';
  String _selectedLevel = 'Beginner';
  String _selectedLanguage = 'English';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // =====================================================
  // NEXT
  // =====================================================

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitCourse();
    }
  }

  // =====================================================
  // BACK
  // =====================================================

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // =====================================================
  // SUBMIT
  // =====================================================

  void _submitCourse() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Course submitted for review.',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF075E4D),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
// COURSE CREATION HEADER
// =================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                16,
                10,
                16,
                14,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE4ECE9),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =============================================
                  // BACK + TITLE
                  // =============================================

                  Row(
                    children: [
                      IconButton(
                        onPressed: _previousStep,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 28,
                          minHeight: 28,
                        ),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 21,
                          color: Color(0xFF263C38),
                        ),
                      ),

                      const SizedBox(width: 7),

                      Expanded(
                        child: Text(
                          _currentStep == 0
                              ? 'Create New Course'
                              : _currentStep == 1
                              ? 'Curriculum Builder'
                              : 'Review & Publish',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF073F38),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // =============================================
                  // SUBTITLE
                  // =============================================

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 35,
                      top: 3,
                    ),
                    child: Text(
                      _currentStep == 0
                          ? 'Start with the basics. You can always change these later.'
                          : _currentStep == 1
                          ? 'Organize your course into sections, lessons and activities.'
                          : 'Check everything one last time before submitting your course.',
                      style: GoogleFonts.inter(
                        fontSize: 9.5,
                        height: 1.4,
                        color: const Color(0xFF788681),
                      ),
                    ),
                  ),

                  const SizedBox(height: 13),

                  // =============================================
                  // STEP INDICATOR
                  // =============================================

                  CourseCreationStepIndicator(
                    currentStep: _currentStep,
                  ),
                ],
              ),
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  24,
                ),
                child: _buildCurrentStep(),
              ),
            ),

            // =================================================
            // BOTTOM BUTTON
            // =================================================

            Container(
              padding: const EdgeInsets.fromLTRB(
                16,
                10,
                16,
                14,
              ),
              decoration: const BoxDecoration(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF075E4D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _currentStep == 0
                        ? 'Save & Continue  →'
                        : _currentStep == 1
                        ? 'Save & Continue  →'
                        : 'Submit for Review  →',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
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
          titleController: _titleController,
          descriptionController:
          _descriptionController,
          priceController: _priceController,
          selectedCategory:
          _selectedCategory,
          selectedLevel: _selectedLevel,
          selectedLanguage: _selectedLanguage,
          onCategoryChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          onLevelChanged: (value) {
            setState(() {
              _selectedLevel = value;
            });
          },
          onLanguageChanged: (value) {
            setState(() {
              _selectedLanguage = value;
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
          title: _titleController.text.isEmpty
              ? 'Mastering Leadership Communication'
              : _titleController.text,
          description:
          _descriptionController.text,
          category: _selectedCategory,
          level: _selectedLevel,
          language: _selectedLanguage,
          price: _priceController.text.isEmpty
              ? '\$299.00'
              : '\$${_priceController.text}',
        );
    }

    return const SizedBox.shrink();
  }
}