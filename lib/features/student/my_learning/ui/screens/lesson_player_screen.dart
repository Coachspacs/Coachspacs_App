import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/logic/cubit/lesson_player_cubit.dart';

class LessonPlayerScreen extends StatefulWidget {
  const LessonPlayerScreen({super.key});

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  late final LessonPlayerCubit _cubit;
  int? _enrollmentId;
  int? _lessonId;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<LessonPlayerCubit>();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final args = arguments is Map ? arguments : const <String, dynamic>{};
    final enrollmentId = args['enrollmentId'];
    final lessonId = args['lessonId'];
    _enrollmentId = enrollmentId is int ? enrollmentId : null;
    _lessonId = lessonId is int ? lessonId : null;
    final enrollment = _enrollmentId;
    final lesson = _lessonId;
    if (enrollment != null && lesson != null) {
      _cubit.load(enrollmentId: enrollment, lessonId: lesson);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SafeArea(
          child: Column(
            children: [
              _LessonPlayerHeader(
                onBack: () => Navigator.pop(context),
              ),
              const Divider(height: 1, color: Color(0xFFE4ECE9)),
              Expanded(
                child: BlocBuilder<LessonPlayerCubit, LessonPlayerState>(
                  builder: (context, state) {
                    return switch (state) {
                      LessonPlayerInitial() => const SizedBox.shrink(),
                      LessonPlayerLoading() => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF075E4D),
                        ),
                      ),
                      LessonPlayerFailure() => _PlayerFailureView(
                        message: localizedFailureMessage(
                          context,
                          state.kind,
                          state.message,
                        ),
                        onRetry: () {
                          final enrollment = _enrollmentId;
                          final lesson = _lessonId;
                          if (enrollment != null && lesson != null) {
                            _cubit.load(
                              enrollmentId: enrollment,
                              lessonId: lesson,
                            );
                          }
                        },
                      ),
                      LessonPlayerSuccess() =>
                        _PlayerSuccessView(state: state),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerSuccessView extends StatelessWidget {
  const _PlayerSuccessView({required this.state});

  final LessonPlayerSuccess state;

  LessonPlayerDto get lesson => state.lesson;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<LessonPlayerCubit>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFDCE8E4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4F6F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.play_circle_fill_rounded,
                      size: 24,
                      color: Color(0xFF075E4D),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF073F38),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${lesson.section} · ${lesson.durationMinutes} min',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: const Color(0xFF71827E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  onPressed: _openVideo,
                  icon: const Icon(Icons.play_arrow_rounded, size: 20),
                  label: Text(
                    l10n.lessonPlayerOpenVideo,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF075E4D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            onPressed: state.isTogglingCompletion
                ? null
                : cubit.markComplete,
            icon: state.isTogglingCompletion
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_circle_outline_rounded, size: 19),
            label: Text(
              l10n.lessonPlayerMarkComplete,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF075E4D),
              side: const BorderSide(color: Color(0xFFBFE9D8), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _NavButton(
                label: l10n.lessonPlayerPrevious,
                icon: Icons.arrow_back_rounded,
                enabled: lesson.previousLessonId != null,
                onTap: () {
                  final previous = lesson.previousLessonId;
                  if (previous != null) {
                    cubit.openLesson(state.enrollmentId, previous);
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _NavButton(
                label: l10n.lessonPlayerNext,
                icon: Icons.arrow_forward_rounded,
                enabled: lesson.nextLessonId != null,
                onTap: () {
                  final next = lesson.nextLessonId;
                  if (next != null) {
                    cubit.openLesson(state.enrollmentId, next);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _openVideo() async {
    final uri = Uri.tryParse(lesson.videoUrl);
    if ((uri == null || lesson.videoUrl.isEmpty)) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // The platform cannot open the URL; nothing else to do here.
    }
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton.icon(
        onPressed: enabled ? onTap : null,
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: enabled
              ? const Color(0xFF075E4D)
              : const Color(0xFFB7C5C0),
          side: BorderSide(
            color: enabled
                ? const Color(0xFFBFE9D8)
                : const Color(0xFFE1E9E6),
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      ),
    );
  }
}

class _PlayerFailureView extends StatelessWidget {
  const _PlayerFailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 46, color: Colors.grey.shade400),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12.5,
                height: 1.45,
                color: const Color(0xFF71827E),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 17),
              label: Text(
                context.l10n.commonRetry,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonPlayerHeader extends StatelessWidget {
  const _LessonPlayerHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 23,
              color: Color(0xFF073F38),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            context.l10n.lessonPlayerTitle,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}