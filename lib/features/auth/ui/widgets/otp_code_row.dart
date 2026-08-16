import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class OtpCodeRow extends StatefulWidget {
  const OtpCodeRow({super.key, this.length = 6, this.controller});

  final int length;
  final OtpCodeRowController? controller;

  @override
  State<OtpCodeRow> createState() => _OtpCodeRowState();
}

class OtpCodeRowController extends ChangeNotifier {
  String _code = '';

  String get code => _code;

  set code(String value) {
    _code = value;
    notifyListeners();
  }
}

class _OtpCodeRowState extends State<OtpCodeRow> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _focusNodes.isNotEmpty) {
        _focusNodes.first.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _updateCode() {
    final code = _controllers.map((c) => c.text).join();
    widget.controller?.code = code;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.length, (index) {
          return SizedBox(
            width: 48,
            height: 56,
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              decoration: InputDecoration(
                counterText: '',
                hintText: '-',
                hintStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.borderColor,
                ),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.9),
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.length > 1) {
                  _controllers[index].text = value.substring(0, 1);
                  _controllers[index].selection = TextSelection.fromPosition(
                    const TextPosition(offset: 1),
                  );
                }
                if (value.isNotEmpty && index < widget.length - 1) {
                  _focusNodes[index + 1].requestFocus();
                }
                if (value.isEmpty && index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
                _updateCode();
              },
              onSubmitted: (_) {
                if (index < widget.length - 1) {
                  _focusNodes[index + 1].requestFocus();
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
