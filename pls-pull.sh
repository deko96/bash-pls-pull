#!/bin/bash

# Variables
WWW_ROOT="${1%/}"
PATTERN=$2
SUBDIR="${3%/}"

# Functions
debug () {

    if [ "$2" == "info" ] ; then
        COLOR="96m";
    elif [ "$2" == "success" ] ; then
        COLOR="92m";
    elif [ "$2" == "warning" ] ; then
        COLOR="93m";
    elif [ "$2" == "danger" ] ; then
        COLOR="91m";
    else #default color
        COLOR="0m";
    fi

    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "$STARTCOLOR%b$ENDCOLOR\e[m" "$1";
}

debug "Changing working directory to " "info"
debug "$WWW_ROOT\n"
cd $WWW_ROOT

debug "$WWW_ROOT\n\n" "success"

debug "Searching for " "info"
debug $PATTERN
debug " in " "info"
debug "$WWW_ROOT\n" "success"

WEBSITES=( $( ls -d */ | grep $PATTERN ) )
PULLABLES=()

debug "Found " "success"
debug ${#WEBSITES[@]}
debug " matches with pattern " "success"
debug $PATTERN "warning"
debug " in directory " "success"
debug "$WWW_ROOT\n\n"
printf '\e[93m%-6s\e[m\n' "${WEBSITES[@]}"

debug "\n----------------\n\n"

if [ -n "$SUBDIR" ]
then
  debug "Using SUBDIR method\n" "info"
  debug "SUBDIR="
  debug "$SUBDIR\n\n" "warning"

  for WEBSITE in "${WEBSITES[@]}"
  do
    WEBSITE="${WEBSITE%/}"
    WEBSITE_PATH="$WWW_ROOT/$WEBSITE"
    debug "Checking if subdirectory " "info"
    debug $SUBDIR
    debug " exists in " "info"
    debug "$WEBSITE_PATH -> "

    SUBDIR_PATH="$WEBSITE_PATH/$SUBDIR"
    if [ -d "$SUBDIR_PATH" ]
    then
      debug "OK\n" "success"
      PULLABLES+=("$SUBDIR_PATH")
    else
      debug "Not found\n" "warning"
      WEBSITES=("${WEBSITES[@]/$WEBSITE}")
    fi
  done
else
  PULLABLES=("${WEBSITES[@]}")
fi

debug "\n\n"

for WEBSITE_PATH in "${PULLABLES[@]}"
do

  debug "Running " "info"
  debug "git pull"
  debug " at " "info"
  debug "$WEBSITE_PATH\n"

  cd $WEBSITE_PATH

  if [ -d "$WEBSITE_PATH/.git" ]
  then
    CMD=$(git pull > /dev/null 2>&1)

    if [ $? -eq 0 ]
    then
      debug "UPDATED" "success"
    else
      debug "FAILED" "danger"
      debug " (update manually)" "warning"
      echo $CMD
    fi
  else
    debug "FAILED\n" "danger"
    debug "Not a git repository!\n" "warning"
    debug "Clone the repository manually."
  fi

  debug "\n\n"
done