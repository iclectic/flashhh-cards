// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => _UserAccount(
  id: json['id'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String,
  authProvider: $enumDecode(_$AuthProviderEnumMap, json['authProvider']),
  isGuest: json['isGuest'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserAccountToJson(_UserAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'authProvider': _$AuthProviderEnumMap[instance.authProvider]!,
      'isGuest': instance.isGuest,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$AuthProviderEnumMap = {
  AuthProvider.guest: 'guest',
  AuthProvider.email: 'email',
  AuthProvider.google: 'google',
  AuthProvider.apple: 'apple',
};
