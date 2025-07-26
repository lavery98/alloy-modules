#!/usr/bin/env bash

echo "Performing Alloy linting"

# Check to see if alloy is installed
if [[ "$(command -v alloy)" = "" ]]; then
  echo "alloy is required to lint Alloy modules"
  exit 1
fi

statusCode=0

while read -r file; do
  message=$(alloy fmt "${file}" 2>&1)
  currentCode="$?"
  message=$(echo "${message}" | grep -v "Error: encountered errors during formatting")

  # if the current code is 0, output the file name for logging purposes
  if [[ "${currentCode}" == 0 ]]; then
    echo "$file - no issues found"
  else
    echo "$file - issues found"
    while IFS= read -r row; do
      line=$(echo "${row}" | awk -F ':' '{print $2}')
      column=$(echo "${row}" | awk -F ':' '{print $3}')
      error=$(echo "${row}" | cut -d':' -f4-)
      echo "::error file=${file},line=${line},col=${column}::${error}"
    done <<< "${message}"
  fi

  # Only override the statusCode if it is 0
  if [[ "$statusCode" == 0 ]]; then
    statusCode="$currentCode"
  fi
done < <(find . -type f -name "*.alloy" -not -path "./node_modules/*" -not -path "./.git/*" || true)

if [[ "$statusCode" == 0 ]]; then
  echo "No issues found"
fi

exit "$statusCode"
