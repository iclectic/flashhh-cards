import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      liveRegion: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ExcludeSemantics(child: CircularProgressIndicator()),
              const SizedBox(height: AppSpacing.md),
              ExcludeSemantics(
                child: Text(label, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
