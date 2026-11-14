import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/widgets/offline_banner.dart';
import '../../../core/widgets/responsive_content.dart';
import '../domain/ai_models.dart';
import 'document_import_controller.dart';

class NotesImportPage extends ConsumerStatefulWidget {
  const NotesImportPage({super.key});

  @override
  ConsumerState<NotesImportPage> createState() => _NotesImportPageState();
}

class _NotesImportPageState extends ConsumerState<NotesImportPage> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  var _saving = false;
  var _desiredCount = 12;
  var _difficulty = GenerationDifficulty.intermediate;
  var _style = QuestionStyle.mixed;

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paste notes')),
      body: Column(
        children: [
          const OfflineBanner(
            message:
                'You appear to be offline. Notes can still draft on this '
                'device with the local heuristic.',
          ),
          Expanded(
            child: ResponsiveContent(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
            Text(
              'Paste lecture notes or interview prep. Flashhh drafts cards locally or through the API, then you approve them.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _titleController,
              enabled: !_saving,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Systems design week 3',
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _notesController,
              enabled: !_saving,
              maxLines: 8,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Notes',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: _saving ? null : _generate,
              child: Text(_saving ? 'Working…' : 'Generate drafts'),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Cards to draft', style: Theme.of(context).textTheme.titleSmall),
            Slider(
              value: _desiredCount.toDouble(),
              min: 4,
              max: FieldLimits.pageSize.toDouble().clamp(4, 40),
              divisions: 18,
              label: '$_desiredCount',
              onChanged: _saving
                  ? null
                  : (value) => setState(() => _desiredCount = value.round()),
            ),
            const SizedBox(height: AppSpacing.sm),
            DropdownButtonFormField<GenerationDifficulty>(
              initialValue: _difficulty,
              decoration: const InputDecoration(labelText: 'Difficulty'),
              items: const [
                DropdownMenuItem(
                  value: GenerationDifficulty.beginner,
                  child: Text('Beginner'),
                ),
                DropdownMenuItem(
                  value: GenerationDifficulty.intermediate,
                  child: Text('Intermediate'),
                ),
                DropdownMenuItem(
                  value: GenerationDifficulty.advanced,
                  child: Text('Advanced'),
                ),
              ],
              onChanged: _saving
                  ? null
                  : (value) {
                      if (value != null) {
                        setState(() => _difficulty = value);
                      }
                    },
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<QuestionStyle>(
              initialValue: _style,
              decoration: const InputDecoration(labelText: 'Question style'),
              items: const [
                DropdownMenuItem(
                  value: QuestionStyle.factualRecall,
                  child: Text('Factual recall'),
                ),
                DropdownMenuItem(
                  value: QuestionStyle.conceptualUnderstanding,
                  child: Text('Conceptual'),
                ),
                DropdownMenuItem(
                  value: QuestionStyle.mixed,
                  child: Text('Mixed'),
                ),
              ],
              onChanged: _saving
                  ? null
                  : (value) {
                      if (value != null) {
                        setState(() => _style = value);
                      }
                    },
            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generate() async {
    setState(() => _saving = true);
    try {
      final imported = await ref
          .read(documentImportListControllerProvider.notifier)
          .importNotes(
            title: _titleController.text,
            notes: _notesController.text,
          );
      if (!mounted) {
        return;
      }
      await context.push(
        AppRoutes.draftReview(imported.id),
        extra: {
          'notes': _notesController.text,
          'desiredCount': _desiredCount,
          'difficulty': _difficulty.name,
          'questionStyle': _style.name,
        },
      );
    } on AppException catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }
}
