import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  static const String routeName = "/PdfScreen";

  const PdfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pdfLink = ModalRoute.of(context)?.settings.arguments as String;
    var controller = PdfViewerController();

    return Scaffold(
      appBar: WidgetUtils.csAppBar(titleText: "Pdf"),
      body: SfPdfViewer.network(
        pdfLink,
        controller: controller,
      ),
    );
  }

  static navigate(BuildContext context, String link) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: link,
    );
  }
}
