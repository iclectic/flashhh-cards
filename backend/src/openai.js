/**
 * Optional OpenAI structured generation. Never required for local/dev.
 */

export async function generateWithOpenAi({
  apiKey,
  sections,
  desiredCount,
  difficulty,
  questionStyle,
}) {
  const material = sections
    .map((section) => `[${section.reference}]\n${section.text}`)
    .join('\n\n')
    .slice(0, 12000);

  const response = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: process.env.OPENAI_MODEL || 'gpt-4o-mini',
      temperature: 0.2,
      response_format: { type: 'json_object' },
      messages: [
        {
          role: 'system',
          content:
            'You draft study flashcards. Reply with JSON only: {"flashcards":[{"question":string,"answer":string,"difficulty":"easy"|"medium"|"hard","sourceReference":string}]}. No markdown.',
        },
        {
          role: 'user',
          content: `Create up to ${desiredCount} flashcards.\nDifficulty preference: ${difficulty}.\nStyle: ${questionStyle}.\nSource material:\n${material}`,
        },
      ],
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    const error = new Error(`OpenAI request failed (${response.status})`);
    error.status = 502;
    error.detail = body.slice(0, 400);
    throw error;
  }

  const payload = await response.json();
  const content = payload.choices?.[0]?.message?.content;
  if (!content) {
    const error = new Error('OpenAI returned an empty response');
    error.status = 502;
    throw error;
  }
  return JSON.parse(content);
}
