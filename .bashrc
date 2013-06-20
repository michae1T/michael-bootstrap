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

export NOTES_BIN=$HOME/bin
export NOTES_DIR=$HOME/Dropbox/Michael/notes
export NOTES_VAULT_DIR=$HOME/private
export NOTES_VAULT_BUCKET=v

_cnotes_top() {
local cur
  if [[ ! $COMP_CWORD -gt 2 ]] ; then
    if [[ $COMP_CWORD == "2" ]] ; 
      then COMPREPLY=( $($1 ${COMP_WORDS[1]} ls ${COMP_WORDS[2]}) )
      else COMPREPLY=( $($1 ls ${COMP_WORDS[1]}) )
    fi;
  fi;
}
_cnotes() {
local cur
  if [[ ! $COMP_CWORD -gt 1 ]] ; then
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $($1 ls $cur) )
  fi;
}

complete -o filenames -F _cnotes_top notes
complete -o filenames -F _cnotes_top vault
complete -o filenames -F _cnotes commands
complete -o filenames -F _cnotes todo
complete -o filenames -F _cnotes queries
complete -o filenames -F _cnotes passwords

alias vi=vim

NO_SHELL=1 source set-env

