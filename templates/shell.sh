#!/bin/sh

set -euo pipefail

USAGE="Usage: $0 [-f] [-o option] <argument>"

FLAG=false
OPTION="default"
ARGUMENT=""
while [[ $# -gt 0 ]]; do
  case $1 in
    -o|--option) OPTION="$2"; shift 2; ;;
    -f|--flag) FLAG=true; shift 1; ;;
    -h|--help) echo $USAGE; exit 1; ;;
    -*|--*) echo "Unknown option $1."; exit 1; ;;
    *) ARGUMENT=$1; shift 1; ;;
  esac
done

if [ -z "$ARGUMENT" ]; then
  echo "Positional argument required."
  exit 1
fi

