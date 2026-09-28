String normalizeWhitespace(String value) {
  return value.trim().replaceAll(RegExp(r'\s+'), ' ');
}

String normalizeTag(String value) => normalizeWhitespace(value).toLowerCase();

/// Escapes `\`, `%`, and `_` so user text is matched literally in SQL LIKE.
String escapeLike(String value) {
  return value
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
}
