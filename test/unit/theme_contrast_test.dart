import 'package:flashhh_cards/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light and dark text meets WCAG AA contrast', () {
    for (final theme in [AppTheme.light(), AppTheme.dark()]) {
      final scheme = theme.colorScheme;
      expect(
        _contrast(scheme.onSurface, scheme.surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrast(scheme.onPrimary, scheme.primary),
        greaterThanOrEqualTo(4.5),
      );
    }
  });
}

double _contrast(Color foreground, Color background) {
  final lighter = [
    foreground.computeLuminance(),
    background.computeLuminance(),
  ].reduce((a, b) => a > b ? a : b);
  final darker = [
    foreground.computeLuminance(),
    background.computeLuminance(),
  ].reduce((a, b) => a < b ? a : b);
  return (lighter + 0.05) / (darker + 0.05);
}
