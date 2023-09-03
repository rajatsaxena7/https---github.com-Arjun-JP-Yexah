import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerWeb extends StatefulWidget {
  final String filePath;
  const PdfViewerWeb({super.key, required this.filePath});

  @override
  State<PdfViewerWeb> createState() => _PdfViewerWebState();
}

final GlobalKey<SfPdfViewerState> _PdfViewerWebKey = GlobalKey();

class _PdfViewerWebState extends State<PdfViewerWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.asset(
        widget.filePath,
        key: _PdfViewerWebKey,
      ),
    );
  }
}
