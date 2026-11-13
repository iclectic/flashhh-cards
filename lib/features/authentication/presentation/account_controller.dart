import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../domain/user_account.dart';

final accountControllerProvider =
    AsyncNotifierProvider<AccountController, UserAccount>(AccountController.new);

final syncStatusProvider = FutureProvider.autoDispose((ref) async {
  final outbox = ref.watch(syncOutboxRepositoryProvider);
  final pending = await outbox.pendingCount();
  return (
    pendingCount: pending,
    cloudSyncAvailable: false,
  );
});

final class AccountController extends AsyncNotifier<UserAccount> {
  @override
  Future<UserAccount> build() {
    return ref.read(accountRepositoryProvider).ensureLocalAccount();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepositoryProvider).ensureLocalAccount(),
    );
  }

  Future<void> linkEmail({
    required String email,
    required String displayName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(authServiceProvider)
          .linkEmail(email: email, displayName: displayName);
      ref.invalidate(localAccountProvider);
      ref.invalidate(syncStatusProvider);
      return result.account;
    });
  }

  Future<void> signOutToGuest() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final account = await ref.read(authServiceProvider).signOutToGuest();
      ref.invalidate(localAccountProvider);
      ref.invalidate(syncStatusProvider);
      return account;
    });
  }
}
