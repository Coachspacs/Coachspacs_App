import 'dart:typed_data';

import 'package:printing/printing.dart';

/// Shares certificate [bytes] downloaded from the API through the platform
/// share sheet, using the certificate number as the file name.
Future<void> shareCertificatePdf({
  required List<int> bytes,
  required String certificateNumber,
}) {
  return Printing.sharePdf(
    bytes: Uint8List.fromList(bytes),
    filename: 'certificate-$certificateNumber.pdf',
  );
}
