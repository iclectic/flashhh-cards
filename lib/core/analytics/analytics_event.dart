/// Product analytics events. Property values must not identify a person
/// or contain document or card text.
enum AnalyticsEvent {
  onboardingCompleted('onboarding_completed'),
  deckCreated('deck_created'),
  flashcardCreated('flashcard_created'),
  studySessionStarted('study_session_started'),
  studySessionCompleted('study_session_completed'),
  pdfUploaded('pdf_uploaded'),
  aiGenerationStarted('ai_generation_started'),
  aiGenerationCompleted('ai_generation_completed'),
  aiGenerationFailed('ai_generation_failed');

  const AnalyticsEvent(this.wireName);

  final String wireName;
}

/// Keys that must never be sent to an analytics provider.
abstract final class AnalyticsPrivacy {
  static const blockedPropertyKeys = {
    'email',
    'name',
    'displayname',
    'question',
    'answer',
    'documenttext',
    'filename',
    'token',
    'authorization',
  };

  static Map<String, Object?> sanitize(Map<String, Object?> properties) {
    final safe = <String, Object?>{};
    for (final entry in properties.entries) {
      if (blockedPropertyKeys.contains(entry.key.toLowerCase())) {
        continue;
      }
      final value = entry.value;
      if (value == null || value is num || value is bool) {
        safe[entry.key] = value;
        continue;
      }
      if (value is String && value.length <= 80) {
        safe[entry.key] = value;
      }
    }
    return safe;
  }
}
