import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/certificates/certificate_card.dart';
import 'package:coach_space/features/profile/ui/widgets/certificates/certificate_pdf.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                10,
                16,
                0,
              ),
              child: Row(
                children: [
                  // Back arrow only
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 34,
                      minHeight: 34,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 23,
                      color: Color(0xFF073F38),
                    ),
                  ),

                  const SizedBox(width: 4),

                  Text(
                    'Earned Certificates',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF073F38),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  30,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 700,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View and download your certificates of completion.',
                          style: GoogleFonts.inter(
                            color: AppColors.textLight,
                            fontSize: 10.5,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =================================================
                        // CERTIFICATE
                        // =================================================

                        CertificateCard(
                          courseTitle:
                          'Building Professional UI/UX Design Systems with Figma',
                          certificateId: 'CERT-892401',

                          // DOWNLOAD PDF
                          onDownload: () {
                            downloadCertificatePdf(
                              studentName: 'Sondos Abu Skhail',
                              courseTitle:
                              'Building Professional UI/UX Design Systems with Figma',
                              certificateId: 'CERT-892401',
                              issueDate: 'May 12, 2024',
                              instructorName:
                              'Dr. Tareq Al-Mansoor',
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // =================================================
                        // VERIFIED MESSAGE
                        // =================================================

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF8F3),
                            borderRadius:
                            BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFD5EEE4),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.verified_user_outlined,
                                size: 19,
                                color: AppColors.primary,
                              ),

                              const SizedBox(width: 9),

                              Expanded(
                                child: Text(
                                  'Your certificates are verified and secure.',
                                  style: GoogleFonts.inter(
                                    color: AppColors.primary,
                                    fontSize: 9.5,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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