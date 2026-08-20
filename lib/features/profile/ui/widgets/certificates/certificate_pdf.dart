import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> downloadCertificatePdf({
  required String studentName,
  required String courseTitle,
  required String certificateId,
  required String issueDate,
  required String instructorName,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(28),
      build: (context) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#626B79'),
            borderRadius: pw.BorderRadius.circular(14),
            border: pw.Border.all(
              color: PdfColor.fromHex('#D9A52E'),
              width: 2,
            ),
          ),
          padding: const pw.EdgeInsets.all(35),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 8),

              pw.Container(
                width: 60,
                height: 60,
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#FFBC32'),
                  shape: pw.BoxShape.circle,
                ),
                child: pw.Center(
                  child: pw.SvgImage(
                    svg: '''
<svg width="32" height="32" viewBox="0 0 32 32"
     xmlns="http://www.w3.org/2000/svg">

  <circle
    cx="16"
    cy="12"
    r="7"
    fill="none"
    stroke="#000000"
    stroke-width="2"
  />

  <path
    d="M12 18 L12 29 L16 26 L20 29 L20 18"
    fill="none"
    stroke="#000000"
    stroke-width="2"
    stroke-linejoin="round"
  />

</svg>
''',
                  ),
                ),
              ),

              pw.SizedBox(height: 18),

              pw.Text(
                'COACHSPACE ACADEMY',
                style: pw.TextStyle(
                  color: PdfColor.fromHex('#FFBC32'),
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 6),

              pw.Text(
                'CERTIFICATE OF EXCELLENCE',
                style: pw.TextStyle(
                  color: PdfColor.fromHex('#FFBC32'),
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 12),

              pw.Text(
                'This is to certify that',
                style: const pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 10,
                ),
              ),

              pw.SizedBox(height: 12),

              pw.Text(
                studentName,
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 25,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Container(
                width: 220,
                height: 2,
                color: PdfColor.fromHex('#FFBC32'),
              ),

              pw.SizedBox(height: 16),

              pw.Text(
                'has successfully completed the online course',
                style: const pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 10,
                ),
              ),

              pw.SizedBox(height: 12),

              pw.Text(
                courseTitle,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.Spacer(),

              pw.Container(
                height: 1,
                width: double.infinity,
                color: PdfColor.fromHex('#353C47'),
              ),

              pw.SizedBox(height: 14),

              pw.Row(
                mainAxisAlignment:
                pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment:
                    pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Issued On',
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 8,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        issueDate,
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),

                  pw.Column(
                    children: [
                      pw.Text(
                        'Verified: $certificateId',
                        style: pw.TextStyle(
                          color: PdfColor.fromHex('#16D6A0'),
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),

                  pw.Column(
                    crossAxisAlignment:
                    pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Instructor Signature',
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 8,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        instructorName,
                        style: pw.TextStyle(
                          color: PdfColor.fromHex('#FFBC32'),
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}