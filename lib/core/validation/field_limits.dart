/// Shared length limits for stored text and generated drafts.
abstract final class FieldLimits {
  static const int deckName = 80;
  static const int deckDescription = 500;
  static const int question = 500;
  static const int answer = 2000;
  static const int tag = 30;
  static const int maxTags = 8;
  static const int sourceReference = 200;
  static const int fileName = 255;
  static const int failureCode = 64;
  static const int pageSize = 50;
  static const int maxPageSize = 200;
}
