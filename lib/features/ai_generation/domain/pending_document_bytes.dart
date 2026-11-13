/// Holds PDF bytes only for the active import → generate session.
///
/// Bytes are never written to SQLite. [take] removes the entry so a completed
/// or discarded import cannot regenerate from stale data by accident.
abstract interface class PendingDocumentBytesStore {
  void put(String documentImportId, List<int> bytes);

  List<int>? peek(String documentImportId);

  List<int>? take(String documentImportId);

  void discard(String documentImportId);

  void clear();
}

final class InMemoryPendingDocumentBytesStore
    implements PendingDocumentBytesStore {
  final Map<String, List<int>> _bytes = {};

  @override
  void put(String documentImportId, List<int> bytes) {
    _bytes[documentImportId] = List<int>.unmodifiable(bytes);
  }

  @override
  List<int>? peek(String documentImportId) => _bytes[documentImportId];

  @override
  List<int>? take(String documentImportId) => _bytes.remove(documentImportId);

  @override
  void discard(String documentImportId) {
    _bytes.remove(documentImportId);
  }

  @override
  void clear() => _bytes.clear();
}
