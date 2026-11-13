import '../../../core/validation/text_rules.dart';

abstract final class QuizAnswerGrader {
  static String normalize(String value) {
    return normalizeWhitespace(value)
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '');
  }

  static bool matches({required String given, required String expected}) {
    final a = normalize(given);
    final b = normalize(expected);
    if (a.isEmpty || b.isEmpty) {
      return false;
    }
    return a == b;
  }
}
