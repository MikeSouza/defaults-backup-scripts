#!/bin/bash

usage() {
    echo -e "Usage: $(basename $0) dir_path|file_path\n"
    echo -e "  dir_path - Directory path to import domain defaults from"
    echo -e "  file_path - File path to import domain defaults from\n"
}

if [[ -d "$1" ]]; then
  files=("$1"/*)
elif [[ -f "$1" ]]; then
  files=("$1")
elif [[ "$@" = "--help" ]] || [[ "$@" = "-h" ]]; then
  usage
  exit 0
else
  usage
  exit 1
fi

echo -e "Importing property lists for domain(s):\n"

count=0
for f in "${files[@]}"; do
  domain=$(basename "${f}")
  echo "  ${domain}"

  defaults import "${domain}" - < "${f}"
  ((count++))
done

echo -e "\nImported ${count} domain(s)\n"

