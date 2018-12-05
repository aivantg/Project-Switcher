#/usr/bin/env bash

ALIASES=""
while IFS=, read -r -a array
do
  ALIASES=("$ALIASES ${array[0]}")
done < "$HOMEFILEPATH/project_aliases.txt"
complete -W "$ALIASES" dev
