# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

shopt -s progcomp

sreplace() {
        perl -pi -e "s/$1/$2/g" `grep -Irs $1 * | awk -F: '{ print $1 }'`
}

esreplace() {
        perl -pi -e "s/$1/$2/g" `egrep -Irs $1 * | awk -F: '{ print $1 }'`
}

_cnotes() {
local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -f ~/bin/_notes/$1.$cur | cut -d"/" -f6 | awk -F '.' '{ print $2 }' ) )
}

complete -o filenames -F _cnotes commands
complete -o filenames -F _cnotes todo
complete -o filenames -F _cnotes queries

alias vi=vim

