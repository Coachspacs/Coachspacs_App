import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/certificates/certificate_card.dart';
import 'package:coach_space/features/profile/ui/widgets/certificates/certificate_pdf.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  Future<void> _downloadCertificate() async {
    await downloadCertificatePdf(
      studentName: 'Mohammed Katanani',
      courseTitle:
      'Next.js 15 & React 19 Masterclass: Build Modern Fullstack Web Apps',
      certificateId: 'CS-2026-8849-NEXT',
      issueDate: 'July 29, 2026',
      instructorName: 'Dr. Tariq Al-Mansoor',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Earned Certificates',
                    style: TextStyle(
                      color: AppColors.textBody,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile =
                          constraints.maxWidth < 650;

                      if (isMobile) {
                        return CertificateCard(
                          courseTitle:
                          'Building Professional UI/UX Design Systems with Figma',
                          certificateId: 'CERT-892401',
                          onDownload:
                          _downloadCertificate,
                        );
                      }

                      return Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 430,
                          child: CertificateCard(
                            courseTitle:
                            'Building Professional UI/UX Design Systems with Figma',
                            certificateId:
                            'CERT-892401',
                            onDownload:
                            _downloadCertificate,
                          ),
                        ),
                      );
                    },
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