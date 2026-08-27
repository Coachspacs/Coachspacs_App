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

  final darkBackground = PdfColor.fromHex('#353C47');
  final gold = PdfColor.fromHex('#FFBC32');
  final white = PdfColors.white;
  final green = PdfColor.fromHex('#16D6A0');
  final divider = PdfColor.fromHex('#59616C');

  // =========================================================
  // MEDAL + LAUREL SVG
  // =========================================================

  const medalSvg = '''
<svg width="100" height="100"
     viewBox="0 0 100 100"
     xmlns="http://www.w3.org/2000/svg">

  <!-- Left laurel -->
  <path
    d="M30 76
       C18 67 12 52 14 36
       C16 23 23 14 31 8"
    fill="none"
    stroke="#FFBC32"
    stroke-width="4"
    stroke-linecap="round"/>

  <path
    d="M19 55 C11 54 9 49 10 43 C16 43 20 47 19 55"
    fill="#FFBC32"/>

  <path
    d="M17 42 C10 39 9 34 11 29 C17 31 19 36 17 42"
    fill="#FFBC32"/>

  <path
    d="M20 29 C15 25 16 20 19 16 C24 20 24 25 20 29"
    fill="#FFBC32"/>

  <!-- Right laurel -->
  <path
    d="M70 76
       C82 67 88 52 86 36
       C84 23 77 14 69 8"
    fill="none"
    stroke="#FFBC32"
    stroke-width="4"
    stroke-linecap="round"/>

  <path
    d="M81 55 C89 54 91 49 90 43 C84 43 80 47 81 55"
    fill="#FFBC32"/>

  <path
    d="M83 42 C90 39 91 34 89 29 C83 31 81 36 83 42"
    fill="#FFBC32"/>

  <path
    d="M80 29 C85 25 84 20 81 16 C76 20 76 25 80 29"
    fill="#FFBC32"/>

  <!-- Medal -->
  <circle
    cx="50"
    cy="38"
    r="25"
    fill="#FFBC32"/>

  <circle
    cx="50"
    cy="38"
    r="19"
    fill="#353C47"
    stroke="#FFBC32"
    stroke-width="3"/>

  <!-- Star -->
  <path
    d="M50 24
       L54 33
       L64 34
       L56 41
       L58 51
       L50 46
       L42 51
       L44 41
       L36 34
       L46 33
       Z"
    fill="#FFBC32"/>

  <!-- Ribbon -->
  <path
    d="M39 59 L39 88 L50 81 L61 88 L61 59"
    fill="#FFBC32"/>

</svg>
''';

  // =========================================================
  // PDF PAGE
  // =========================================================

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(28),
      build: (context) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            color: darkBackground,
            borderRadius: pw.BorderRadius.circular(14),
            border: pw.Border.all(
              color: gold,
              width: 2,
            ),
          ),
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 28,
          ),
          child: pw.Column(
            crossAxisAlignment:
            pw.CrossAxisAlignment.center,
            children: [
              // =====================================================
              // MEDAL ICON
              // =====================================================

              pw.Container(
                width: 78,
                height: 78,
                child: pw.SvgImage(
                  svg: medalSvg,
                  fit: pw.BoxFit.contain,
                ),
              ),

              pw.SizedBox(height: 8),

              // =====================================================
              // ACADEMY
              // =====================================================

              pw.Text(
                'COACHSPACE ACADEMY',
                style: pw.TextStyle(
                  color: gold,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 5),

              pw.Text(
                'CERTIFICATE OF EXCELLENCE',
                style: pw.TextStyle(
                  color: gold,
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 14),

              // =====================================================
              // INTRO
              // =====================================================

              pw.Text(
                'This is to certify that',
                style:  pw.TextStyle(
                  color: white,
                  fontSize: 10,
                ),
              ),

              pw.SizedBox(height: 9),

              // =====================================================
              // STUDENT NAME
              // =====================================================

              pw.Text(
                studentName,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  color: white,
                  fontSize: 25,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 7),

              pw.Container(
                width: 220,
                height: 2,
                color: gold,
              ),

              pw.SizedBox(height: 13),

              pw.Text(
                'has successfully completed the online course',
                style:  pw.TextStyle(
                  color: white,
                  fontSize: 10,
                ),
              ),

              pw.SizedBox(height: 9),

              // =====================================================
              // COURSE TITLE
              // =====================================================

              pw.Text(
                courseTitle,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.Spacer(),

              // =====================================================
              // DIVIDER
              // =====================================================

              pw.Container(
                height: 1,
                width: double.infinity,
                color: divider,
              ),

              pw.SizedBox(height: 12),

              // =====================================================
              // FOOTER INFORMATION
              // =====================================================

              pw.Row(
                mainAxisAlignment:
                pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                pw.CrossAxisAlignment.end,
                children: [
                  // -------------------------------------------------
                  // ISSUE DATE
                  // -------------------------------------------------

                  pw.Column(
                    crossAxisAlignment:
                    pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Issued On',
                        style:  pw.TextStyle(
                          color: white,
                          fontSize: 8,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        issueDate,
                        style: pw.TextStyle(
                          color: gold,
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // -------------------------------------------------
                  // VERIFIED
                  // -------------------------------------------------

                  pw.Column(
                    crossAxisAlignment:
                    pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Verified',
                        style:  pw.TextStyle(
                          color: white,
                          fontSize: 8,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        certificateId,
                        style: pw.TextStyle(
                          color: green,
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // -------------------------------------------------
                  // INSTRUCTOR
                  // -------------------------------------------------

                  pw.Column(
                    crossAxisAlignment:
                    pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Instructor Signature',
                        style:  pw.TextStyle(
                          color: white,
                          fontSize: 8,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        instructorName,
                        style: pw.TextStyle(
                          color: gold,
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

  // =========================================================
  // OPEN PDF PREVIEW / PRINT
  // =========================================================

  await Printing.layoutPdf(
    onLayout: (format) async {
      return pdf.save();
    },
  );
}