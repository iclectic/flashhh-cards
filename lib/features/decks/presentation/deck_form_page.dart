import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/widgets/responsive_content.dart';
import '../domain/deck.dart';
import 'deck_list_controller.dart';

/// Creates a deck or renames an existing one.
class DeckFormPage extends ConsumerStatefulWidget {
  const DeckFormPage({super.key, this.deckId});

  final String? deckId;

  bool get isEditing => deckId != null;

  @override
  ConsumerState<DeckFormPage> createState() => _DeckFormPageState();
}

class _DeckFormPageState extends ConsumerState<DeckFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  var _hydrated = false;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _hydrateFrom(Deck deck) {
    if (_hydrated) {
      return;
    }
    _hydrated = true;
    _nameController.text = deck.name;
    _descriptionController.text = deck.description;
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.isEditing;
    if (editing) {
      final detail = ref.watch(deckDetailControllerProvider(widget.deckId!));
      return switch (detail) {
        AsyncLoading() => Scaffold(
          appBar: AppBar(title: const Text('Edit deck')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        AsyncError(:final error) => Scaffold(
          appBar: AppBar(title: const Text('Edit deck')),
          body: Center(child: Text(failureFor(error).message)),
        ),
        AsyncData(:final value) => _buildForm(context, existing: value),
      };
    }
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context, {Deck? existing}) {
    if (existing != null) {
      _hydrateFrom(existing);
    }
    final title = existing == null ? 'New deck' : 'Edit deck';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ResponsiveContent(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              TextFormField(
                controller: _nameController,
                enabled: !_saving,
                textCapitalization: TextCapitalization.sentences,
                maxLength: FieldLimits.deckName,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Biology midterm',
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Enter a deck name.';
                  }
                  if (trimmed.length > FieldLimits.deckName) {
                    return 'Deck names can be up to 80 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _descriptionController,
                enabled: !_saving,
                textCapitalization: TextCapitalization.sentences,
                maxLength: FieldLimits.deckDescription,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Optional notes about this deck',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  final text = value ?? '';
                  if (text.trim().length > FieldLimits.deckDescription) {
                    return 'Descriptions can be up to 500 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: _saving ? null : () => _save(existing),
                child: Text(_saving ? 'Saving…' : 'Save deck'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save(Deck? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _saving = true);
    try {
      final name = _nameController.text;
      final description = _descriptionController.text;
      final list = ref.read(deckListControllerProvider.notifier);
      if (existing == null) {
        final created = await list.createDeck(
          name: name,
          description: description,
        );
        if (!mounted) {
          return;
        }
        context.go(AppRoutes.deck(created.id));
        return;
      }
      final updated = await list.updateDeck(
        id: existing.id,
        name: name,
        description: description,
      );
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.deck(updated.id));
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
