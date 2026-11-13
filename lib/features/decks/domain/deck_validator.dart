import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/validation/text_rules.dart';

abstract final class DeckValidator {
  static String name(String value) {
    final normalized = normalizeWhitespace(value);
    if (normalized.isEmpty) {
      throw const ValidationException(message: 'Enter a deck name.');
    }
    if (normalized.length > FieldLimits.deckName) {
      throw const ValidationException(
        message: 'Deck names can be up to 80 characters.',
      );
    }
    return normalized;
  }

  static String description(String value) {
    final normalized = value.trim();
    if (normalized.length > FieldLimits.deckDescription) {
      throw const ValidationException(
        message: 'Descriptions can be up to 500 characters.',
      );
    }
    return normalized;
  }
}
