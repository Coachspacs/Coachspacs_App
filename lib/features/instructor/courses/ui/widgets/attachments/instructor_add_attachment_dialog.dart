import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:coach_space/features/instructor/courses/logic/cubit/attachments_cubit.dart';

/// Dialog that adds a course/lesson material (US-21): the user either picks an
/// image from the gallery (uploaded to Cloudinary through the signature
/// endpoint) or pastes a public URL, which is registered without an upload.
class InstructorAddAttachmentDialog extends StatefulWidget {
  const InstructorAddAttachmentDialog({
    super.key,
    required this.cubit,
    this.lessonId,
  });

  final AttachmentsCubit cubit;
  final int? lessonId;

  static Future<void> show(
    BuildContext context, {
    required AttachmentsCubit cubit,
    int? lessonId,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => InstructorAddAttachmentDialog(
        cubit: cubit,
        lessonId: lessonId,
      ),
    );
  }

  @override
  State<InstructorAddAttachmentDialog> createState() =>
      _InstructorAddAttachmentDialogState();
}

class _InstructorAddAttachmentDialogState
    extends State<InstructorAddAttachmentDialog> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  File? _pickedFile;
  String? _pickedFileName;
  String? _urlError;
  bool _isPicking = false;

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_isPicking) return;

    setState(() {
      _isPicking = true;
    });

    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (!mounted) return;
      setState(() {
        _isPicking = false;
        if (picked != null) {
          _pickedFile = File(picked.path);
          _pickedFileName = picked.name;
          _urlError = null;
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isPicking = false;
      });
    }
  }

  void _clearPickedFile() {
    setState(() {
      _pickedFile = null;
      _pickedFileName = null;
    });
  }

  String? _validateUrl(String raw) {
    final uri = Uri.tryParse(raw.trim());
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        (uri.host.isEmpty && uri.path.isEmpty)) {
      return 'Please enter a valid file URL (https://…).';
    }
    return null;
  }

  void _submit() {
    if (_pickedFile != null) {
      Navigator.pop(context);
      widget.cubit.createFromFile(
        file: _pickedFile!,
        fileName: _pickedFileName ?? 'attachment',
        title: _titleController.text,
        lessonId: widget.lessonId,
      );
      return;
    }

    final url = _urlController.text;
    final error = _validateUrl(url);
    if (error != null) {
      setState(() {
        _urlError = error;
      });
      return;
    }

    Navigator.pop(context);
    widget.cubit.createFromUrl(
      url: url,
      title: _titleController.text,
      lessonId: widget.lessonId,
    );
  }

  InputDecoration get _fieldDecoration => InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF7FAF9),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE0EAE7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF075E4D)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFB3261E)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFB3261E)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE0EAE7)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: Text(
        'Add Material',
        style: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF073F38),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name the material and attach it as an image upload or a file URL.',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF687772),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          TextField(
            controller: _titleController,
            style: GoogleFonts.inter(fontSize: 12),
            decoration: _fieldDecoration.copyWith(
              hintText: 'Material name (e.g. Lecture slides)',
              hintStyle: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF84928E),
              ),
            ),
          ),

          const SizedBox(height: 10),

          if (_pickedFile != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE4F1ED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.image_outlined,
                    size: 16,
                    color: Color(0xFF075E4D),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _pickedFileName ?? 'Selected image',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF073F38),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _clearPickedFile,
                    child: const Icon(
                      Icons.close_rounded,
                      size: 15,
                      color: Color(0xFFB3261E),
                    ),
                  ),
                ],
              ),
            )
          else
            TextField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              style: GoogleFonts.inter(fontSize: 12),
              decoration: _fieldDecoration.copyWith(
                hintText: 'File URL (https://…)',
                hintStyle: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF84928E),
                ),
                errorText: _urlError,
                errorStyle: GoogleFonts.inter(
                  fontSize: 9,
                  color: const Color(0xFFB3261E),
                ),
              ),
            ),

          const SizedBox(height: 10),

          OutlinedButton.icon(
            onPressed: _isPicking ? null : _pickImage,
            icon: _isPicking
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.image_outlined, size: 16),
            label: Text(
              _pickedFile == null ? 'Choose image' : 'Replace image',
              style: GoogleFonts.inter(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF075E4D),
              side: const BorderSide(color: Color(0xFFC8DAD5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 40),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),
        TextButton(
          onPressed: _submit,
          child: Text(
            'Add',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),
      ],
    );
  }
}
