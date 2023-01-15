import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'pdf_screen_state.dart';

class PdfScreenCubit extends Cubit<PdfScreenState> {
  final MethodChannel _channel = const MethodChannel("channel_downloader");
  final String _link;

  PdfScreenCubit(this._link) : super(const PdfScreenState());

  void startDownload(String pdfLink) async {
    var taskId =
        await _channel.invokeMethod("startDownload", {"link": pdfLink});
  }

  Future<File> getFile() async {
    final fileName = "${_getFileId(_link)}.pdf";
    var directory = await getExternalStorageDirectory();
    var downloadDir = Directory("${directory?.path}/Download");
    var file = File("${downloadDir.path}/$fileName");
    if(file.existsSync()) emit(state.copyWith(pdfFile: file));
    return file;
  }

  String _getFileId(String link) {
    var startIndex = link.indexOf("id=");
    var endIndex = link.lastIndexOf("&");
    return link.substring(startIndex + 3, endIndex);
  }
}
