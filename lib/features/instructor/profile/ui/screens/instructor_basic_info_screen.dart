import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_state.dart';

import '../widgets/basic_info/instructor_basic_info_form.dart';

class InstructorBasicInfoScreen extends StatefulWidget {
  const InstructorBasicInfoScreen({
    super.key,
  });

  @override
  State<InstructorBasicInfoScreen> createState() =>
      _InstructorBasicInfoScreenState();
}

class _InstructorBasicInfoScreenState
    extends State<InstructorBasicInfoScreen> {
  // =========================================================
  // CONTROLLERS
  // =========================================================

  late final TextEditingController _nameController;
  late final TextEditingController _titleController;
  late final TextEditingController _headlineController;
  late final TextEditingController _experienceController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _hourlyRateController;
  late final TextEditingController _locationController;
  late final TextEditingController _bioController;
  late final TextEditingController _skillSearchController;

  // =========================================================
  // DATA
  // =========================================================

  String _specialization = 'Software Development';

  final List<String> _skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'React Native',
    'Python',
  ];

  bool _profileLoaded = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _titleController = TextEditingController(text: 'Instructor');
    _headlineController = TextEditingController(text: 'Certified Instructor');
    _experienceController = TextEditingController(text: '3');
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _hourlyRateController = TextEditingController();
    _locationController = TextEditingController();
    _bioController = TextEditingController();
    _skillSearchController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _headlineController.dispose();
    _experienceController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _hourlyRateController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    _skillSearchController.dispose();

    super.dispose();
  }

  // =========================================================
  // SAVE
  // =========================================================

  void _saveChanges() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Profile information saved successfully.',
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
    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: Scaffold(
        backgroundColor: AppColors.bgDefault,

        body: SafeArea(
          child: Column(
            children: [
              // =================================================
              // HEADER
              // =================================================

              _buildHeader(),

              // =================================================
              // FORM
              // =================================================

              Expanded(
                child: BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileLoadSuccess && !_profileLoaded) {
                      _profileLoaded = true;
                      final profile = state.profile;
                      setState(() {
                        _nameController.text = profile.fullName ?? '';
                        _emailController.text = profile.email ?? '';
                      });
                    }
                  },
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF075E4D),
                          ),
                        );
                      }

                      return InstructorBasicInfoForm(
                        nameController: _nameController,
                        titleController: _titleController,
                        headlineController: _headlineController,
                        experienceController: _experienceController,
                        phoneController: _phoneController,
                        emailController: _emailController,
                        hourlyRateController: _hourlyRateController,
                        locationController: _locationController,
                        bioController: _bioController,
                        skillSearchController: _skillSearchController,
                        specialization: _specialization,
                        skills: _skills,
                        onSpecializationChanged: (value) {
                          setState(() {
                            _specialization = value;
                          });
                        },
                        onRemoveSkill: (skill) {
                          setState(() {
                            _skills.remove(skill);
                          });
                        },
                        onAddSkill: (skill) {
                          if (skill.trim().isEmpty) return;

                          if (_skills.contains(skill.trim())) return;

                          setState(() {
                            _skills.add(skill.trim());
                            _skillSearchController.clear();
                          });
                        },
                        onSave: _saveChanges,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2EBE8),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 21,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(width: 2),

          const Text(
            'Basic Info & Skills',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}