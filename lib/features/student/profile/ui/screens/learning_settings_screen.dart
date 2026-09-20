import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';
import 'package:coach_space/l10n/app_localizations.dart';

import '../../logic/cubit/learning_settings_cubit.dart';

const List<String> _playbackSpeeds = [
  '0.5',
  '0.75',
  '1.0',
  '1.25',
  '1.5',
  '2.0',
];

class LearningSettingsScreen extends StatelessWidget {
  const LearningSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LearningSettingsCubit>()..load(),
      child: const _LearningSettingsView(),
    );
  }
}

class _LearningSettingsView extends StatefulWidget {
  const _LearningSettingsView();

  @override
  State<_LearningSettingsView> createState() => _LearningSettingsViewState();
}

class _LearningSettingsViewState extends State<_LearningSettingsView> {
  PreferencesDto? _prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<LearningSettingsCubit, LearningSettingsState>(
                builder: (context, state) {
                  final loaded = switch (state) {
                    LearningSettingsSuccess(:final prefs) => prefs,
                    LearningSettingsSaving(:final prefs) => prefs,
                    LearningSettingsSaved(:final prefs) => prefs,
                    _ => null,
                  };
                  if (loaded != null) _prefs = loaded;

                  final prefs = _prefs;
                  if (prefs == null) {
                    if (state is LearningSettingsFailure) {
                      return _LearningSettingsFailure(
                        state: state,
                        onRetry: () =>
                            context.read<LearningSettingsCubit>().load(),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF075E4D),
                      ),
                    );
                  }

                  return _LearningSettingsForm(initial: prefs);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 25,
              color: Color(0xFF073F38),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.learningSettingsTitle,
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

class _LearningSettingsFailure extends StatelessWidget {
  const _LearningSettingsFailure({
    required this.state,
    required this.onRetry,
  });

  final LearningSettingsFailure state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final detail = state.kind == FailureKind.offline ? l10n.errorOffline : null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 46,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 14),
            Text(
              l10n.learningSettingsLoadFailed,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),
            if (detail != null) ...[
              const SizedBox(height: 6),
              Text(
                detail,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  color: const Color(0xFF71827E),
                ),
              ),
            ],
            const SizedBox(height: 18),
            SizedBox(
              height: 42,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 17),
                label: Text(
                  l10n.commonRetry,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LearningSettingsForm extends StatefulWidget {
  const _LearningSettingsForm({required this.initial});

  final PreferencesDto initial;

  @override
  State<_LearningSettingsForm> createState() => _LearningSettingsFormState();
}

class _LearningSettingsFormState extends State<_LearningSettingsForm> {
  late final TextEditingController _goalController;
  late final TextEditingController _fieldController;
  late final TextEditingController _certificateNameController;
  late String _playbackSpeed;
  late bool _publicProfile;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _goalController = TextEditingController(text: initial.learningGoal);
    _fieldController = TextEditingController(text: initial.fieldOfInterest);
    _certificateNameController =
        TextEditingController(text: initial.certificateName);
    _playbackSpeed = _normalizePlaybackSpeed(initial.playbackSpeed);
    _publicProfile = initial.publicProfile;
  }

  @override
  void dispose() {
    _goalController.dispose();
    _fieldController.dispose();
    _certificateNameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final cubit = context.read<LearningSettingsCubit>();
    setState(() => _saving = true);

    final saved = await cubit.save(
      learningGoal: _goalController.text.trim(),
      fieldOfInterest: _fieldController.text.trim(),
      certificateName: _certificateNameController.text.trim(),
      playbackSpeed: _playbackSpeed,
      publicProfile: _publicProfile,
    );

    if (!mounted) return;
    setState(() => _saving = false);

    final l10n = context.l10n;
    final state = cubit.state;
    final message = saved
        ? l10n.learningSettingsSaved
        : _saveFailureMessage(l10n, state);

    _showSnackBar(context, message, success: saved);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDCE7E4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FieldLabel(title: l10n.learningSettingsGoal),
                const SizedBox(height: 8),
                _SettingsTextField(
                  controller: _goalController,
                  hint: l10n.learningSettingsGoalHint,
                ),
                const SizedBox(height: 18),
                _FieldLabel(title: l10n.learningSettingsField),
                const SizedBox(height: 8),
                _SettingsTextField(
                  controller: _fieldController,
                  hint: l10n.learningSettingsFieldHint,
                ),
                const SizedBox(height: 18),
                _FieldLabel(title: l10n.learningSettingsCertName),
                const SizedBox(height: 8),
                _SettingsTextField(
                  controller: _certificateNameController,
                  hint: l10n.learningSettingsCertHint,
                ),
                const SizedBox(height: 18),
                _FieldLabel(title: l10n.learningSettingsPlaybackSpeed),
                const SizedBox(height: 8),
                _SettingsDropdown(
                  value: _playbackSpeed,
                  items: {
                    for (final speed in _playbackSpeeds)
                      speed: _playbackSpeedLabel(speed),
                  },
                  onChanged: (value) {
                    setState(() => _playbackSpeed = value);
                  },
                ),
                const SizedBox(height: 18),
                _ToggleTile(
                  title: l10n.learningSettingsPublicProfile,
                  subtitle: l10n.learningSettingsPublicHint,
                  value: _publicProfile,
                  onChanged: (value) {
                    setState(() => _publicProfile = value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 42),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primary,
                disabledForegroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      l10n.commonSave,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

String _normalizePlaybackSpeed(String raw) {
  final cleaned = raw
      .replaceAll('x', '')
      .replaceAll('Normal', '')
      .trim();
  return _playbackSpeeds.contains(cleaned) ? cleaned : '1.0';
}

String _playbackSpeedLabel(String value) => '${value}x';

String _saveFailureMessage(
  AppLocalizations l10n,
  LearningSettingsState state,
) {
  if (state is! LearningSettingsFailure) {
    return l10n.learningSettingsSaveFailed;
  }
  return switch (state.kind) {
    FailureKind.offline => l10n.errorOffline,
    FailureKind.unknown => l10n.learningSettingsSaveFailed,
    _ => state.message.isNotEmpty
        ? state.message
        : l10n.learningSettingsSaveFailed,
  };
}

void _showSnackBar(
  BuildContext context,
  String message, {
  required bool success,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter(fontSize: 11)),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            success ? const Color(0xFF075E4D) : const Color(0xFFD9363E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: const Color(0xFF073F38),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _SettingsTextField extends StatelessWidget {
  const _SettingsTextField({
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextField(
        controller: controller,
        style: GoogleFonts.inter(
          color: const Color(0xFF344842),
          fontSize: 13,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF99A7A5),
            fontSize: 13,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Color(0xFFD5E1DE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Color(0xFFD5E1DE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsDropdown extends StatelessWidget {
  const _SettingsDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        style: GoogleFonts.inter(
          color: const Color(0xFF344842),
          fontSize: 13,
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: Color(0xFF344842),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Color(0xFFD5E1DE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Color(0xFFD5E1DE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.2,
            ),
          ),
        ),
        items: items.entries
            .map(
              (entry) => DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF344842),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 13, 10, 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE7E4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF71807C),
                    fontSize: 9.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF8BB8AD),
            activeThumbColor: const Color(0xFF075E4D),
          ),
        ],
      ),
    );
  }
}
