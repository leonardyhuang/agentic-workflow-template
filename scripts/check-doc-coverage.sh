#!/bin/bash
# =============================================================================
# Check that code changes are reflected in documentation.
# Adapt the patterns below to match your project's source and doc paths.
# =============================================================================

set -e

CHANGED=$(git diff --cached --name-only 2>/dev/null || git diff --name-only)

echo "▶ Checking documentation coverage..."

# Example: if src/ changes, docs/reference/ should also change
# SRC_CHANGED=$(echo "$CHANGED" | grep -E "^src/" || true)
# DOC_CHANGED=$(echo "$CHANGED" | grep -E "^docs/reference/" || true)
#
# if [ -n "$SRC_CHANGED" ] && [ -z "$DOC_CHANGED" ]; then
#     echo "⚠️  Source files changed without reference doc updates."
#     echo "   Source: $(echo "$SRC_CHANGED" | tr '\n' ' ')"
#     echo "   Consider updating docs/reference/"
# fi

echo "✅ Documentation coverage check passed (template — adapt patterns for your stack)"
