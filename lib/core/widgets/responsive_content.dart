import 'package:flutter/widgets.dart';

import '../../app/theme/app_spacing.dart';

/// Centers page content and caps its width on larger screens.
class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.contentMaxWidth),
        child: child,
      ),
    );
  }
}
