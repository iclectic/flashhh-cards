import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/dependencies.dart';
import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../../decks/domain/deck.dart';
import '../domain/ai_models.dart';
import 'draft_review_controller.dart';

class DraftReviewPage extends ConsumerWidget {
  const DraftReviewPage({required this.args, super.key});

  final DraftReviewArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final review = ref.watch(draftReviewControllerProvider(args));
    final decks = ref.watch(_decksProvider);

    return switch (review) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(title: const Text('Drafting cards')),
        body: const LoadingView(label: 'Generating flashcard drafts'),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(title: const Text('Drafts')),
        body: ErrorStateView(
          message: failureFor(error).message,
          onRetry: () => ref.invalidate(draftReviewControllerProvider(args)),
        ),
      ),
      AsyncData(:final value) => _DraftReviewBody(
        args: args,
        state: value,
        decks: decks.asData?.value ?? const [],
      ),
    };
  }
}

final _decksProvider = FutureProvider<List<Deck>>((ref) async {
  final account = await ref.watch(localAccountProvider.future);
  return ref.watch(deckRepositoryProvider).listDecks(ownerId: account.id);
});

class _DraftReviewBody extends ConsumerStatefulWidget {
  const _DraftReviewBody({
    required this.args,
    required this.state,
    required this.decks,
  });

  final DraftReviewArgs args;
  final DraftReviewState state;
  final List<Deck> decks;

  @override
  ConsumerState<_DraftReviewBody> createState() => _DraftReviewBodyState();
}

class _DraftReviewBodyState extends ConsumerState<_DraftReviewBody> {
  var _saving = false;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review drafts'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? 'Saving…' : 'Save'),
          ),
        ],
      ),
      body: ResponsiveContent(
        child: state.drafts.isEmpty
            ? const Center(
                child: EmptyStateView(
                  title: 'No drafts kept',
                  message:
                      'Everything was filtered out. Try richer notes or generate again.',
                  icon: Icons.filter_alt_off_outlined,
                ),
              )
            : ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  Text(
                    '${state.drafts.length} draft'
                    '${state.drafts.length == 1 ? '' : 's'} from ${state.document.fileName}',
                    style: theme.textTheme.titleMedium,
                  ),
                  if (state.rejectedCount > 0) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${state.rejectedCount} weak draft'
                      '${state.rejectedCount == 1 ? '' : 's'} dropped automatically.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  DropdownButtonFormField<String>(
                    key: ValueKey('deck-${state.selectedDeckId ?? 'none'}'),
                    initialValue: state.selectedDeckId,
                    decoration: const InputDecoration(
                      labelText: 'Save into deck',
                    ),
                    items: [
                      for (final deck in widget.decks)
                        DropdownMenuItem(
                          value: deck.id,
                          child: Text(deck.name),
                        ),
                    ],
                    onChanged: _saving
                        ? null
                        : (value) => ref
                              .read(
                                draftReviewControllerProvider(
                                  widget.args,
                                ).notifier,
                              )
                              .selectDeck(value),
                  ),
                  if (widget.decks.isEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Create a deck first, then come back to save these drafts.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  for (final (index, draft) in state.drafts.indexed) ...[
                    _DraftEditor(
                      index: index,
                      draft: draft,
                      enabled: !_saving,
                      onChanged: (next) => ref
                          .read(
                            draftReviewControllerProvider(widget.args).notifier,
                          )
                          .updateDraft(index, next),
                      onRemove: () => ref
                          .read(
                            draftReviewControllerProvider(widget.args).notifier,
                          )
                          .removeDraft(index),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: Text(_saving ? 'Saving…' : 'Save approved cards'),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final saved = await ref
          .read(draftReviewControllerProvider(widget.args).notifier)
          .saveAccepted();
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            saved == 1 ? 'Saved 1 card.' : 'Saved $saved cards.',
          ),
        ),
      );
      context.go(AppRoutes.home);
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

class _DraftEditor extends StatelessWidget {
  const _DraftEditor({
    required this.index,
    required this.draft,
    required this.enabled,
    required this.onChanged,
    required this.onRemove,
  });

  final int index;
  final GeneratedFlashcardDraft draft;
  final bool enabled;
  final ValueChanged<GeneratedFlashcardDraft> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Card ${index + 1}'),
                const Spacer(),
                IconButton(
                  tooltip: 'Remove draft',
                  onPressed: enabled ? onRemove : null,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            TextFormField(
              initialValue: draft.question,
              enabled: enabled,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Question'),
              onChanged: (value) => onChanged(
                GeneratedFlashcardDraft(
                  question: value,
                  answer: draft.answer,
                  difficulty: draft.difficulty,
                  sourceReference: draft.sourceReference,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              initialValue: draft.answer,
              enabled: enabled,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Answer'),
              onChanged: (value) => onChanged(
                GeneratedFlashcardDraft(
                  question: draft.question,
                  answer: value,
                  difficulty: draft.difficulty,
                  sourceReference: draft.sourceReference,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
