// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => _AuthSession(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String?,
  provider: $enumDecode(_$AuthProviderEnumMap, json['provider']),
  issuedAt: DateTime.parse(json['issuedAt'] as String),
);

Map<String, dynamic> _$AuthSessionToJson(_AuthSession instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'provider': _$AuthProviderEnumMap[instance.provider]!,
      'issuedAt': instance.issuedAt.toIso8601String(),
    };

const _$AuthProviderEnumMap = {
  AuthProvider.guest: 'guest',
  AuthProvider.email: 'email',
  AuthProvider.google: 'google',
  AuthProvider.apple: 'apple',
};
