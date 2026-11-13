import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account.freezed.dart';
part 'user_account.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum AuthProvider { guest, email, google, apple }

@freezed
abstract class UserAccount with _$UserAccount {
  const factory UserAccount({
    required String id,
    String? email,
    required String displayName,
    required AuthProvider authProvider,
    required bool isGuest,
    required DateTime createdAt,
  }) = _UserAccount;

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);
}
