#!/bin/bash

usage() {
  echo -e "Usage: $(basename $0) [options] [dir_path]\n"
  echo -e "  dir_path - Directory path to export domain defaults\n"
  echo -e "  options:"
  echo -e "    -a    Use 'Apple Global Domain' for global domain (Default: 'NSGlobalDomain')"
}

outdir_prefix="plists_"
timestamp="$(date "+%Y-%m-%d-%H%M%S")"
global_domain="NSGlobalDomain" # aka 'Apple Global Domain'

while getopts ":ha" opt; do
  case $opt in
    a)
      global_domain="Apple Global Domain"
      ;;
    h)
      usage
      exit 0
      ;;
    *)
      usage
      if [[ "$@" = "--help" ]]; then
        exit 0
      else
        exit 1
      fi
      ;;
  esac
done
shift $((OPTIND-1))

if [[ -z "$1" ]]; then
  outdir="${outdir_prefix}${timestamp}"
else
  outdir="$1"
fi

if [[ ! -d "${outdir}" ]]; then
  mkdir -p "${outdir}"
fi

echo -e "Exporting property lists for domain(s):\n"

IFS=',\ '; domains=($(defaults domains)); unset IFS

count=0
for domain in "${global_domain}" "${domains[@]}"; do
  echo "  ${domain}"
  echo $(defaults export "${domain}" -) > "${outdir}/${domain}"
  ((count++))
done

echo -e "\nExported ${count} domain(s)\n"

