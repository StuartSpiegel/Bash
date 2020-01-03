#you are given a text file that will be piped through STDIN
#use <grep> to display all the lines that contrain the word "the"
#search should be case sensitive, display only the lines of the
#text file that contain the word "the".
# -w, --word-regexp
# '[[:<:]]' and '[[:>:]]'

#execute the grep command to search for "the" filtering by word (-w)
#The expression itself is searched as if it were a word.
grep -w the

#search the actual word itself in each expression
grep 'the '

#clean exit
exit 0
