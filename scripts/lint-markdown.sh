#!/usr/bin/env bash

echo "Performing markdown linting"

statusCode=0
pnpm markdownlint-cli2 "**/*.md" "#node_modules"
currentCode="$?"

# Only override the statusCode if it is 0
if [[ "$statusCode" == 0 ]]; then
  statusCode="$currentCode"
fi

if [[ "$statusCode" == 0 ]]; then
  echo "No issues found"
fi

exit "$statusCode"
