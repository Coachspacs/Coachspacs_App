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
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor:
        const Color(0xFF075E4D),
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

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: _previousStep,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF263C38),
          ),
        ),
        title: Text(
          _currentStep == 0
              ? 'Create New Course'
              : _currentStep == 1
              ? 'Curriculum Builder'
              : 'Review & Publish',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // =================================================
            // STEP INDICATOR
            // =================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                14,
                16,
                0,
              ),
              child: CourseCreationStepIndicator(
                currentStep: _currentStep,
              ),
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  20,
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
                height: 42,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF075E4D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                    RoundedRectangleBorder(
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
                      fontSize: 10,
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

      case 1:
        return const CreateCourseCurriculum();

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