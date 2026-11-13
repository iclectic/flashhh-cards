import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../domain/ai_models.dart';
import 'document_import_controller.dart';

class DocumentImportPage extends ConsumerWidget {
  const DocumentImportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imports = ref.watch(documentImportListControllerProvider);
    final maxMb = (ref.watch(appConfigProvider).maxUploadBytes / (1024 * 1024))
        .round();
    return Scaffold(
      appBar: AppBar(title: const Text('Import PDF')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pick(context, ref),
        icon: const Icon(Icons.upload_file_outlined),
        label: const Text('Choose PDF'),
      ),
      body: switch (imports) {
        AsyncLoading() => const LoadingView(label: 'Loading imports'),
        AsyncError(:final error) => ErrorStateView(
          message: failureFor(error).message,
          onRetry: () =>
              ref.invalidate(documentImportListControllerProvider),
        ),
        AsyncData(:final value) => _ImportBody(
          imports: value,
          maxMb: maxMb,
          onPick: () => _pick(context, ref),
        ),
      },
    );
  }

  Future<void> _pick(BuildContext context, WidgetRef ref) async {
    try {
      final imported = await ref
          .read(documentImportListControllerProvider.notifier)
          .importPickedPdf();
      if (!context.mounted || imported == null) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '“${imported.fileName}” is ready. Card generation needs the Flashhh backend next.',
          ),
        ),
      );
    } on AppException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    }
  }
}

class _ImportBody extends ConsumerWidget {
  const _ImportBody({
    required this.imports,
    required this.maxMb,
    required this.onPick,
  });

  final List<DocumentImport> imports;
  final int maxMb;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (imports.isEmpty) {
      return Center(
        child: EmptyStateView(
          title: 'No PDFs yet',
          message:
              'Choose a PDF up to $maxMb MB. Flashhh keeps metadata only — not the file — and will draft cards once the backend is connected.',
          icon: Icons.picture_as_pdf_outlined,
          actionLabel: 'Choose PDF',
          onAction: onPick,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(documentImportListControllerProvider.notifier).refresh(),
      child: ResponsiveContent(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            88,
          ),
          itemCount: imports.length + 1,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Text(
                'Imports are validated on this device. Generating flashcards from the PDF ships with the AI backend.',
                style: Theme.of(context).textTheme.bodyMedium,
              );
            }
            final item = imports[index - 1];
            return _ImportTile(import: item);
          },
        ),
      ),
    );
  }
}

class _ImportTile extends ConsumerWidget {
  const _ImportTile({required this.import});

  final DocumentImport import;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizeKb = (import.byteSize / 1024).toStringAsFixed(0);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf_outlined),
        title: Text(import.fileName),
        subtitle: Text('$sizeKb KB · ${_statusLabel(import.status)}'),
        trailing: IconButton(
          tooltip: 'Remove import',
          onPressed: () => _discard(context, ref),
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }

  String _statusLabel(DocumentImportStatus status) {
    return switch (status) {
      DocumentImportStatus.selected => 'Selected',
      DocumentImportStatus.validating => 'Validating',
      DocumentImportStatus.extracting => 'Extracting',
      DocumentImportStatus.readyForGeneration => 'Ready to generate',
      DocumentImportStatus.generating => 'Generating',
      DocumentImportStatus.readyForReview => 'Ready for review',
      DocumentImportStatus.saved => 'Saved',
      DocumentImportStatus.failed => 'Failed',
      DocumentImportStatus.discarded => 'Discarded',
    };
  }

  Future<void> _discard(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Remove this import?',
      message:
          '“${import.fileName}” will be removed from your import list. The PDF itself was never stored in Flashhh.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (!confirmed) {
      return;
    }
    try {
      await ref
          .read(documentImportListControllerProvider.notifier)
          .discard(import.id);
    } on AppException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    }
  }
}
