import test from 'node:test';
import assert from 'node:assert/strict';
import { generateFlashcards, sectionsFromText } from '../src/heuristic.js';

test('sectionsFromText chunks paragraphs', () => {
  const sections = sectionsFromText('First idea lives here.\n\nSecond idea follows with more detail for studying.');
  assert.ok(sections.length >= 1);
  assert.equal(sections[0].reference, 'section-1');
});

test('generateFlashcards returns structured drafts', () => {
  const sections = sectionsFromText(
    'Photosynthesis converts light into chemical energy in plants. ' +
      'Chlorophyll absorbs photons in the thylakoid membrane. ' +
      'The Calvin cycle fixes carbon dioxide into sugars. ' +
      'ATP and NADPH power the dark reactions of photosynthesis.',
  );
  const { flashcards } = generateFlashcards({
    sections,
    desiredCount: 4,
    difficulty: 'intermediate',
    questionStyle: 'mixed',
  });
  assert.ok(flashcards.length >= 1);
  assert.ok(flashcards[0].question);
  assert.ok(flashcards[0].answer);
  assert.ok(['easy', 'medium', 'hard'].includes(flashcards[0].difficulty));
});
