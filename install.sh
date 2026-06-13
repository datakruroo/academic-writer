#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
chmod +x "$SCRIPT_DIR/scripts/new-doc"
ln -sf "$SCRIPT_DIR/scripts/new-doc" /usr/local/bin/new-doc
echo "✓ new-doc installed"
echo "Usage: new-doc <type> <project-name>"
echo "Types: article | proposal | policy | report"
