import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/widgets/responsive_content.dart';
import '../domain/flashcard.dart';
import 'deck_cards_controller.dart';

class FlashcardFormPage extends ConsumerStatefulWidget {
  const FlashcardFormPage({required this.deckId, this.cardId, super.key});

  final String deckId;
  final String? cardId;

  bool get isEditing => cardId != null;

  @override
  ConsumerState<FlashcardFormPage> createState() => _FlashcardFormPageState();
}

class _FlashcardFormPageState extends ConsumerState<FlashcardFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _questionController;
  late final TextEditingController _answerController;
  late final TextEditingController _tagsController;
  Difficulty? _difficulty;
  var _hydrated = false;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _answerController = TextEditingController();
    _tagsController = TextEditingController();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _hydrateFrom(Flashcard card) {
    if (_hydrated) {
      return;
    }
    _hydrated = true;
    _questionController.text = card.question;
    _answerController.text = card.answer;
    _tagsController.text = card.tags.join(', ');
    _difficulty = card.difficulty;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      final detail = ref.watch(
        flashcardDetailControllerProvider(widget.cardId!),
      );
      return switch (detail) {
        AsyncLoading() => Scaffold(
          appBar: AppBar(title: const Text('Loading card')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        AsyncError(:final error) => Scaffold(
          appBar: AppBar(title: const Text('Card unavailable')),
          body: Center(child: Text(failureFor(error).message)),
        ),
        AsyncData(:final value) => _buildForm(context, existing: value),
      };
    }
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context, {Flashcard? existing}) {
    if (existing != null) {
      _hydrateFrom(existing);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(existing == null ? 'New card' : 'Edit card'),
        actions: [
          TextButton(
            onPressed: _saving ? null : () => _save(existing),
            child: Text(_saving ? 'Saving…' : 'Save card'),
          ),
        ],
      ),
      body: ResponsiveContent(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              TextFormField(
                controller: _questionController,
                enabled: !_saving,
                textCapitalization: TextCapitalization.sentences,
                maxLength: FieldLimits.question,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Enter a question.';
                  }
                  if (trimmed.length > FieldLimits.question) {
                    return 'Questions can be up to 500 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _answerController,
                enabled: !_saving,
                textCapitalization: TextCapitalization.sentences,
                maxLength: FieldLimits.answer,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Answer',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Enter an answer.';
                  }
                  if (trimmed.length > FieldLimits.answer) {
                    return 'Answers can be up to 2000 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Difficulty', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  ChoiceChip(
                    label: const Text('Not set'),
                    selected: _difficulty == null,
                    onSelected: _saving
                        ? null
                        : (_) => setState(() => _difficulty = null),
                  ),
                  for (final level in Difficulty.values)
                    ChoiceChip(
                      label: Text(level.name),
                      selected: _difficulty == level,
                      onSelected: _saving
                          ? null
                          : (_) => setState(() => _difficulty = level),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _tagsController,
                enabled: !_saving,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  labelText: 'Tags',
                  hintText: 'algorithms, networking',
                  helperText: 'Comma-separated, up to 8 tags',
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: _saving ? null : () => _save(existing),
                child: Text(_saving ? 'Saving…' : 'Save card'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _parseTags() {
    return _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }

  Future<void> _save(Flashcard? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _saving = true);
    try {
      final cards = ref.read(
        deckCardsControllerProvider(widget.deckId).notifier,
      );
      if (existing == null) {
        await cards.create(
          question: _questionController.text,
          answer: _answerController.text,
          difficulty: _difficulty,
          tags: _parseTags(),
        );
      } else {
        await cards.updateCard(
          id: existing.id,
          question: _questionController.text,
          answer: _answerController.text,
          difficulty: _difficulty,
          tags: _parseTags(),
        );
      }
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.deck(widget.deckId));
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
