#!/usr/bin/env bash

echo "Performing Editorconfig linting"

statusCode=0
pnpm editorconfig-checker
currentCode="$?"

# Only override the statusCode if it is 0
if [[ "$statusCode" == 0 ]]; then
  statusCode="$currentCode"
fi

if [[ "$statusCode" == 0 ]]; then
  echo "No issues found"
  echo ""
fi

echo ""

exit "$statusCode"
