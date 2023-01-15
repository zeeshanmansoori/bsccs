import 'package:bsccs/cubit/pdf_screen/pdf_screen_cubit.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  static const String routeName = "/PdfScreen";

  const PdfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pdfLink = ModalRoute.of(context)?.settings.arguments as String;
    var controller = PdfViewerController();

    return BlocProvider(
      create: (context) => PdfScreenCubit(pdfLink),
      child: Builder(builder: (context) {
        var cubit = context.read<PdfScreenCubit>();
        return Scaffold(
          appBar: WidgetUtils.csAppBar(titleText: "Pdf", actions: [
            BlocBuilder<PdfScreenCubit, PdfScreenState>(
              buildWhen: (p, c) => p.pdfFile != c.pdfFile,
              builder: (context, state) {
                var enabled = state.pdfFile == null;
                return WidgetUtils.saveButton(
                    enabled ? () => cubit.startDownload(pdfLink) : null);
              },
            ),
          ]),
          body: FutureBuilder(
            future: cubit.getFile(),
            builder: (context, snap) {
              var file = snap.data;

              if (file == null) {
                return Container(
                  color: CustomColors.primaryColor,
                );
              }

              var exists = file.existsSync();
              if (exists) {
                return SfPdfViewer.file(
                  file,
                  controller: controller,
                );
              }
              return SfPdfViewer.network(
                pdfLink,
                controller: controller,
              );
            },
          ),
        );
      }),
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
