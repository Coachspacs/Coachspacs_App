import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/helpers/my_path_navigation.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/fade_slide_in.dart';
import '../../data/models/my_path_models.dart';
import '../../logic/cubit/my_path_cubit.dart';
import '../widgets/my_path/my_path_animated_roadmap.dart';
import '../widgets/my_path/my_path_palette.dart';
import '../widgets/my_path/my_path_primary_button.dart';
import '../widgets/my_path_skill/skill_options.dart';
import '../widgets/my_path_skill/skill_search_bar.dart';

class MyPathSkillScreen extends StatefulWidget {
  const MyPathSkillScreen({super.key});

  @override
  State<MyPathSkillScreen> createState() => _MyPathSkillScreenState();
}

class _MyPathSkillScreenState extends State<MyPathSkillScreen> {
  String searchQuery = '';
  bool popularOnly = false;

  List<MyPathSkillOption> get _filteredSkills {
    return MyPathSkillOptionsData.all.where((skill) {
      final query = searchQuery.toLowerCase();
      final matchesQuery = query.isEmpty ||
          skill.title.toLowerCase().contains(query) ||
          skill.tags.any((tag) => tag.toLowerCase().contains(query));
      final matchesFilter = !popularOnly || skill.popular;
      return matchesQuery && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MyPathCubit>(),
      child: Scaffold(
        backgroundColor: MyPathColors.background,
        appBar: AppBar(
          backgroundColor: MyPathColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 23,
              color: MyPathColors.textPrimary,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          leadingWidth: 52,
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            'My Path',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyPathColors.primary,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: BlocBuilder<MyPathCubit, MyPathState>(
            builder: (context, state) {
              final filteredSkills = _filteredSkills;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeSlideIn(
                      index: 0,
                      child: Center(
                        child: Text(
                          'What skill do you want to learn?',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF172033),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    FadeSlideIn(
                      index: 1,
                      child: MyPathAnimatedRoadmap(
                        labels: const ['Goal', 'Level', 'Skill', 'Schedule'],
                        currentStep: 2,
                        trailingBadge: 'Step 3 of 4',
                      ),
                    ),

                    const SizedBox(height: 24),

                    FadeSlideIn(
                      index: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          'Select your primary focus skill or domain so our AI '
                          'companion can curate tailored modules, practical '
                          'capstones, and personalized learning milestones.',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            height: 1.7,
                            color: const Color(0xFF687894),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    FadeSlideIn(
                      index: 3,
                      child: SkillSearchBar(
                        onChanged: (value) =>
                            setState(() => searchQuery = value),
                        filterActive: popularOnly,
                        onFilterToggle: (value) =>
                            setState(() => popularOnly = value),
                      ),
                    ),

                    const SizedBox(height: 20),

                    FadeSlideIn(
                      index: 4,
                      child: filteredSkills.isEmpty
                          ? const _NoResultsCard()
                          : SkillOptions(
                              options: filteredSkills,
                              selectedId: state.skill?.id,
                              onSelected:
                                  context.read<MyPathCubit>().selectSkill,
                            ),
                    ),

                    const SizedBox(height: 18),

                    FadeSlideIn(
                      index: 5,
                      child: MyPathPrimaryButton(
                        label: 'Continue',
                        onPressed: state.skill == null
                            ? null
                            : () => context.replaceMyPath(
                                  AppRoutes.studentMyPathHours,
                                ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NoResultsCard extends StatelessWidget {
  const _NoResultsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MyPathColors.cardBorder),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 34,
            color: Color(0xFF9DAEB2),
          ),
          const SizedBox(height: 10),
          Text(
            'No skills match your search',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: MyPathColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try a different keyword or clear the popular filter.',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: MyPathColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
