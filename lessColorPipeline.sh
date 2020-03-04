#!/usr/bin/env bash
#Shell Script for implementing less color in Terminal -syntax highlighting

#Script Global Variables
fileHighlight="$HOME/Desktop/Bash/CommonFormat.sh"

#Pigment selector for reading Python files (.py) in the terminal
# pygmentize your-file | less -R

#Case 0: MAC HOMEBREW
#pipe highlight to less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style solarized-light"
export LESS=" -R"

#Set the alias values
alias less='less -m -N -g -i -j --line-numbers --underline-special'
alias more='less'

#Implement the alias for 'CAT'
alias cat="highlight $1 --out-format xterm256 --line numbers --quiet --force --style solarized-light"

#Secondary homebrew options
# brew install source-highlight

#Case 1: edit ~/.bashrc
export LESSOPEN="| /usr/local/bin/src-highlight-lessColorPipeline.sh %s"
export LESS=" -R "
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
alias less='less -m -N -g -i -j --underline-special --SILENT'
alias more='less'

#X-TERM processing
highlight -O xterm256 $fileHighlight | less -R
source-highlight -o STDOUT -i $fileHighlight | elinks -dump -dump-color-mode 3 | less -R
