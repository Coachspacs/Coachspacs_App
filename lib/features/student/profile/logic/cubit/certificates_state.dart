part of 'certificates_cubit.dart';

sealed class CertificatesState {
  const CertificatesState();
}

final class CertificatesInitial extends CertificatesState {
  const CertificatesInitial();
}

final class CertificatesLoading extends CertificatesState {
  const CertificatesLoading();
}

final class CertificatesSuccess extends CertificatesState {
  const CertificatesSuccess(this.certificates);

  final List<CertificateDto> certificates;
}

final class CertificatesEmpty extends CertificatesState {
  const CertificatesEmpty();
}

final class CertificatesFailure extends CertificatesState {
  const CertificatesFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}
