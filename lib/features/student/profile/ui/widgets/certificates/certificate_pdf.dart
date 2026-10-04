import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../data/models/certificate_detail_dto.dart';

/// Builds a certificate PDF locally from the certificate detail the API
/// returns — the backend never designs or stores a certificate itself.
Future<Uint8List> buildCertificatePdf(CertificateDetailDto detail) async {
  final issued = detail.issuedAt == null
      ? ''
      : detail.issuedAt!.split('T').first.split(' ').first;

  final doc = pw.Document();
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(28),
      build: (context) {
        return pw.Container(
          padding: const pw.EdgeInsets.all(24),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColor.fromHex('#0F5244'), width: 3),
          ),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'Certificate of Completion',
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#0F5244'),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(width: 120, height: 2, color: PdfColor.fromHex('#42D3A5')),
              pw.SizedBox(height: 18),
              pw.Text(
                'This certifies that',
                style: const pw.TextStyle(fontSize: 13),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                detail.studentFullName,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 14),
              pw.Text(
                'has successfully completed the course',
                style: const pw.TextStyle(fontSize: 13),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                detail.courseTitle,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#075E4D'),
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 26),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Instructor',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColor.fromHex('#6B7280'),
                        ),
                      ),
                      pw.Text(
                        detail.instructorFullName,
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Issued on',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColor.fromHex('#6B7280'),
                        ),
                      ),
                      pw.Text(
                        issued,
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Code: ${detail.certificateCode}',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromHex('#6B7280'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  return doc.save();
}

/// Shares the built certificate PDF through the platform share sheet,
/// using the certificate code as the file name.
Future<void> shareCertificatePdf({
  required List<int> bytes,
  required String certificateNumber,
}) {
  return Printing.sharePdf(
    bytes: Uint8List.fromList(bytes),
    filename: 'certificate-$certificateNumber.pdf',
  );
}
