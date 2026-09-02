import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';

/// Support / Contact form screen (Figma: Support — 390×873).
///
/// Figma tokens:
/// - Scaffold #FFFFFF, card 350px #FFFFFF border rgba(191,201,196,0.3) + shadow
/// - Textarea #E7F6FF 8px radius, blur halo rgba(0,52,43,0.05) 20px
/// - Primary button #0F5244 30px radius with 10/15 shadow, label 20/600
/// - Secondary "Cancel" 20/600 #000000
/// - Intro 16/400 #3F4945 center, title 24/600 #071E27
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  bool _sending = false;

  static const Color _titleColor = Color(0xFF071E27);
  static const Color _bodyColor = Color(0xFF3F4945);
  static const Color _fieldBg = Color(0xFFE7F6FF);
  static const Color _cardBorder = Color(0x4DBFC9C4);
  static const Color _blurHalo = Color(0x0D00342B);

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final String message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.supportMessageEmpty)),
      );
      return;
    }
    if (message.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.supportMessageTooShort)),
      );
      return;
    }
    setState(() => _sending = true);
    // Mock send — replace with repository call when backend ships.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _sending = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.supportMessageSent)),
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // =================================================
                  // Top bar — centered title, no leading per Figma
                  // =================================================
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: _titleColor,
                          size: 22,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Support',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _titleColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // =================================================
                  // Intro text
                  // =================================================
                  Text(
                    context.l10n.supportIntro,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: _bodyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.62,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =================================================
                  // Contact Form Section — card
                  // =================================================
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: _cardBorder),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.supportSendMessageTitle,
                              style: const TextStyle(
                                color: _titleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Label
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                context.l10n.supportMessageLabel,
                                style: const TextStyle(
                                  color: _bodyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Textarea #E7F6FF
                            TextField(
                              controller: _messageController,
                              focusNode: _messageFocus,
                              minLines: 5,
                              maxLines: 6,
                              maxLength: 1000,
                              textAlignVertical: TextAlignVertical.top,
                              style: const TextStyle(
                                color: _titleColor,
                                fontSize: 16,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                hintText: context.l10n.supportMessageHint,
                                hintStyle: TextStyle(
                                  color: _bodyColor.withValues(alpha: 0.5),
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                                filled: true,
                                fillColor: _fieldBg,
                                counterText: '',
                                contentPadding: const EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Primary button #0F5244 / 30px / shadow
                            DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x33006B5C),
                                    blurRadius: 15,
                                    offset: Offset(0, 10),
                                  ),
                                  BoxShadow(
                                    color: Color(0x33006B5C),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: MyButton(
                                text: _sending
                                    ? context.l10n.supportSending
                                    : context.l10n.supportSendButton,
                                onPressed: _sending ? () {} : _sendMessage,
                                color: AppColors.primary,
                                textColor: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                borderRadius: 30,
                                width: double.infinity,
                                height: 56,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Decorative blur halo top-right (-63,-55 128px)
                      Positioned(
                        right: -32,
                        top: -24,
                        child: IgnorePointer(
                          child: Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              color: _blurHalo,
                              shape: BoxShape.circle,
                            ),
                            // CSS filter: blur(20px) — approximated via opacity
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // =================================================
                  // Cancel — centered 20/600 #000000
                  // =================================================
                  Center(
                    child: TextButton(
                      onPressed: _sending ? null : () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        context.l10n.supportCancel,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
