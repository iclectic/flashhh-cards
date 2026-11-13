import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/configuration/app_info.dart';
import '../../../app/dependencies.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/responsive_content.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeModeProvider).asData?.value ?? ThemeMode.system;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ResponsiveContent(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
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
