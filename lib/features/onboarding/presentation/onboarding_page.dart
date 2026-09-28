import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import 'onboarding_controller.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _controller = PageController();
  var _index = 0;
  var _saving = false;

  static const _pages = [
    _OnboardingCopy(
      icon: Icons.style_outlined,
      title: 'A calmer way to remember',
      message: 'Flashhh is a home for the decks you want to learn.',
    ),
    _OnboardingCopy(
      icon: Icons.cloud_off_outlined,
      title: 'Study without a connection',
      message: 'Decks, cards, and review history stay on this device.',
    ),
    _OnboardingCopy(
      icon: Icons.fact_check_outlined,
      title: 'You stay in control',
      message: 'When document import arrives, suggested cards stay drafts until you edit and save them.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final last = _index == _pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Step ${_index + 1} of ${_pages.length}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return Semantics(
                      label: 'Step ${index + 1} of ${_pages.length}',
                      child: _OnboardingBody(copy: item),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  if (_index > 0)
                    TextButton(
                      onPressed: _saving ? null : _back,
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _saving ? null : () => _forward(last),
                    child: Text(last ? 'Get started' : 'Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _back() {
    unawaited(
      _controller.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      ),
    );
  }

  Future<void> _forward(bool last) async {
    if (!last) {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
      return;
    }
    setState(() => _saving = true);
    final saved = await ref
        .read(onboardingControllerProvider.notifier)
        .complete();
    if (mounted) {
      setState(() => _saving = false);
    }
    if (!mounted || saved) {
      return;
    }
    final error = ref.read(onboardingControllerProvider).error;
    final message = error == null
        ? 'Flashhh could not save that choice. Try again.'
        : failureFor(error).message;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class _OnboardingCopy {
  const _OnboardingCopy({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody({required this.copy});

  final _OnboardingCopy copy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(copy.icon, size: 56, color: theme.colorScheme.primary),
        const SizedBox(height: AppSpacing.lg),
        Text(
          copy.title,
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          copy.message,
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
