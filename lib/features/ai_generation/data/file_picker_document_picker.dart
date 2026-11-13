import 'package:file_picker/file_picker.dart';

import '../domain/document_picker.dart';

final class FilePickerDocumentPicker implements DocumentPicker {
  @override
  Future<PickedDocument?> pickPdf() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      dialogTitle: 'Choose a PDF',
    );
    if (file == null) {
      return null;
    }
    final name = file.name;
    final size = file.lengthSync() ?? await file.length();
    if (name.isEmpty || size == null || size <= 0) {
      return null;
    }
    return PickedDocument(fileName: name, byteSize: size);
  }
}
