/// Product identity. Keep [version] aligned with `pubspec.yaml`.
abstract final class AppInfo {
  static const name = 'Flashhh';
  static const version = '0.1.0';
  static const buildNumber = '1';

  /// In-app privacy summary; host a public copy before store submission.
  static const privacyPolicyAsset = 'docs/store/privacy-policy.md';

  static const privacyContact = 'privacy@flashhh.app';
}
