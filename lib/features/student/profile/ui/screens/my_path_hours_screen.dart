import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
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
import '../widgets/my_path_hours/my_path_hours_header.dart';
import '../widgets/my_path_hours/my_path_hours_options.dart';

class MyPathHoursScreen extends StatelessWidget {
  const MyPathHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MyPathCubit>(),
      child: const _MyPathHoursView(),
    );
  }
}

class _MyPathHoursView extends StatelessWidget {
  const _MyPathHoursView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: MyPathColors.background,

      appBar: AppBar(
        backgroundColor: MyPathColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
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
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeSlideIn(
                    index: 0,
                    child: const MyPathHoursHeader(),
                  ),

                  const SizedBox(height: 12),

                  FadeSlideIn(
                    index: 1,
                    child: MyPathAnimatedRoadmap(
                      labels: const ['Goal', 'Level', 'Skill', 'Schedule'],
                      currentStep: 3,
                      trailingBadge: 'Step 4 of 4',
                    ),
                  ),

                  const SizedBox(height: 14),

                  FadeSlideIn(
                    index: 2,
                    child: MyPathHoursOptions(
                      selectedId: state.hours?.id,
                      onSelected: (MyPathOption hours) =>
                          context.read<MyPathCubit>().selectHours(hours),
                    ),
                  ),

                  const SizedBox(height: 26),

                  FadeSlideIn(
                    index: 3,
                    child: MyPathPrimaryButton(
                      label: l10n.commonContinue,
                      onPressed: state.hours == null
                          ? null
                          : () {
                              context.read<MyPathCubit>().complete();
                              context.replaceMyPath(AppRoutes.studentMyPath);
                            },
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
