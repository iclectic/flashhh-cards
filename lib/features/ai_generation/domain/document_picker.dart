/// A PDF the person selected. Bytes stay out of the domain model.
final class PickedDocument {
  const PickedDocument({required this.fileName, required this.byteSize});

  final String fileName;
  final int byteSize;
}

/// Platform file dialog. Implementations must not keep PDF bytes in memory
/// beyond validation.
abstract interface class DocumentPicker {
  Future<PickedDocument?> pickPdf();
}
