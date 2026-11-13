import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/validation/text_rules.dart';

abstract final class AccountValidator {
  static final _emailPattern = RegExp(
    r'^[A-Za-z0-9.!#$%&*+/=?^_`{|}~-]+@[A-Za-z0-9-]+(?:\.[A-Za-z0-9-]+)+$',
  );

  static String email(String value) {
    final normalized = normalizeWhitespace(value).toLowerCase();
    if (normalized.isEmpty) {
      throw const ValidationException(message: 'Enter an email address.');
    }
    if (normalized.length > FieldLimits.email) {
      throw const ValidationException(
        message: 'Email addresses can be up to 254 characters.',
      );
    }
    if (!_emailPattern.hasMatch(normalized)) {
      throw const ValidationException(
        message: 'Enter a valid email address.',
      );
    }
    return normalized;
  }

  static String displayName(String value) {
    final normalized = normalizeWhitespace(value);
    if (normalized.isEmpty) {
      throw const ValidationException(message: 'Enter a display name.');
    }
    if (normalized.length > FieldLimits.displayName) {
      throw const ValidationException(
        message: 'Display names can be up to 80 characters.',
      );
    }
    return normalized;
  }
}
