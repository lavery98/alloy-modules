#!/usr/bin/env bash

echo "Performing Markdown formatting"

statusCode=0
pnpm markdownlint-cli2 --fix "**/*.md" "#node_modules"
currentCode="$?"

# Only override the statusCode if it is 0
if [[ "$statusCode" == 0 ]]; then
  statusCode="$currentCode"
fi

pnpm prettier --write "**/*.md"
currentCode="$?"

# Only override the statusCode if it is 0
if [[ "$statusCode" == 0 ]]; then
  statusCode="$currentCode"
fi

if [[ "$statusCode" == 0 ]]; then
  echo "No issues found"
fi

exit "$statusCode"
