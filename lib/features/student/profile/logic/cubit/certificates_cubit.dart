import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository.dart';

part 'certificates_state.dart';

class CertificatesCubit extends Cubit<CertificatesState> {
  CertificatesCubit(this._repository) : super(const CertificatesInitial());

  static const int _pageSize = 20;

  final CertificateRepository _repository;

  int? _downloadedId;
  List<int>? _downloadedBytes;

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

  /// Fetches the PDF bytes for [id], caching the last downloaded certificate.
  /// Returns `true` when the bytes are available.
  Future<bool> download(int id) async {
    if (_downloadedId == id && _downloadedBytes != null) return true;
    try {
      final bytes = await _repository.downloadCertificate(id);
      if (bytes.isEmpty) return false;
      _downloadedId = id;
      _downloadedBytes = bytes;
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Cached bytes for [id] after a successful [download].
  List<int>? bytesFor(int id) => _downloadedId == id ? _downloadedBytes : null;
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
