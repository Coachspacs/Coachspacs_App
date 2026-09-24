import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository.dart';
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
  // STEP TRANSITION DIRECTION + SCROLL
  // =====================================================

  bool _isForward = true;
  final ScrollController _contentScrollController =
      ScrollController();

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
  // FREE + COVER IMAGE
  // =====================================================

  bool _isFree = false;
  File? _coverImage;
  String? _lastPaidPrice;

  // =====================================================
  // SERVER DRAFT + CURRICULUM
  // =====================================================

  int? _createdCourseId;
  bool _hasUploadedCover = false;
  List<InstructorSectionDto> _sections = [];

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
    _contentScrollController.dispose();

    super.dispose();
  }

  // =====================================================
  // SCROLL CONTENT TO TOP ON STEP CHANGE
  // =====================================================

  void _scrollContentToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_contentScrollController.hasClients) {
        return;
      }
      _contentScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
  }

  // =====================================================
  // NEXT STEP
  // =====================================================

  Future<void> _nextStep() async {
    if (_currentStep == 0) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      if (title.isEmpty || description.isEmpty) {
        _showSnack(
          'Please fill in the course title and description.',
          isError: true,
        );
        return;
      }

      setState(() {
        _isSaving = true;
      });
      try {
        await _ensureCourseCreated();
        if (!mounted) return;
        setState(() {
          _isSaving = false;
          _isForward = true;
          _currentStep = 1;
        });
        _scrollContentToTop();
      } on NetworkException catch (error) {
        if (!mounted) return;
        setState(() => _isSaving = false);
        _showSnack(
          localizedFailureMessage(context, error.kind, error.message),
          isError: true,
        );
      } catch (_) {
        if (!mounted) return;
        setState(() => _isSaving = false);
        _showSnack(
          'Something went wrong. Please try again.',
          isError: true,
        );
      }
      return;
    }

    if (_currentStep < 2) {
      setState(() {
        _isForward = true;
        _currentStep++;
      });
      _scrollContentToTop();
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
        _isForward = false;
        _currentStep--;
      });
      _scrollContentToTop();
      return;
    }

    Navigator.pop(context);
  }

  // =====================================================
  // FREE TOGGLE + COVER IMAGE
  // =====================================================

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

  Future<void> _pickCoverImage() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        maxHeight: 900,
        imageQuality: 85,
      );
      if (picked == null) return;
      setState(() {
        _coverImage = File(picked.path);
      });
    } catch (_) {
      if (!mounted) return;
      _showSnack(
        'Unable to select image. Please try again.',
        isError: true,
      );
    }
  }

  // =====================================================
  // SAVE / SUBMIT
  // =====================================================

  bool _isSaving = false;

  String _resolvedPrice() {
    if (_isFree || _priceController.text.trim().isEmpty) return '0';
    return _priceController.text.trim();
  }

  Future<void> _ensureCourseCreated() async {
    final repo = getIt<InstructorCoursesRepository>();

    if (_createdCourseId == null) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      if (title.isEmpty || description.isEmpty) {
        throw const NetworkException(
          kind: FailureKind.validation,
          message: 'Please fill in the course title and description.',
        );
      }

      final request = CourseWriteRequest(
        titleAr: title,
        titleEn: title,
        descriptionAr: description,
        descriptionEn: description,
        category: await _resolveCategoryId(_selectedCategory),
        level: _toLevelCode(_selectedLevel),
        language: _toLanguageCode(_selectedLanguage),
        price: _resolvedPrice(),
      );

      final created = await repo.createCourse(request);
      _createdCourseId = created.id;
    } else {
      await repo.updateCourse(
        _createdCourseId!,
        CoursePatchRequest(
          titleAr: _titleController.text.trim(),
          titleEn: _titleController.text.trim(),
          descriptionAr: _descriptionController.text.trim(),
          descriptionEn: _descriptionController.text.trim(),
          category: await _resolveCategoryId(_selectedCategory),
          level: _toLevelCode(_selectedLevel),
          language: _toLanguageCode(_selectedLanguage),
          price: _resolvedPrice(),
        ),
      );
    }

    final File? image = _coverImage;
    if (image != null && !_hasUploadedCover) {
      try {
        await repo.uploadCoverImage(_createdCourseId!, image);
        _hasUploadedCover = true;
      } on NetworkException {
        // Cover upload is best-effort; surfaced later if needed.
      } catch (_) {
        // Cover upload is best-effort; surfaced later if needed.
      }
    }
  }

  bool _hasCurriculumReady() {
    if (_sections.isEmpty) return false;
    return _sections.any((section) => section.lessons.isNotEmpty);
  }

  Future<void> _saveCourse() async {
    if (_isSaving) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (title.isEmpty || description.isEmpty) {
      _showSnack(
        'Please fill in the course title and description.',
        isError: true,
      );
      return;
    }

    if (!_hasCurriculumReady()) {
      _showSnack(
        'Add at least one section with a lesson before submitting.',
        isError: true,
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final repo = getIt<InstructorCoursesRepository>();

    try {
      if (widget.isEditing) {
        throw const NetworkException(
          kind: FailureKind.unknown,
          message: 'Editing must be done from the course management screen.',
        );
      }

      await _ensureCourseCreated();
      final courseId = _createdCourseId;
      if (courseId == null) {
        throw const NetworkException(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        );
      }

      try {
        await repo.submitCourse(courseId);
      } on NetworkException catch (error) {
        if (!mounted) return;
        setState(() {
          _isSaving = false;
        });
        _showSnack(
          localizedFailureMessage(context, error.kind, error.message),
          isError: true,
        );
        return;
      }

      if (!mounted) return;
      _showSnack('Course submitted for review.', isError: false);

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.instructorCourses,
        (route) => false,
      );
    } on NetworkException catch (error) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
      _showSnack(
        localizedFailureMessage(context, error.kind, error.message),
        isError: true,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
      _showSnack(
        'Something went wrong. Please try again.',
        isError: true,
      );
    }
  }

  // =====================================================
  // CATEGORY RESOLUTION
  // =====================================================

  Future<int> _resolveCategoryId(String name) async {
    if (name.isEmpty || name == 'Select a category') return 1;
    try {
      final categories = await getIt<CatalogRepository>().getCategories();
      for (final CategoryDto category in categories) {
        if (category.name.toLowerCase() == name.toLowerCase()) {
          return category.id;
        }
      }
    } catch (_) {
      // Fall through: the server validates category anyway.
    }
    return 1;
  }

  // =====================================================
  // VALUE MAPPERS
  // =====================================================

  String _toLevelCode(String level) {
    switch (level) {
      case 'Beginner':
        return 'beginner';
      case 'Advanced':
        return 'advanced';
      default:
        return 'intermediate';
    }
  }

  String _toLanguageCode(String language) {
    switch (language) {
      case 'Arabic':
        return 'ar';
      default:
        return 'en';
    }
  }

  // =====================================================
  // SNACKBAR
  // =====================================================

  void _showSnack(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: isError ? const Color(0xFFB3261E) : const Color(0xFF075E4D),
        behavior: SnackBarBehavior.floating,
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
                        child: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 350,
                          ),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            final offset = Tween<Offset>(
                              begin: Offset(
                                _isForward ? 0.25 : -0.25,
                                0,
                              ),
                              end: Offset.zero,
                            ).animate(animation);

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: offset,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            _stepTitle(),
                            key: ValueKey(
                              'step_title_$_currentStep',
                            ),
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
                    child: AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        final offset = Tween<Offset>(
                          begin: Offset(
                            0,
                            _isForward ? 0.15 : -0.15,
                          ),
                          end: Offset.zero,
                        ).animate(animation);

                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: offset,
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        _stepSubtitle(),
                        key: ValueKey(
                          'step_subtitle_$_currentStep',
                        ),
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
                controller:
                _contentScrollController,
                padding:
                const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  24,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder:
                      (child, animation) {
                    final offset =
                    Tween<Offset>(
                      begin: Offset(
                        _isForward ? 0.3 : -0.3,
                        0,
                      ),
                      end: Offset.zero,
                    ).animate(animation);

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: offset,
                        child: child,
                      ),
                    );
                  },
                  child: SizedBox(
                    key: ValueKey(
                      'course_step_$_currentStep',
                    ),
                    width: double.infinity,
                    child: _buildCurrentStep(),
                  ),
                ),
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
                  onPressed: _isSaving ? null : _nextStep,
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
                  child: AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder:
                        (child, animation) {
                      final offset =
                      Tween<Offset>(
                        begin: Offset(
                          _isForward ? 0.4 : -0.4,
                          0,
                        ),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offset,
                          child: child,
                        ),
                      );
                    },
                  child: Text(
                    _isSaving && _currentStep == 2
                        ? 'Submitting…'
                        : _bottomButtonText(),
                      key: ValueKey(
                        'step_button_$_currentStep',
                      ),
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
          isFree: _isFree,
          onFreeChanged: _toggleFree,
          onPickThumbnail: _pickCoverImage,
          coverImage: _coverImage,

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
        if (_createdCourseId == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: CircularProgressIndicator(
                color: Color(0xFF075E4D),
              ),
            ),
          );
        }
        return CreateCourseCurriculum(
          courseId: _createdCourseId!,
          language: _toLanguageCode(_selectedLanguage),
          onChanged: (sections) {
            if (!mounted) return;
            setState(() {
              _sections = sections;
            });
          },
        );

    // ===================================================
    // STEP 3
    // ===================================================

      case 2:
        return CreateCourseReview(
          title:
          _titleController.text.isEmpty
              ? 'Untitled Course'
              : _titleController.text,

          description:
          _descriptionController.text,

          category:
          _selectedCategory,

          level:
          _selectedLevel,

          language:
          _selectedLanguage,

          price: _isFree ||
              _priceController.text.isEmpty ||
              _resolvedPrice() == '0'
              ? 'Free'
              : '\$${_resolvedPrice()}',

          sections: _sections,

          onEditBasic: () {
            setState(() {
              _currentStep = 0;
            });
          },

          onEditCurriculum: () {
            setState(() {
              _currentStep = 1;
            });
          },
        );
    }

    return const SizedBox.shrink();
  }
}