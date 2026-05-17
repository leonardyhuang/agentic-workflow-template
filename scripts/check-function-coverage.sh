#!/bin/bash
# =============================================================================
# Check that public functions are documented in reference docs.
# Extracts function names from source and compares against doc headings.
# Adapt the patterns below to match your project's conventions.
# =============================================================================

set -e

echo "▶ Checking function documentation coverage..."

# Example: extract exported functions from JS/TS
# SRC_FUNCS=$(find src -type f \( -name "*.js" -o -name "*.ts" \) -exec grep -hE "^export (async )?function " {} + 2>/dev/null | sed 's/.*function \([^ (]*\).*/\1/' | sort -u || true)

# Example: extract documented functions from reference markdown
# DOC_FUNCS=$(grep -hE "^### \`" docs/reference/*.md 2>/dev/null | sed 's/.*`\([^`]*\)`.*/\1/' | sort -u || true)

# Report undocumented and stale
# if [ -n "$SRC_FUNCS" ] || [ -n "$DOC_FUNCS" ]; then
#     ONLY_IN_SRC=$(comm -23 <(echo "$SRC_FUNCS") <(echo "$DOC_FUNCS") || true)
#     ONLY_IN_DOC=$(comm -13 <(echo "$SRC_FUNCS") <(echo "$DOC_FUNCS") || true)
#
#     if [ -n "$ONLY_IN_SRC" ]; then
#         echo "⚠️  Undocumented functions:"
#         echo "$ONLY_IN_SRC" | sed 's/^/  - /'
#     fi
#
#     if [ -n "$ONLY_IN_DOC" ]; then
#         echo "⚠️  Stale docs (function removed but still documented):"
#         echo "$ONLY_IN_DOC" | sed 's/^/  - /'
#     fi
# fi

echo "✅ Function coverage check passed (template — adapt patterns for your stack)"
