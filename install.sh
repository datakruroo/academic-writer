#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

chmod +x "$SCRIPT_DIR/scripts/new-doc"
chmod +x "$SCRIPT_DIR/scripts/new-doc-intake"

ln -sf "$SCRIPT_DIR/scripts/new-doc" /usr/local/bin/new-doc
ln -sf "$SCRIPT_DIR/scripts/new-doc-intake" /usr/local/bin/new-doc-intake

echo "✓ new-doc installed"
echo "✓ new-doc-intake installed"
echo ""
echo "Usage:"
echo "  new-doc <type> <project-name>         — สร้าง project + template intent.md"
echo "  new-doc-intake <type> <project-name>  — สร้าง project + สัมภาษณ์ด้วย Hermes"
echo ""
echo "Types: article | proposal | policy | report"
echo ""
echo "Env vars สำหรับ new-doc-intake:"
echo "  export OPENROUTER_API_KEY=sk-or-..."
echo "  export OPENROUTER_MODEL=nousresearch/hermes-3-llama-3.1-70b  (optional)"
