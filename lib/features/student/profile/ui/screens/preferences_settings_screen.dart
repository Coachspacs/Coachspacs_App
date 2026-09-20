import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';
import 'package:coach_space/l10n/app_localizations.dart';

import '../../logic/cubit/preferences_cubit.dart';

class PreferencesSettingsScreen extends StatelessWidget {
  const PreferencesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PreferencesCubit>()..load(),
      child: const _PreferencesSettingsView(),
    );
  }
}

class _PreferencesSettingsView extends StatefulWidget {
  const _PreferencesSettingsView();

  @override
  State<_PreferencesSettingsView> createState() =>
      _PreferencesSettingsViewState();
}

class _PreferencesSettingsViewState extends State<_PreferencesSettingsView> {
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
              child: BlocBuilder<PreferencesCubit, PreferencesState>(
                builder: (context, state) {
                  final loaded = switch (state) {
                    PreferencesSuccess(:final prefs) => prefs,
                    PreferencesSaving(:final prefs) => prefs,
                    PreferencesSaved(:final prefs) => prefs,
                    _ => null,
                  };
                  if (loaded != null) _prefs = loaded;

                  final prefs = _prefs;
                  if (prefs == null) {
                    if (state is PreferencesFailure) {
                      return _PreferencesFailure(
                        state: state,
                        onRetry: () => context.read<PreferencesCubit>().load(),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF075E4D),
                      ),
                    );
                  }

                  return _PreferencesForm(initial: prefs);
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
            context.l10n.preferencesTitle,
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

class _PreferencesFailure extends StatelessWidget {
  const _PreferencesFailure({
    required this.state,
    required this.onRetry,
  });

  final PreferencesFailure state;
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
              l10n.preferencesLoadFailed,
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

class _PreferencesForm extends StatefulWidget {
  const _PreferencesForm({required this.initial});

  final PreferencesDto initial;

  @override
  State<_PreferencesForm> createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<_PreferencesForm> {
  late bool _emailNotifications;
  late bool _pushNotifications;
  late String _language;
  late String _theme;
  bool _saving = false;

  static const List<String> _languages = ['en', 'ar'];
  static const List<String> _themes = ['light', 'dark', 'system'];

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _emailNotifications = initial.emailNotifications;
    _pushNotifications = initial.pushNotifications;
    _language = _languages.contains(initial.language) ? initial.language : 'en';
    _theme = _themes.contains(initial.theme) ? initial.theme : 'light';
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final cubit = context.read<PreferencesCubit>();
    setState(() => _saving = true);

    final saved = await cubit.save(
      emailNotifications: _emailNotifications,
      pushNotifications: _pushNotifications,
      language: _language,
      theme: _theme,
    );

    if (!mounted) return;
    setState(() => _saving = false);

    final l10n = context.l10n;
    final state = cubit.state;
    final message = saved
        ? l10n.preferencesSaved
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
              children: [
                _PreferenceTile(
                  icon: Icons.mail_outline_rounded,
                  title: l10n.preferencesEmailNotif,
                  subtitle: l10n.preferencesEmailNotifHint,
                  value: _emailNotifications,
                  onChanged: (value) {
                    setState(() => _emailNotifications = value);
                  },
                ),
                const SizedBox(height: 10),
                _PreferenceTile(
                  icon: Icons.notifications_none_rounded,
                  title: l10n.preferencesPushNotif,
                  subtitle: l10n.preferencesPushNotifHint,
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() => _pushNotifications = value);
                  },
                ),
                const SizedBox(height: 10),
                _SelectTile(
                  icon: Icons.language_rounded,
                  title: l10n.preferencesLanguage,
                  value: _language,
                  items: {
                    'en': l10n.preferencesEnglish,
                    'ar': l10n.preferencesArabic,
                  },
                  onChanged: (value) {
                    setState(() => _language = value);
                  },
                ),
                const SizedBox(height: 10),
                _SelectTile(
                  icon: Icons.dark_mode_outlined,
                  title: l10n.preferencesTheme,
                  value: _theme,
                  items: {
                    'light': l10n.preferencesThemeLight,
                    'dark': l10n.preferencesThemeDark,
                    'system': l10n.preferencesThemeSystem,
                  },
                  onChanged: (value) {
                    setState(() => _theme = value);
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

String _saveFailureMessage(AppLocalizations l10n, PreferencesState state) {
  if (state is! PreferencesFailure) {
    return l10n.preferencesSaveFailed;
  }
  return switch (state.kind) {
    FailureKind.offline => l10n.errorOffline,
    FailureKind.unknown => l10n.preferencesSaveFailed,
    _ => state.message.isNotEmpty
        ? state.message
        : l10n.preferencesSaveFailed,
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

class _PreferenceTile extends StatelessWidget {
  const _PreferenceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE7E4)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 19,
              color: const Color(0xFF075E4D),
            ),
          ),
          const SizedBox(width: 11),
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
                const SizedBox(height: 3),
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

class _SelectTile extends StatelessWidget {
  const _SelectTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE7E4)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 19,
              color: const Color(0xFF075E4D),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: const Color(0xFF073F38),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 19,
                color: Color(0xFF71807C),
              ),
              style: GoogleFonts.inter(
                color: const Color(0xFF073F38),
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
              items: items.entries
                  .map(
                    (entry) => DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
