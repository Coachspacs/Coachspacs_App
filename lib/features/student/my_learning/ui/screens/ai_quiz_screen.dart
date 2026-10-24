import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/back_title_header.dart';
import 'package:coach_space/core/widgets/confirm_dialog.dart';
import 'package:coach_space/features/student/my_learning/data/models/ai_quiz_dtos.dart';
import 'package:coach_space/features/student/my_learning/logic/cubit/ai_quiz_cubit.dart';

/// AI practice quizzes for one course: pick an existing quiz, generate a new
/// one (202 + polling), answer the questions and review the scored result.
///
/// The courseId arrives through `ModalRoute.settings.arguments` (plain int);
/// it is read in [build] (never `initState`) because the route's arguments are
/// only guaranteed to be installed once the route is on screen.
class AIQuizScreen extends StatelessWidget {
  const AIQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context)!.settings.arguments as int?;

    return BlocProvider(
      create: (_) => getIt<AIQuizCubit>()..load(courseId),
      child: const _AIQuizView(),
    );
  }
}

class _AIQuizView extends StatefulWidget {
  const _AIQuizView();

  @override
  State<_AIQuizView> createState() => _AIQuizViewState();
}

class _AIQuizViewState extends State<_AIQuizView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isTaking,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop || !_isTaking) return;
        final exit = await ConfirmDialog.show(
          context,
          title: context.l10n.aiQuizTitle,
          message: context.l10n.aiQuizSavedAnswersLost,
          confirmLabel: context.l10n.aiQuizBackToCourse,
          destructive: true,
        );
        if (exit && mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackTitleHeader(title: context.l10n.aiQuizTitle),
              Expanded(
                child: BlocConsumer<AIQuizCubit, AIQuizState>(
                  listener: _onStateChange,
                  builder: (context, state) => switch (state) {
                    AIQuizListLoading() ||
                    AIQuizInitial() ||
                    AIQuizStarting() => _buildSpinner(),
                    AIQuizListLoaded(:final quizzes) => _QuizListView(
                      quizzes: quizzes,
                      onCreate: () => context.read<AIQuizCubit>().createQuiz(),
                      onOpen: (quiz) async {
                        if (quiz.isPending) {
                          context.read<AIQuizCubit>().pollQuiz(quiz);
                          return;
                        }
                        if (quiz.isFailed) {
                          context.read<AIQuizCubit>().createQuiz();
                          return;
                        }
                        context.read<AIQuizCubit>().openQuiz(quiz);
                      },
                    ),
                    AIQuizPolling(:final attempt, :final maxAttempts) =>
                      _PollingView(
                        attempt: attempt,
                        maxAttempts: maxAttempts,
                        onCancel: () =>
                            context.read<AIQuizCubit>().backToList(),
                      ),
                    AIQuizReady(:final quiz, :final answers) => _TakeQuizView(
                      quiz: quiz,
                      answers: answers,
                      currentIndex: _currentIndex,
                      onIndexChanged: (value) =>
                          setState(() => _currentIndex = value),
                      onSelect: (questionId, optionIndex) => context
                          .read<AIQuizCubit>()
                          .selectAnswer(questionId, optionIndex),
                      onSubmit: () => _confirmSubmit(quiz, answers),
                    ),
                    AIQuizSubmitting() => _buildSpinner(),
                    AIQuizResultLoaded(:final result, :final quiz) =>
                      _ResultView(
                        result: result,
                        quiz: quiz,
                        onBack: () => context.read<AIQuizCubit>().backToList(),
                      ),
                    AIQuizFailure() => _FailureView(
                      message: localizedFailureMessage(
                        context,
                        state.kind,
                        state.message,
                      ),
                      onRetry: () => context.read<AIQuizCubit>().retry(),
                      onBackToList: () =>
                          context.read<AIQuizCubit>().backToList(),
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _isTaking {
    final state = context.read<AIQuizCubit>().state;
    return state is AIQuizReady;
  }

  Widget _buildSpinner() =>
      const Center(child: CircularProgressIndicator(color: AppColors.primary));

  void _onStateChange(BuildContext context, AIQuizState state) {
    final state0 = state;
    if (state0 is AIQuizListLoaded || state0 is AIQuizReady) {
      final questions = state0 is AIQuizReady
          ? state0.quiz.questions.length
          : 0;
      if (state0 is! AIQuizReady ||
          questions == 0 ||
          _currentIndex >= questions) {
        _currentIndex = 0;
      }
      setState(() {});
    }
  }

  Future<void> _confirmSubmit(AIQuizDto quiz, Map<int, int> answers) async {
    final missing = quiz.questions.where(
      (question) => !answers.containsKey(question.id),
    );
    final confirmed = await ConfirmDialog.show(
      context,
      title: context.l10n.aiQuizSubmitConfirmTitle,
      message: missing.isEmpty
          ? context.l10n.aiQuizSubmit
          : context.l10n.aiQuizSubmitConfirmMessage(missing.length),
      confirmLabel: context.l10n.aiQuizSubmit,
      cancelLabel: context.l10n.commonCancel,
    );
    if (confirmed && mounted) context.read<AIQuizCubit>().submit();
  }
}

// ==============================================================
// Phase: list of generated quizzes
// ==============================================================

class _QuizListView extends StatelessWidget {
  const _QuizListView({
    required this.quizzes,
    required this.onCreate,
    required this.onOpen,
  });

  final List<AIQuizDto> quizzes;
  final VoidCallback onCreate;
  final ValueChanged<AIQuizDto> onOpen;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: [
        ElevatedButton.icon(
          onPressed: onCreate,
          icon: const Icon(Icons.auto_awesome, size: 18),
          label: Text(
            context.l10n.aiQuizNewQuiz,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (quizzes.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Text(
              context.l10n.aiQuizNoQuizzes,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          ...quizzes.map((quiz) => _QuizTile(quiz: quiz, onOpen: onOpen)),
      ],
    );
  }
}

class _QuizTile extends StatelessWidget {
  const _QuizTile({required this.quiz, required this.onOpen});

  final AIQuizDto quiz;
  final ValueChanged<AIQuizDto> onOpen;

  String get _subtitle {
    final count = quiz.questionCount ?? quiz.questions.length;
    final created = quiz.createdAt;
    final parts = <String>[
      if (count > 0) '$count questions',
      if (created != null) '${created.day}/${created.month}/${created.year}',
    ];
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pending = quiz.isPending;
    final failed = quiz.isFailed;
    final (label, color) = pending
        ? (l10n.aiQuizGenerating, AppColors.textSecondary)
        : failed
        ? (l10n.aiQuizFailed, Colors.red)
        : (l10n.aiQuizStart, AppColors.primary);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: .4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz.detail?.isNotEmpty ?? false
                      ? quiz.detail!
                      : context.l10n.aiQuizTitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (quiz.questionCount != null || quiz.createdAt != null)
                  const SizedBox(height: 4),
                Text(
                  _subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (pending)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            TextButton(
              onPressed: () => onOpen(quiz),
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ==============================================================
// Phase: generation in progress
// ==============================================================

class _PollingView extends StatelessWidget {
  const _PollingView({
    required this.attempt,
    required this.maxAttempts,
    required this.onCancel,
  });

  final int attempt;
  final int maxAttempts;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: 20),
            Text(
              context.l10n.aiQuizGenerating,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: onCancel,
              child: Text(
                context.l10n.aiQuizBackToCourse,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================
// Phase: taking the quiz
// ==============================================================



class _TakeQuizView extends StatelessWidget {
  const _TakeQuizView({
    required this.quiz,
    required this.answers,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.onSelect,
    required this.onSubmit,
  });

  final AIQuizDto quiz;
  final Map<int, int> answers;
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final void Function(int questionId, int optionIndex) onSelect;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final questions = quiz.questions;

    if (questions.isEmpty) {
      return Center(
        child: Text(
          context.l10n.aiQuizNoQuizzes,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    final index = currentIndex.clamp(0, questions.length - 1);
    final question = questions[index];
    final selected = answers[question.id];
    final isLast = index == questions.length - 1;
    final answeredCount = questions
        .where((q) => answers.containsKey(q.id))
        .length;
    final unansweredCount = questions.length - answeredCount;
    final progress = answeredCount / questions.length;

    return Column(
      children: [
        // Header and answered progress
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      context.l10n.aiQuizTitle,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '${index + 1}/${questions.length}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor:
                  Colors.white.withValues(alpha: 0.25),
                  valueColor:
                  const AlwaysStoppedAnimation<Color>(
                    Color(0xFFB8F0D5),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Text(
                '$answeredCount of ${questions.length} answered',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        // Question navigator
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questions',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(questions.length, (i) {
                  final isCurrent = i == index;
                  final isAnswered =
                  answers.containsKey(questions[i].id);

                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => onIndexChanged(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? AppColors.primary
                            : isAnswered
                            ? const Color(0xFFEAF7F1)
                            : const Color(0xFFF4F6F5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.primary
                              : isAnswered
                              ? AppColors.primary
                              .withValues(alpha: 0.35)
                              : AppColors.border
                              .withValues(alpha: 0.6),
                        ),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isCurrent
                              ? Colors.white
                              : isAnswered
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Current',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEAF7F1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Answered',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F6F5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Unanswered',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Question and answer options
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.035),
                    blurRadius: 16,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      context.l10n.aiQuizQuestionOf(
                        index + 1,
                        questions.length,
                      ),
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    question.prompt,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(question.options.length, (i) {
                    final isSelected = selected == i;
                    final letter = String.fromCharCode(65 + i);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => onSelect(question.id, i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEAF7F1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.border
                                    .withValues(alpha: 0.65),
                                width: isSelected ? 1.6 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : const Color(0xFFF4F7F6),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                    Icons.check,
                                    size: 18,
                                    color: Colors.white,
                                  )
                                      : Text(
                                    letter,
                                    style: GoogleFonts.inter(
                                      color:
                                      AppColors.textSecondary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    question.options[i],
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      height: 1.4,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),

        // Bottom navigation
        SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.45),
                ),
              ),
            ),
            child: Row(
              children: [
                if (index > 0)
                  OutlinedButton(
                    onPressed: () => onIndexChanged(index - 1),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(context.l10n.aiQuizPrevious),
                  )
                else
                  const SizedBox(width: 4),

                const Spacer(),

                if (!isLast)
                  TextButton(
                    onPressed: () => onIndexChanged(index + 1),
                    child: Text(
                      selected == null ? 'Skip' : 'Next',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else
                  TextButton(
                    onPressed: unansweredCount > 0
                        ? () {
                      final firstUnanswered =
                      questions.indexWhere(
                            (q) => !answers.containsKey(q.id),
                      );
                      if (firstUnanswered >= 0) {
                        onIndexChanged(firstUnanswered);
                      }
                    }
                        : null,
                    child: Text(
                      'Review unanswered ($unansweredCount)',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                const SizedBox(width: 4),

                if (!isLast)
                  ElevatedButton.icon(
                    onPressed: () => onIndexChanged(index + 1),
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 16,
                    ),
                    label: Text(context.l10n.aiQuizNext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: onSubmit,
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 16,
                    ),
                    label: Text(context.l10n.aiQuizSubmit),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.question,
    required this.questionNumber,
    required this.total,
    required this.selectedIndex,
    required this.onSelect,
  });

  final AIQuizQuestionDto question;
  final int questionNumber;
  final int total;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: .4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aiQuizQuestionOf(questionNumber, total),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            question.prompt,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.4,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(question.options.length, (index) {
            final isSelected = selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => onSelect(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: .07)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.border.withValues(alpha: .5),
                      width: isSelected ? 1.6 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        size: 20,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question.options[index],
                          style: GoogleFonts.inter(
                            fontSize: 13.5,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ==============================================================
// Phase: scored result + review
// ==============================================================

class _ResultView extends StatelessWidget {
  const _ResultView({
    required this.result,
    required this.quiz,
    required this.onBack,
  });

  final AIQuizResultDto result;
  final AIQuizDto quiz;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final questions = quiz.questions;
    final results = {for (final r in result.results) r.questionId: r};

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            children: [
              _ScoreHeader(result: result, total: questions.length),
              const SizedBox(height: 18),
              ...questions.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ReviewCard(
                    question: entry.value,
                    number: entry.key + 1,
                    result: results[entry.value.id],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                context.l10n.aiQuizBackToCourse,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScoreHeader extends StatelessWidget {
  const _ScoreHeader({required this.result, required this.total});

  final AIQuizResultDto result;
  final int total;

  @override
  Widget build(BuildContext context) {
    final correct = result.correctCount ?? 0;
    final total = result.totalCount ?? this.total;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aiQuizYourScore,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: .8),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$correct / $total',
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.question,
    required this.number,
    required this.result,
  });

  final AIQuizQuestionDto question;
  final int number;
  final AIQuizAnswerResultDto? result;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final answer = result;
    final correctIndex = answer?.correctAnswer;
    final selectedIndex = answer?.selectedAnswer;
    final correctText =
        (correctIndex != null &&
            correctIndex >= 0 &&
            correctIndex < question.options.length)
        ? question.options[correctIndex]
        : '—';
    final selectedText =
        (selectedIndex != null &&
            selectedIndex >= 0 &&
            selectedIndex < question.options.length)
        ? question.options[selectedIndex]
        : null;
    final isCorrect = answer?.isCorrect ?? false;
    final explanation = answer?.explanation;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCorrect
              ? AppColors.primary.withValues(alpha: .35)
              : Colors.red.withValues(alpha: .25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                size: 18,
                color: isCorrect ? AppColors.primary : Colors.red,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$number. ${question.prompt}',
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isCorrect) ...[
            Text(
              l10n.aiQuizYourAnswer,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              selectedText ?? '—',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            l10n.aiQuizCorrectAnswer,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            correctText,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          if (explanation != null && explanation.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              l10n.aiQuizExplanation,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              explanation,
              style: GoogleFonts.inter(
                fontSize: 12.5,
                height: 1.45,
                color: AppColors.textBody,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ==============================================================
// Phase: failure
// ==============================================================

class _FailureView extends StatelessWidget {
  const _FailureView({
    required this.message,
    required this.onRetry,
    required this.onBackToList,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBackToList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(context.l10n.commonRetry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onBackToList,
              child: Text(
                context.l10n.aiQuizBackToCourse,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
