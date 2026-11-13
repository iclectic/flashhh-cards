import 'user_account.dart';

abstract interface class AccountRepository {
  Future<UserAccount> ensureLocalAccount();

  Future<UserAccount?> findCurrent();

  Future<UserAccount> linkEmail({
    required String email,
    required String displayName,
  });

  Future<UserAccount> revertToGuest();
}
