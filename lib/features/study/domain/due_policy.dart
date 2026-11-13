/// A card is due when it has never been scheduled, or when [nextReviewAt]
/// is at or before [now].
abstract final class DuePolicy {
  static bool isDue({required DateTime? nextReviewAt, required DateTime now}) {
    if (nextReviewAt == null) {
      return true;
    }
    return !nextReviewAt.isAfter(now);
  }
}
