import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_spacing.dart';
import '../networking/connectivity_status.dart';

/// Compact banner for screens that need the network (PDF upload / generation).
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({
    this.message =
        'You appear to be offline. PDF upload and cloud generation need a '
        'connection. Notes can still draft on this device.',
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reachability = ref.watch(networkReachabilityProvider);
    final offline = switch (reachability) {
      AsyncData(:final value) => value == NetworkReachability.offline,
      _ => false,
    };
    if (!offline) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return Semantics(
      liveRegion: true,
      label: message,
      child: Material(
        color: theme.colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Icon(
                Icons.wifi_off_outlined,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
