#!/bin/bash
# volt setup script — installs deps and links the `volt` command

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENT="$SCRIPT_DIR/agent.py"

echo ""
echo "  Setting up volt..."
echo ""

# Check Python 3.10+
PYTHON=$(command -v python3 || command -v python)
if [ -z "$PYTHON" ]; then
  echo "  ✗ Python 3.10+ is required but not found."
  exit 1
fi

PY_VERSION=$($PYTHON -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
PY_MAJOR=$($PYTHON -c "import sys; print(sys.version_info.major)")
PY_MINOR=$($PYTHON -c "import sys; print(sys.version_info.minor)")

if [ "$PY_MAJOR" -lt 3 ] || ([ "$PY_MAJOR" -eq 3 ] && [ "$PY_MINOR" -lt 10 ]); then
  echo "  ✗ Python 3.10+ required (found $PY_VERSION)"
  exit 1
fi
echo "  ✓ Python $PY_VERSION"

# Install anthropic SDK
echo "  Installing anthropic SDK..."
$PYTHON -m pip install anthropic --quiet --break-system-packages 2>/dev/null \
  || $PYTHON -m pip install anthropic --quiet

echo "  ✓ anthropic SDK installed"

# Make agent executable
chmod +x "$AGENT"

# Try to link to a location in PATH
LINK_TARGETS=("$HOME/.local/bin/volt" "/usr/local/bin/volt")
LINKED=""

for TARGET in "${LINK_TARGETS[@]}"; do
  DIR="$(dirname "$TARGET")"
  if [ -d "$DIR" ] && [ -w "$DIR" ]; then
    ln -sf "$AGENT" "$TARGET"
    LINKED="$TARGET"
    break
  fi
done

if [ -n "$LINKED" ]; then
  echo "  ✓ Linked: $LINKED"
  echo ""
  echo "  You're all set! Run:  volt"
else
  echo "  ⚠  Could not link to PATH automatically."
  echo "     Add this alias to your ~/.zshrc or ~/.bashrc:"
  echo ""
  echo "     alias volt='$PYTHON $AGENT'"
  echo ""
fi

# Remind about API key
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "  ⚠  Set your API key:"
  echo ""
  echo "     export ANTHROPIC_API_KEY=sk-ant-..."
  echo "     (add to ~/.zshrc or ~/.bashrc to persist)"
fi

echo ""
echo "  Done. Happy volting 🐾"
echo ""
