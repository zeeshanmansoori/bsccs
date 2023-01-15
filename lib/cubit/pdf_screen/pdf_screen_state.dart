part of 'pdf_screen_cubit.dart';

class PdfScreenState extends Equatable {
  final File? pdfFile;

  @override
  List<Object?> get props => [pdfFile];

  const PdfScreenState({
    this.pdfFile,
  });

  PdfScreenState copyWith({
    File? pdfFile,
  }) {
    return PdfScreenState(
      pdfFile: pdfFile ?? this.pdfFile,
    );
  }
}
