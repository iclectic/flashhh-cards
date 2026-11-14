import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/configuration/app_info.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  var _reloadToken = 0;

  Future<String> _load() =>
      rootBundle.loadString(AppInfo.privacyPolicyAsset);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy')),
      body: FutureBuilder<String>(
        key: ValueKey(_reloadToken),
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView(label: 'Loading privacy policy');
          }
          if (snapshot.hasError || snapshot.data == null) {
            return ErrorStateView(
              message: 'The privacy policy could not be loaded.',
              onRetry: () => setState(() => _reloadToken += 1),
            );
          }
          return ResponsiveContent(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: SelectableText(
                snapshot.data!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}
