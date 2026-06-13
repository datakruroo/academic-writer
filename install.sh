#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

chmod +x "$SCRIPT_DIR/scripts/new-doc"
chmod +x "$SCRIPT_DIR/scripts/new-doc-intake"
chmod +x "$SCRIPT_DIR/scripts/aw"

ln -sf "$SCRIPT_DIR/scripts/new-doc" /usr/local/bin/new-doc
ln -sf "$SCRIPT_DIR/scripts/new-doc-intake" /usr/local/bin/new-doc-intake
ln -sf "$SCRIPT_DIR/scripts/aw" /usr/local/bin/aw

echo "✓ new-doc installed"
echo "✓ new-doc-intake installed"
echo "✓ aw installed"
echo ""
echo "Usage:"
echo "  new-doc <type> <project-name>              — สร้าง project + template intent.md"
echo "  aw intake <type> <project-name>            — สัมภาษณ์ด้วย Hermes + เขียนไฟล์อัตโนมัติ"
echo ""
echo "Types: article | proposal | policy | report"
echo ""
echo "Env vars:"
echo "  export OPENROUTER_API_KEY=sk-or-..."
echo "  export OPENROUTER_MODEL=nousresearch/hermes-3-llama-3.1-70b  (optional)"
