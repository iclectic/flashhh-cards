/// Anki-style cloze markup helpers: `The {{c1::capital}} of France`.
abstract final class ClozeParser {
  static final RegExp _pattern = RegExp(r'\{\{c(\d+)::([^}]+)\}\}');

  static bool hasMarkup(String question) => _pattern.hasMatch(question);

  /// Prompt shown before reveal, with deletions blanked.
  static String prompt(String question) {
    return question.replaceAllMapped(_pattern, (_) => '[…]');
  }

  /// Full sentence with cloze text restored (no markup).
  static String revealed(String question) {
    return question.replaceAllMapped(
      _pattern,
      (match) => match.group(2) ?? '',
    );
  }

  /// Expected typed answers joined with "; " in markup order.
  static String expectedAnswer(String question) {
    return _pattern
        .allMatches(question)
        .map((match) => (match.group(2) ?? '').trim())
        .where((part) => part.isNotEmpty)
        .join('; ');
  }

  /// Number of `{{cN::…}}` deletions in [question].
  static int deletionCount(String question) =>
      _pattern.allMatches(question).length;
}
