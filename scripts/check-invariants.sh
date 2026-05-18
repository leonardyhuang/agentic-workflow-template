#!/bin/bash
# =============================================================================
# Comprehensive invariant checker — run manually or in CI.
# Adapt the grep patterns below to your project's invariants.
# =============================================================================

set -e

FAILED=0

echo "▶ Running invariant checks..."

# ---------------------------------------------------------------------------
# 1. No raw API fetches outside designated helpers
# ---------------------------------------------------------------------------
# RAW_FETCHES=$(grep -rn "fetch\|axios\|request" src/ --include="*.js" --include="*.ts" | grep -v "helpers/api\|utils/http" || true)
# if [ -n "$RAW_FETCHES" ]; then
#     echo "❌ Raw fetches found outside designated helper files:"
#     echo "$RAW_FETCHES"
#     FAILED=1
# fi

# ---------------------------------------------------------------------------
# 2. No hardcoded user-visible strings
# ---------------------------------------------------------------------------
# HARDCODED=$(grep -rn "textContent\|innerHTML\|aria-label" src/ --include="*.js" --include="*.ts" | grep -v "dataset\." | grep -E '"[^"]+"' || true)
# if [ -n "$HARDCODED" ]; then
#     echo "❌ Hardcoded user-visible strings found:"
#     echo "$HARDCODED"
#     FAILED=1
# fi

# ---------------------------------------------------------------------------
# 3. Section markers match AGENTS.md
# ---------------------------------------------------------------------------
if [ -f "AGENTS.md" ]; then
    AGENTS_REGIONS=$(sed -n '/## Section Markers/,/## /p' AGENTS.md | grep "^| \`" | sed 's/.*|`\([^`]*\)`|.*/\1/' | sort -u || true)
    if [ -n "$AGENTS_REGIONS" ]; then
        echo "▶ Checking section marker sync..."
        # Adapt SRC_PATTERN to your source files
        # SRC_REGIONS=$(find src -type f \( -name "*.js" -o -name "*.ts" \) -exec grep -h "// #region" {} + 2>/dev/null | sed 's/.*#region //' | sort -u || true)
        # MISSING=$(comm -23 <(echo "$AGENTS_REGIONS") <(echo "$SRC_REGIONS") || true)
        # if [ -n "$MISSING" ]; then
        #     echo "❌ Regions in AGENTS.md not found in source:"
        #     echo "$MISSING"
        #     FAILED=1
        # fi
    fi
fi

# ---------------------------------------------------------------------------
# 4. No cryptic abbreviations in source
# ---------------------------------------------------------------------------
# ABBREVS=$(grep -rnE "\b[a-zA-Z]{2,4}El\b|\b[a-zA-Z]{2,4}Btn\b|\bff\b|\bctx\b" src/ --include="*.js" --include="*.ts" || true)
# if [ -n "$ABBREVS" ]; then
#     echo "❌ Cryptic abbreviations found:"
#     echo "$ABBREVS"
#     FAILED=1
# fi

# ---------------------------------------------------------------------------
# 5. Bug-fix test mandate
# ---------------------------------------------------------------------------
CHANGED=$(git diff --name-only 2>/dev/null || true)
if [ -n "$CHANGED" ]; then
    SRC_CHANGED=$(echo "$CHANGED" | grep -E "^src/.*\.(js|ts|rs|py|go)$" || true)
    TEST_CHANGED=$(echo "$CHANGED" | grep -E "^(tests?|spec|__tests__)/" || true)
    if [ -n "$SRC_CHANGED" ] && [ -z "$TEST_CHANGED" ]; then
        echo "⚠️  Source files changed without corresponding test changes."
        echo "   If this is a bug fix, you MUST add a regression test."
        echo "   Changed: $(echo "$SRC_CHANGED" | tr '\n' ' ')"
        # Uncomment to make this a hard failure:
        # FAILED=1
    fi
fi

# ---------------------------------------------------------------------------
# 6. Documentation hygiene
# ---------------------------------------------------------------------------
if [ -n "$CHANGED" ]; then
    KEY_CHANGED=$(echo "$CHANGED" | grep -vE "CONVENTIONS\.md|AGENTS\.md|README\.md|TECHNICAL_DEBT\.md|\.gitignore|\.husky|package|docs/" || true)
    DOC_CHANGED=$(echo "$CHANGED" | grep -E "CONVENTIONS\.md|AGENTS\.md|README\.md|TECHNICAL_DEBT\.md|docs/" || true)
    if [ -n "$KEY_CHANGED" ] && [ -z "$DOC_CHANGED" ]; then
        echo "⚠️  Key source files changed without documentation updates."
        echo "   Changed: $(echo "$KEY_CHANGED" | tr '\n' ' ')"
    fi
fi

# ---------------------------------------------------------------------------
# Add project-specific invariants below
# ---------------------------------------------------------------------------

if [ "$FAILED" -eq 1 ]; then
    echo ""
    echo "❌ Invariant checks failed"
    exit 1
else
    echo "✅ Invariant checks passed"
fi
