import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository.dart';
import 'package:coach_space/features/student/profile/ui/widgets/certificates/certificate_pdf.dart';

part 'certificates_state.dart';

class CertificatesCubit extends Cubit<CertificatesState> {
  CertificatesCubit(this._repository) : super(const CertificatesInitial());

  static const int _pageSize = 20;

  final CertificateRepository _repository;

  int? _builtId;
  List<int>? _builtBytes;

  Future<void> load() async {
    emit(const CertificatesLoading());
    try {
      final page = await _repository.getCertificates(
        page: 1,
        pageSize: _pageSize,
      );
      if (isClosed) return;
      final certificates = page.results;
      if (certificates.isEmpty) {
        emit(const CertificatesEmpty());
      } else {
        emit(CertificatesSuccess(certificates));
      }
    } on NetworkException catch (error) {
      if (isClosed) return;
      emit(CertificatesFailure(error.kind, error.message));
    } catch (_) {
      if (isClosed) return;
      emit(const CertificatesFailure(FailureKind.unknown, _fallbackMessage));
    }
  }

  /// Fetches the certificate detail for [id] and renders the PDF locally,
  /// caching the last built certificate. Returns `true` on success.
  Future<bool> download(int id) async {
    if (_builtId == id && _builtBytes != null) return true;
    try {
      final detail = await _repository.getCertificate(id);
      if (isClosed) return false;
      final bytes = await buildCertificatePdf(detail);
      _builtId = id;
      _builtBytes = bytes;
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Cached bytes for [id] after a successful [download].
  List<int>? bytesFor(int id) => _builtId == id ? _builtBytes : null;
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
