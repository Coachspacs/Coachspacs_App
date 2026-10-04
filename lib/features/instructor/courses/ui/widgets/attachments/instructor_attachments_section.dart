import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/widgets/confirm_dialog.dart';
import 'package:coach_space/features/instructor/courses/data/models/attachment_dto.dart';
import 'package:coach_space/features/instructor/courses/logic/cubit/attachments_cubit.dart';

import 'instructor_add_attachment_dialog.dart';
import 'instructor_attachment_list_tile.dart';

/// "Course Materials" card (US-21): lists the course attachments with
/// add/delete, bound to [AttachmentsCubit] provided by the hosting screen.
class InstructorAttachmentsSection extends StatelessWidget {
  const InstructorAttachmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.folder_open_outlined,
                  size: 19,
                  color: Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Materials',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF073F38),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Files students can download from this course.',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: const Color(0xFF84928E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          BlocConsumer<AttachmentsCubit, AttachmentsState>(
            listener: _handleStateChanges,
            builder: _buildBody,
          ),
        ],
      ),
    );
  }

  void _handleStateChanges(BuildContext context, AttachmentsState state) {
    if (state is AttachmentsSuccess && state.lastFailure != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizedFailureMessage(
              context,
              state.lastFailure!.kind,
              state.lastFailure!.message,
            ),
          ),
          backgroundColor: const Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, AttachmentsState state) {
    final cubit = context.read<AttachmentsCubit>();

    if (state is AttachmentsFailure) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 10.5,
                color: const Color(0xFFB3261E),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: cubit.refresh,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: Text(
                'Retry',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF075E4D),
              ),
            ),
          ],
        ),
      );
    }

    if (state is! AttachmentsSuccess) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: Color(0xFF075E4D),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        if (state.uploadProgress != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const Expanded(
                  child: LinearProgressIndicator(
                    value: null,
                    minHeight: 4,
                    color: Color(0xFF075E4D),
                    backgroundColor: Color(0xFFE3ECE9),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Uploading…',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF075E4D),
                  ),
                ),
              ],
            ),
          ),
        ],

        if (state.attachments.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              'No materials yet. Add the first file for this course.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: const Color(0xFF899792),
              ),
            ),
          )
        else
          ...state.attachments.map(
            (attachment) => Container(
              margin: const EdgeInsets.only(bottom: 9),
              child: InstructorAttachmentListTile(
                attachment: attachment,
                onDelete: () => _deleteAttachment(context, cubit, attachment),
              ),
            ),
          ),

        const SizedBox(height: 4),

        SizedBox(
          width: double.infinity,
          height: 40,
          child: OutlinedButton.icon(
            onPressed: state.isBusy ? null : () => _addAttachment(context, cubit),
            icon: const Icon(
              Icons.add_rounded,
              size: 16,
            ),
            label: Text(
              'Add Material',
              style: GoogleFonts.inter(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF075E4D),
              disabledForegroundColor: const Color(0xFF9AAEA8),
              side: const BorderSide(
                color: Color(0xFFC8DAD5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addAttachment(BuildContext context, AttachmentsCubit cubit) {
    InstructorAddAttachmentDialog.show(context, cubit: cubit);
  }

  Future<void> _deleteAttachment(
    BuildContext context,
    AttachmentsCubit cubit,
    AttachmentDto attachment,
  ) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Delete attachment?',
      message: '"${attachment.fileName.isNotEmpty ? attachment.fileName : 'this material'}" '
          'will be removed from this course permanently.',
      confirmLabel: 'Delete',
      destructive: true,
    );

    if (confirmed) {
      cubit.delete(attachment.id);
    }
  }
}
