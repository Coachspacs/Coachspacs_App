import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';

import '../../logic/cubit/contact_cubit.dart';

const int _minMessageLength = 10;

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ContactCubit>(),
      child: const _ContactUsView(),
    );
  }
}

class _ContactUsView extends StatefulWidget {
  const _ContactUsView();

  @override
  State<_ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<_ContactUsView> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _category = 'general';
  String? _messageError;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _send() {
    FocusScope.of(context).unfocus();
    final l10n = context.l10n;
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      setState(() => _messageError = l10n.contactUsEmpty);
      return;
    }

    if (message.length < _minMessageLength) {
      setState(() => _messageError = l10n.contactUsTooShort);
      return;
    }

    setState(() => _messageError = null);
    context.read<ContactCubit>().send(
      message: message,
      subject: _subjectController.text.trim(),
      category: _category,
    );
  }

  void _clearForm() {
    _subjectController.clear();
    _messageController.clear();
    setState(() {
      _category = 'general';
      _messageError = null;
    });
  }

  void _onMessageChanged(String _) {
    if (_messageError != null) {
      setState(() => _messageError = null);
    }
  }

  void _showSnackBar(String message, {required bool success}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: GoogleFonts.inter(fontSize: 12)),
          backgroundColor: success ? AppColors.primary : const Color(0xFFD9363E),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocConsumer<ContactCubit, ContactState>(
                listener: (context, state) {
                  if (state is ContactSent) {
                    _clearForm();
                    _showSnackBar(l10n.contactUsSent, success: true);
                  } else if (state is ContactFailure) {
                    final message = state.kind == FailureKind.offline
                        ? l10n.errorOffline
                        : l10n.contactUsSendFailed;
                    _showSnackBar(message, success: false);
                  }
                },
                builder: (context, state) {
                  final sending = state is ContactSending;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 30),
                    child: Column(
                      children: [
                        Text(
                          l10n.contactUsIntro,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4D5855),
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 54),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(
                            24,
                            30,
                            24,
                            34,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE2E8E6),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.contactUsSendMessage,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF172B27),
                                ),
                              ),
                              const SizedBox(height: 26),
                              _FieldLabel(title: l10n.contactUsSubject),
                              const SizedBox(height: 10),
                              _ContactTextField(
                                controller: _subjectController,
                                hint: l10n.contactUsSubjectHint,
                              ),
                              const SizedBox(height: 22),
                              _FieldLabel(title: l10n.contactUsCategory),
                              const SizedBox(height: 10),
                              _CategoryPicker(
                                selected: _category,
                                onChanged: (value) {
                                  setState(() => _category = value);
                                },
                              ),
                              const SizedBox(height: 22),
                              _FieldLabel(title: l10n.contactUsMessageLabel),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _messageController,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                onChanged: _onMessageChanged,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFF172B27),
                                ),
                                decoration: InputDecoration(
                                  hintText: l10n.contactUsMessageHint,
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFF99A7A5),
                                  ),
                                  errorText: _messageError,
                                  errorStyle: GoogleFonts.inter(fontSize: 11),
                                  filled: true,
                                  fillColor: const Color(0xFFE6F5FC),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 23),
                              SizedBox(
                                width: double.infinity,
                                height: 57,
                                child: ElevatedButton(
                                  onPressed: sending ? null : _send,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: AppColors.primary,
                                    disabledForegroundColor: Colors.white,
                                    elevation: 5,
                                    shadowColor: AppColors.primary.withValues(
                                      alpha: 0.30,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: sending
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              l10n.contactUsSendButton,
                                              style: GoogleFonts.inter(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            const Icon(
                                              Icons.send_outlined,
                                              size: 17,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: TextButton(
                                  onPressed: sending ? null : _clearForm,
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    foregroundColor: const Color(0xFF172B27),
                                  ),
                                  child: Text(
                                    l10n.commonCancel,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
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
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 24,
              color: Color(0xFF073F38),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            context.l10n.contactUsTitle,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF171616),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF4D5855),
      ),
    );
  }
}

class _ContactTextField extends StatelessWidget {
  const _ContactTextField({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(
        fontSize: 14,
        color: const Color(0xFF172B27),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF99A7A5),
        ),
        filled: true,
        fillColor: const Color(0xFFE6F5FC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _CategoryPicker extends StatelessWidget {
  const _CategoryPicker({
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categories = {
      'general': l10n.contactUsCategoryGeneral,
      'technical': l10n.contactUsCategoryTechnical,
      'billing': l10n.contactUsCategoryBilling,
      'other': l10n.contactUsCategoryOther,
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.entries.map((entry) {
        final isSelected = entry.key == selected;
        return ChoiceChip(
          label: Text(
            entry.value,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF344842),
            ),
          ),
          selected: isSelected,
          showCheckmark: false,
          onSelected: (_) => onChanged(entry.key),
          backgroundColor: const Color(0xFFE6F5FC),
          selectedColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          side: BorderSide(
            color: isSelected ? AppColors.primary : const Color(0xFFD5E1DE),
          ),
        );
      }).toList(),
    );
  }
}
