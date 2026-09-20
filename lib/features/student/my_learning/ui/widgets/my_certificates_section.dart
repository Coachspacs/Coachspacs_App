import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';

class MyCertificatesSection extends StatelessWidget {
  const MyCertificatesSection({
    super.key,
    required this.certificates,
  });

  final List<CertificateDto> certificates;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.myLearningCertificates,
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.certificates);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                l10n.myLearningViewAll,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (certificates.isEmpty)
          _EmptyCard(message: l10n.myLearningNoCertificates)
        else
          ...certificates.take(2).map(
            (certificate) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _CertificateTile(certificate: certificate),
            ),
          ),
      ],
    );
  }
}

class _CertificateTile extends StatelessWidget {
  const _CertificateTile({required this.certificate});

  final CertificateDto certificate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.certificates),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF9F5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFD2EDE3)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFD8F2E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.workspace_premium_outlined,
                color: Color(0xFF08715E),
                size: 23,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    certificate.course.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF173E37),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    certificate.certificateNumber,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: const Color(0xFF8A9A96),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 21,
              color: Color(0xFF91A09C),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFDDEBE6)),
      ),
      child: Text(
        message,
        style: GoogleFonts.inter(
          fontSize: 11,
          color: const Color(0xFF7D8D89),
        ),
      ),
    );
  }
}
