cd () {
   local pwd="${PWD}/"; # we need a slash at the end so we can check for it, too
   if [[ "$1" == "-e" ]]; then
      shift
      # start from the end
      [[ "$2" ]] && builtin cd "${pwd%/$1/*}/${2:-$1}/${pwd##*/$1/}" || builtin cd "$@"
   else
      # start from the beginning
      if [[ "$2" ]]; then
         builtin cd "${pwd/$1/$2}"
         pwd
      else
         builtin cd "$@"
      fi
   fi
}
log() {
   echo -e "$(date +%m.%d_%H:%M) $@"| tee -a $OUTPUT_LOG
}

err() {
   echo -e "$(date +%m.%d_%H:%M) $@" |tee -a $OUTPUT_LOG
}
