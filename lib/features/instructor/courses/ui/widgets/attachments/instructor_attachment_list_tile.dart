import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/instructor/courses/data/models/attachment_dto.dart';

/// One row of the "Course Materials" list (US-21): type icon, file name,
/// human-readable size and a delete action.
class InstructorAttachmentListTile extends StatelessWidget {
  const InstructorAttachmentListTile({
    super.key,
    required this.attachment,
    required this.onDelete,
  });

  final AttachmentDto attachment;
  final VoidCallback onDelete;

  static const _typeColor = Color(0xFF075E4D);
  static const _typeBackground = Color(0xFFE4F1ED);

  /// Picks an icon from the mime type / file extension.
  static IconData iconFor(AttachmentDto attachment) {
    final type = attachment.fileType.toLowerCase();
    final name = attachment.fileName.toLowerCase();

    if (type.contains('pdf') || name.endsWith('.pdf')) {
      return Icons.picture_as_pdf_outlined;
    }
    if (type.startsWith('image') ||
        ['.png', '.jpg', '.jpeg', '.gif', '.webp'].any(name.endsWith)) {
      return Icons.image_outlined;
    }
    if (type.startsWith('video') ||
        ['.mp4', '.mov', '.avi', '.mkv', '.webm'].any(name.endsWith)) {
      return Icons.smart_display_outlined;
    }
    if (type.startsWith('audio') ||
        ['.mp3', '.wav', '.m4a', '.aac'].any(name.endsWith)) {
      return Icons.headphones_outlined;
    }
    if (type.contains('zip') || ['.zip', '.rar', '.7z'].any(name.endsWith)) {
      return Icons.folder_zip_outlined;
    }
    if (['.doc', '.docx', '.txt'].any(name.endsWith)) {
      return Icons.description_outlined;
    }
    return Icons.insert_drive_file_outlined;
  }

  /// Human-readable file size for the subtitle line.
  static String formatSize(int bytes) {
    if (bytes <= 0) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final size = formatSize(attachment.fileSize);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF9),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFE3ECE9),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 29,
            height: 29,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _typeBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              iconFor(attachment),
              size: 16,
              color: _typeColor,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.fileName.isNotEmpty
                      ? attachment.fileName
                      : 'Untitled attachment',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),
                if (size.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    size,
                    style: GoogleFonts.inter(
                      fontSize: 8.5,
                      color: const Color(0xFF899792),
                    ),
                  ),
                ],
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 18,
              color: Color(0xFFB3261E),
            ),
          ),
        ],
      ),
    );
  }
}
