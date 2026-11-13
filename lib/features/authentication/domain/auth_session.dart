import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_account.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    String? refreshToken,
    required AuthProvider provider,
    required DateTime issuedAt,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}
