/**
 * Offline-friendly flashcard drafts from plain text.
 * Used when OPENAI_API_KEY is absent so local/dev still produces structured cards.
 */

function splitChunks(text, maxLen = 900) {
  const cleaned = text.replace(/\r/g, '').trim();
  if (!cleaned) return [];
  const paragraphs = cleaned
    .split(/\n{2,}/)
    .map((p) => p.replace(/\s+/g, ' ').trim())
    .filter(Boolean);
  const chunks = [];
  let current = '';
  for (const paragraph of paragraphs) {
    if ((current + ' ' + paragraph).trim().length > maxLen && current) {
      chunks.push(current.trim());
      current = paragraph;
    } else {
      current = current ? `${current} ${paragraph}` : paragraph;
    }
  }
  if (current.trim()) chunks.push(current.trim());
  return chunks;
}

function sentencePairs(chunk) {
  const sentences = chunk
    .split(/(?<=[.!?])\s+/)
    .map((s) => s.trim())
    .filter((s) => s.length >= 40);
  const pairs = [];
  for (let i = 0; i < sentences.length; i += 1) {
    const sentence = sentences[i];
    const next = sentences[i + 1];
    pairs.push({ lead: sentence, support: next || sentence });
  }
  return pairs;
}

function difficultyFor(style, index) {
  if (style === 'beginner') return 'easy';
  if (style === 'advanced') return index % 2 === 0 ? 'hard' : 'medium';
  return index % 3 === 0 ? 'hard' : index % 3 === 1 ? 'medium' : 'easy';
}

export function sectionsFromText(text) {
  return splitChunks(text).map((chunk, index) => ({
    reference: `section-${index + 1}`,
    text: chunk,
  }));
}

export function generateFlashcards({
  sections,
  desiredCount = 12,
  difficulty = 'intermediate',
  questionStyle = 'mixed',
}) {
  const flashcards = [];
  const seen = new Set();
  const count = Math.max(1, Math.min(40, Number(desiredCount) || 12));

  for (const section of sections) {
    const pairs = sentencePairs(section.text || '');
    for (const [pairIndex, pair] of pairs.entries()) {
      if (flashcards.length >= count) break;
      let question;
      let answer;
      if (questionStyle === 'conceptual_understanding' || (questionStyle === 'mixed' && pairIndex % 2 === 1)) {
        question = `Explain the idea behind: “${pair.lead.slice(0, 160)}”`;
        answer = pair.support.slice(0, 2000);
      } else {
        question = `What does this note establish? “${pair.lead.slice(0, 160)}”`;
        answer = pair.support.slice(0, 2000);
      }
      const key = question.toLowerCase();
      if (seen.has(key)) continue;
      seen.add(key);
      flashcards.push({
        question,
        answer,
        difficulty: difficultyFor(difficulty, flashcards.length),
        sourceReference: section.reference,
      });
    }
    if (flashcards.length >= count) break;
  }

  // If the text was too short for sentence pairs, fall back to section-level cards.
  if (flashcards.length === 0) {
    for (const [index, section] of sections.entries()) {
      if (flashcards.length >= count) break;
      const text = (section.text || '').trim();
      if (text.length < 20) continue;
      flashcards.push({
        question: `Summarize ${section.reference}`,
        answer: text.slice(0, 2000),
        difficulty: difficultyFor(difficulty, index),
        sourceReference: section.reference,
      });
    }
  }

  return { flashcards };
}
