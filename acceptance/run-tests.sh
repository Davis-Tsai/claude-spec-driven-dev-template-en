#!/bin/sh
# =====================================================================
# Acceptance test entry point (single source for "how to run acceptance tests")
# The pre-commit hook calls this file.
#
# Once the tech stack is finalized (see charter/open-questions.md, ADR), replace the below with the actual commands,
# and ensure: all tests pass → exit 0; any failure → exit non-zero (so pre-commit can block).
# e.g.:  pytest acceptance/        (Python)
#        npm test                  (Node)
#        behave acceptance/software (Gherkin/behave)
# =====================================================================

echo "=================================================================="
echo "⚠️  Sync guard not yet in effect: the acceptance test command is not set up yet."
echo "    Currently pre-commit lets every commit through——"
echo "    this does not mean the code actually meets the contract, only that there are no tests to run yet."
echo "    Once the tech stack is finalized, fill the actual test command into acceptance/run-tests.sh,"
echo "    so the guard can truly block 'drift between documents and code'."
echo "=================================================================="

# No tests for now → let it through (return 0), to avoid blocking commits in the early stage.
exit 0
