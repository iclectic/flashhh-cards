/// A PDF the person selected.
///
/// [bytes] are kept only in memory for the generate upload — never in SQLite.
final class PickedDocument {
  const PickedDocument({
    required this.fileName,
    required this.byteSize,
    this.bytes,
  });

  final String fileName;
  final int byteSize;
  final List<int>? bytes;
}

/// Platform file dialog. Bytes are handed to the pending-bytes store for
/// generation, then discarded — never written to SQLite.
abstract interface class DocumentPicker {
  Future<PickedDocument?> pickPdf();
}
