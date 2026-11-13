/// User-visible failure. This object never carries stack traces or causes.
enum AppFailureType {
  network,
  authentication,
  database,
  document,
  aiGeneration,
  validation,
  unexpected,
}

final class AppFailure {
  const AppFailure({required this.type, required this.message});

  final AppFailureType type;
  final String message;

  static const unexpectedMessage = 'Something went wrong. Please try again.';
}
