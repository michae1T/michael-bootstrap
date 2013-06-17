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

git-update-deleted() {
        git status | grep deleted | perl -i -pe 's/\#\s+deleted:\s+/git rm /g' | bash
}

gack() {
	ack --ignore-dir=vendor --ignore-dir=log \
            --ignore-dir=share --ignore-dir=spec \
            --ignore-dir=target --ignore-dir=test-output \
            --ignore-dir=test \
          "$@"
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

