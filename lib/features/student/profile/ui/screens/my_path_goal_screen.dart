import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/helpers/my_path_navigation.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/fade_slide_in.dart';
import '../../logic/cubit/my_path_cubit.dart';
import '../widgets/my_path/my_path_animated_roadmap.dart';
import '../widgets/my_path/my_path_palette.dart';
import '../widgets/my_path/my_path_primary_button.dart';
import '../widgets/my_path_goal/my_path_goal_header.dart';
import '../widgets/my_path_goal/my_path_goal_options.dart';

class MyPathGoalScreen extends StatelessWidget {
  const MyPathGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MyPathCubit>(),
      child: const _MyPathGoalView(),
    );
  }
}

class _MyPathGoalView extends StatelessWidget {
  const _MyPathGoalView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeSlideIn(
                    index: 0,
                    child: const MyPathGoalHeader(),
                  ),

                  const SizedBox(height: 14),

                  FadeSlideIn(
                    index: 1,
                    child: MyPathAnimatedRoadmap(
                      labels: const ['Goal', 'Level', 'Skill', 'Schedule'],
                      currentStep: 0,
                      trailingBadge: 'Step 1 of 4',
                    ),
                  ),

                  const SizedBox(height: 14),

                  FadeSlideIn(
                    index: 2,
                    child: MyPathGoalOptions(
                      selectedId: state.goal?.id,
                      onSelected: context.read<MyPathCubit>().selectGoal,
                    ),
                  ),

                  const SizedBox(height: 26),

                  FadeSlideIn(
                    index: 3,
                    child: MyPathPrimaryButton(
                      label: 'Continue',
                      onPressed: state.goal == null
                          ? null
                          : () => context.replaceMyPath(
                                AppRoutes.studentMyPathLevel,
                              ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
