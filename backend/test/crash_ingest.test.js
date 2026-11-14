import assert from 'node:assert/strict';
import test from 'node:test';
import http from 'node:http';
import { createApp } from '../src/server.js';

function listen(app) {
  return new Promise((resolve) => {
    const server = http.createServer(app);
    server.listen(0, '127.0.0.1', () => {
      const { port } = server.address();
      resolve({ server, port });
    });
  });
}

test('crash ingest accepts scrubbed payloads', async () => {
  const app = createApp();
  const { server, port } = await listen(app);
  try {
    const response = await fetch(`http://127.0.0.1:${port}/v1/diagnostics/crash`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        fatal: true,
        errorType: 'StateError',
        message: 'boom',
        stack: 'StateError: boom',
        app: 'flashhh_cards',
      }),
    });
    assert.equal(response.status, 204);
  } finally {
    await new Promise((resolve) => server.close(resolve));
  }
});
