#!/usr/bin/env bash

statusCode=0

while read -r file; do
  message=$(./alloy-linux-amd64 fmt "${file}" 2>&1)
  currentCode="$?"
  message=$(echo "${message}" | grep -v "Error: encountered errors during formatting")

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

  if [[ "${statusCode}" == 0 ]]; then
    statusCode="${currentCode}"
  fi
done < <(find . -type f -name "*.alloy" -not -path "./.git/*" || true)

exit "$statusCode"
