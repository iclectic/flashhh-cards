import express from 'express';
import multer from 'multer';
import { PDFParse } from 'pdf-parse';
import { generateFlashcards, sectionsFromText } from './heuristic.js';
import { generateWithOpenAi } from './openai.js';

const app = express();
const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: Number(process.env.MAX_UPLOAD_BYTES || 20 * 1024 * 1024),
  },
});

app.use(express.json({ limit: '2mb' }));

app.get('/health', (_req, res) => {
  res.json({
    ok: true,
    service: 'flashhh-api',
    openai: Boolean(process.env.OPENAI_API_KEY),
  });
});

app.post('/v1/documents/extract', upload.single('file'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({
        error: { code: 'missing_file', message: 'Attach a PDF as file.' },
      });
    }
    const name = (req.file.originalname || '').toLowerCase();
    if (!name.endsWith('.pdf')) {
      return res.status(400).json({
        error: { code: 'invalid_type', message: 'Only PDF documents can be imported.' },
      });
    }

    const parser = new PDFParse({ data: req.file.buffer });
    try {
      const result = await parser.getText();
      const text = (result?.text || '').trim();
      const usedOcr = text.length < 40;
      const sections = sectionsFromText(
        text ||
          'This PDF had little extractable text. Add notes or enable OCR on the server.',
      );
      const characterCount = sections.reduce((sum, s) => sum + s.text.length, 0);
      return res.json({
        documentImportId: req.body.documentImportId || null,
        characterCount,
        pageCount: result?.total || null,
        usedOcr,
        sections,
      });
    } finally {
      await parser.destroy().catch(() => {});
    }
  } catch (error) {
    console.error('extract failed', error);
    return res.status(500).json({
      error: {
        code: 'extract_failed',
        message: 'The document could not be read.',
      },
    });
  }
});

app.post('/v1/flashcards/generate', async (req, res) => {
  try {
    const {
      documentImportId,
      sections,
      desiredCount = 12,
      difficulty = 'intermediate',
      questionStyle = 'mixed',
    } = req.body || {};

    if (!Array.isArray(sections) || sections.length === 0) {
      return res.status(400).json({
        error: {
          code: 'missing_sections',
          message: 'Provide extracted text sections to generate cards.',
        },
      });
    }

    const normalizedSections = sections
      .map((section, index) => ({
        reference: String(section.reference || `section-${index + 1}`),
        text: String(section.text || '').trim(),
      }))
      .filter((section) => section.text.length > 0);

    if (normalizedSections.length === 0) {
      return res.status(400).json({
        error: {
          code: 'empty_sections',
          message: 'The document did not contain enough text to draft cards.',
        },
      });
    }

    const apiKey = process.env.OPENAI_API_KEY;
    let payload;
    if (apiKey) {
      payload = await generateWithOpenAi({
        apiKey,
        sections: normalizedSections,
        desiredCount,
        difficulty,
        questionStyle,
      });
    } else {
      payload = generateFlashcards({
        sections: normalizedSections,
        desiredCount,
        difficulty,
        questionStyle,
      });
    }

    if (!payload || !Array.isArray(payload.flashcards)) {
      return res.status(502).json({
        error: {
          code: 'bad_model_payload',
          message: 'The draft cards could not be read. Try generating them again.',
        },
      });
    }

    return res.json({
      documentImportId: documentImportId || null,
      flashcards: payload.flashcards,
      generator: apiKey ? 'openai' : 'heuristic',
    });
  } catch (error) {
    console.error('generate failed', error);
    return res.status(error.status || 500).json({
      error: {
        code: 'generate_failed',
        message: 'Flashcards could not be generated right now.',
        detail: error.detail,
      },
    });
  }
});

export function createApp() {
  return app;
}

const port = Number(process.env.PORT || 8080);
if (process.env.NODE_ENV !== 'test') {
  app.listen(port, () => {
    console.log(`flashhh-api listening on ${port}`);
  });
}
