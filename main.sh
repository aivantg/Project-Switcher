#!/bin/bash
HOMEFILEPATH="/Users/aivant/.project_switcher"
function export-dev-path(){
  while IFS=, read -r -a array
  do
    export BASEDEVPATH="${array[0]}"
  done < "$HOMEFILEPATH/base_path.txt"
}

export-dev-path

function update-dev-path(){
  echo $1 > tmp
  mv tmp /Users/aivant/.project_switcher/base_path.txt
  export-dev-path
}

function dev-path(){
  echo "Current Dev Path: $BASEDEVPATH"
  echo "Change with 'update-dev-path <new path>'"
}

function mkalias(){
  echo "$1,$2" >> "$HOMEFILEPATH/project_aliases.txt"
}

function lsalias(){
  echo -e "\n---Current Aliases---\n"
  while IFS=, read -r -a array
  do
    echo "${array[0]} --> ${array[1]} "
  done < "$HOMEFILEPATH/project_aliases.txt"
  echo -e "\nAdd more with 'mkalias <shortname> <path>'\nRemove with 'rmalias <shortname>'\n"
}

function rmalias(){
  echostring="Aliases Removed:"
  while IFS=, read -r -a array
  do
    if [ "${array[0]}" != "$1" ]; then
      echo "${array[0]},${array[1]}"
    else
      echostring="$echostring\n${array[0]} --> ${array[1]}"
    fi

  done < /Users/aivant/.project_switcher/project_aliases.txt > temp
  mv temp /Users/aivant/.project_switcher/project_aliases.txt
  if [ "$echostring" != "Aliases Removed:" ]; then
    echo -e "$echostring"
  else
    echo -e "No aliases found matching pattern: '$1'"
  fi
}


function dev(){
  # Read aliases from alias file
  declare -A PROJALIASES
  while IFS=, read -r -a array
  do
    PROJALIASES["${array[0]}"]="${array[1]}"
  done < "$HOMEFILEPATH/project_aliases.txt"

  PROJSTRING="$BASEDEVPATH"
  for PARAM in "$@"
  do
    FOLDER=${PROJALIASES[$PARAM]}
    if [ "$FOLDER" = "" ]; then
      CHECKINGPREFIXES=false
      PROJSTRING="$PROJSTRING/$PARAM"
    else
      PROJSTRING="$PROJSTRING/$FOLDER"
    fi
  done
  cd $PROJSTRING
}
