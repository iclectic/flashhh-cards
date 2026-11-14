import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/configuration/app_info.dart';
import '../../../app/dependencies.dart';
import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../../authentication/domain/user_account.dart';
import '../../authentication/presentation/account_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeModeProvider).asData?.value ?? ThemeMode.system;
    final account = ref.watch(accountControllerProvider);
    final syncStatus = ref.watch(syncStatusProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ResponsiveContent(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Account', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Guest mode always works offline. Linking an email upgrades this '
              'device account in place so your decks keep the same IDs for a '
              'future sync.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            switch (account) {
              AsyncLoading() => const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: LoadingView(label: 'Loading account'),
              ),
              AsyncError(:final error) => Text(
                failureFor(error).message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              AsyncData(:final value) => _AccountSection(account: value),
            },
            const SizedBox(height: AppSpacing.lg),
            Text('Sync', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            syncStatus.when(
              loading: () => const Text('Counting pending changes…'),
              error: (error, _) => Text(failureFor(error).message),
              data: (status) => Text(
                status.cloudSyncAvailable
                    ? '${status.pendingCount} changes waiting to sync.'
                    : status.pendingCount == 0
                    ? 'No local changes queued. Cloud sync is not connected yet.'
                    : '${status.pendingCount} local changes queued. Cloud sync '
                        'is not connected yet — they stay on this device.',
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Choose how Flashhh looks. The selected option is labeled, not only colored.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            for (final option in _options)
              _ThemeOptionTile(
                option: option,
                selected: themeMode == option.mode,
                onSelected: () => _select(context, ref, option.mode),
              ),
            const SizedBox(height: AppSpacing.xl),
            Text('About', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            const Text('${AppInfo.name} ${AppInfo.version}'),
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy policy'),
              subtitle: const Text(
                'What stays on this device, and what leaves it',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoutes.privacy),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _select(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
  ) async {
    try {
      await ref.read(preferencesRepositoryProvider).setThemeMode(mode);
    } on AppException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    }
  }
}

class _AccountSection extends ConsumerStatefulWidget {
  const _AccountSection({required this.account});

  final UserAccount account;

  @override
  ConsumerState<_AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends ConsumerState<_AccountSection> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  var _submitting = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.account.email ?? '';
    _nameController.text = widget.account.isGuest
        ? ''
        : widget.account.displayName;
  }

  @override
  void didUpdateWidget(covariant _AccountSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.account != widget.account) {
      _emailController.text = widget.account.email ?? '';
      _nameController.text = widget.account.isGuest
          ? ''
          : widget.account.displayName;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final account = widget.account;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            account.isGuest
                ? Icons.person_outline
                : Icons.verified_user_outlined,
          ),
          title: Text(account.displayName),
          subtitle: Text(
            account.isGuest
                ? 'Guest on this device'
                : account.email ?? 'Signed in with email',
          ),
        ),
        if (account.isGuest) ...[
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'you@example.com',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _nameController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Display name',
              hintText: 'How you want to appear',
            ),
            onSubmitted: (_) => _link(),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: _submitting ? null : _link,
            child: Text(_submitting ? 'Linking…' : 'Link email on this device'),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Google and Apple sign-in will appear when the Flashhh account '
            'service is available. They are not shown as dead buttons.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ] else ...[
          OutlinedButton(
            onPressed: _submitting ? null : _signOut,
            child: Text(
              _submitting ? 'Switching…' : 'Use as guest on this device',
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _link() async {
    setState(() => _submitting = true);
    try {
      await ref
          .read(accountControllerProvider.notifier)
          .linkEmail(
            email: _emailController.text,
            displayName: _nameController.text,
          );
      if (!mounted) {
        return;
      }
      final next = ref.read(accountControllerProvider);
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failureFor(next.error!).message)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email linked on this device.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<void> _signOut() async {
    setState(() => _submitting = true);
    try {
      await ref.read(accountControllerProvider.notifier).signOutToGuest();
      if (!mounted) {
        return;
      }
      final next = ref.read(accountControllerProvider);
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failureFor(next.error!).message)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Back to guest mode on this device.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }
}

class _ThemeChoice {
  const _ThemeChoice({
    required this.mode,
    required this.label,
    required this.description,
    required this.icon,
  });

  final ThemeMode mode;
  final String label;
  final String description;
  final IconData icon;
}

const _options = [
  _ThemeChoice(
    mode: ThemeMode.system,
    label: 'System',
    description: 'Match the device appearance',
    icon: Icons.brightness_auto_outlined,
  ),
  _ThemeChoice(
    mode: ThemeMode.light,
    label: 'Light',
    description: 'Always use the light theme',
    icon: Icons.light_mode_outlined,
  ),
  _ThemeChoice(
    mode: ThemeMode.dark,
    label: 'Dark',
    description: 'Always use the dark theme',
    icon: Icons.dark_mode_outlined,
  ),
];

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.option,
    required this.selected,
    required this.onSelected,
  });

  final _ThemeChoice option;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(option.icon),
        title: Text(option.label),
        subtitle: Text(option.description),
        trailing: selected ? const Text('Selected') : const SizedBox(width: 72),
        selected: selected,
        onTap: onSelected,
      ),
    );
  }
}
