import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/dependencies.dart';
import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/offline_banner.dart';
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
      appBar: AppBar(
        title: const Text('Import'),
        actions: [
          TextButton(
            onPressed: () => context.push(AppRoutes.importNotes),
            child: const Text('Paste notes'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pick(context, ref),
        icon: const Icon(Icons.upload_file_outlined),
        label: const Text('Choose PDF'),
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: switch (imports) {
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
          ),
        ],
      ),
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
            '“${imported.fileName}” is ready. Generate drafts when you are set.',
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
          title: 'Nothing imported yet',
          message:
              'Choose a PDF up to $maxMb MB, or paste notes. Drafts stay editable until you save them into a deck.',
          icon: Icons.picture_as_pdf_outlined,
          actionLabel: 'Paste notes',
          onAction: () => context.push(AppRoutes.importNotes),
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
                'PDFs need the Flashhh API for extraction. Notes can draft cards on-device. You always approve drafts before they enter a deck.',
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
    final canGenerate =
        import.status == DocumentImportStatus.readyForGeneration ||
        import.status == DocumentImportStatus.failed ||
        import.status == DocumentImportStatus.readyForReview;
    return Card(
      child: ListTile(
        leading: Icon(
          import.fileName.toLowerCase().endsWith('.pdf')
              ? Icons.picture_as_pdf_outlined
              : Icons.notes_outlined,
        ),
        title: Text(import.fileName),
        subtitle: Text('$sizeKb KB · ${_statusLabel(import.status)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canGenerate)
              TextButton(
                onPressed: () => context.push(AppRoutes.draftReview(import.id)),
                child: const Text('Generate'),
              ),
            IconButton(
              tooltip: 'Remove import',
              onPressed: () => _discard(context, ref),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
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
          '“${import.fileName}” will be removed from your import list. File bytes are never kept in Flashhh storage.',
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
