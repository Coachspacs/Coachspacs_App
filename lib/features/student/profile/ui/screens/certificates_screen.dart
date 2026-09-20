import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/logic/cubit/certificates_cubit.dart';

import '../widgets/certificates/certificate_card.dart';
import '../widgets/certificates/certificate_pdf.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CertificatesCubit>()..load(),
      child: const _CertificatesView(),
    );
  }
}

class _CertificatesView extends StatefulWidget {
  const _CertificatesView();

  @override
  State<_CertificatesView> createState() => _CertificatesViewState();
}

class _CertificatesViewState extends State<_CertificatesView> {
  int? _busyCertificateId;

  // ================================================================
  // DOWNLOAD / SHARE
  // ================================================================

  Future<void> _download(
    CertificateDto certificate, {
    required bool showDownloadedMessage,
  }) async {
    if (_busyCertificateId != null) return;

    final cubit = context.read<CertificatesCubit>();
    setState(() => _busyCertificateId = certificate.id);

    try {
      final downloaded = await cubit.download(certificate.id);
      if (!mounted) return;

      final bytes = cubit.bytesFor(certificate.id);
      if (!downloaded || bytes == null || bytes.isEmpty) {
        _showMessage(context.l10n.certificatesDownloadFailed);
        return;
      }

      await shareCertificatePdf(
        bytes: bytes,
        certificateNumber: certificate.certificateNumber,
      );
      if (!mounted) return;

      if (showDownloadedMessage) {
        _showMessage(context.l10n.certificatesDownloaded);
      }
    } catch (_) {
      if (mounted) {
        _showMessage(context.l10n.certificatesDownloadFailed);
      }
    } finally {
      if (mounted) {
        setState(() => _busyCertificateId = null);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            // ==================================================
            // HEADER
            // ==================================================
            const _CertificatesHeader(),

            // ==================================================
            // CONTENT
            // ==================================================
            Expanded(
              child: BlocBuilder<CertificatesCubit, CertificatesState>(
                builder: (context, state) {
                  if (state is CertificatesInitial ||
                      state is CertificatesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is CertificatesFailure) {
                    return _buildFailure(context, state);
                  }

                  if (state is CertificatesEmpty) {
                    return _buildEmpty(context);
                  }

                  final certificates = state is CertificatesSuccess
                      ? state.certificates
                      : const <CertificateDto>[];

                  if (certificates.isEmpty) {
                    return _buildEmpty(context);
                  }

                  return _buildCertificates(context, certificates);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // LIST
  // ================================================================

  Widget _buildCertificates(
    BuildContext context,
    List<CertificateDto> certificates,
  ) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CertificatesCubit>().load(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
        itemCount: certificates.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final certificate = certificates[index];

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: CertificateCard(
                certificate: certificate,
                isBusy: _busyCertificateId == certificate.id,
                onDownload: () =>
                    _download(certificate, showDownloadedMessage: true),
                onShare: () =>
                    _download(certificate, showDownloadedMessage: false),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================================================================
  // EMPTY
  // ================================================================

  Widget _buildEmpty(BuildContext context) {
    final l10n = context.l10n;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CertificatesCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4F5EF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.workspace_premium_outlined,
                    size: 28,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  l10n.certificatesEmpty,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  l10n.certificatesEmptyHint,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textLight,
                    fontSize: 10.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // FAILURE
  // ================================================================

  Widget _buildFailure(BuildContext context, CertificatesFailure state) {
    final l10n = context.l10n;
    final detail = _failureDetail(context, state.kind);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CertificatesCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 46,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 14),

          Text(
            l10n.certificatesLoadFailed,
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

          Center(
            child: SizedBox(
              height: 42,
              child: ElevatedButton.icon(
                onPressed: () => context.read<CertificatesCubit>().load(),
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
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// HEADER
// ===================================================================

class _CertificatesHeader extends StatelessWidget {
  const _CertificatesHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 23,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(width: 4),

          Text(
            context.l10n.certificatesTitle,
            style: GoogleFonts.inter(
              color: const Color(0xFF073F38),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// HELPERS
// ===================================================================

String? _failureDetail(BuildContext context, FailureKind kind) {
  final l10n = context.l10n;
  return switch (kind) {
    FailureKind.offline => l10n.errorOffline,
    FailureKind.unauthorized => l10n.errorSessionExpired,
    FailureKind.forbidden => l10n.errorForbidden,
    FailureKind.notFound => l10n.errorNotFound,
    FailureKind.conflict => l10n.errorConflict,
    FailureKind.rateLimited => l10n.errorRateLimited,
    FailureKind.serverError => l10n.errorServer,
    _ => null,
  };
}
