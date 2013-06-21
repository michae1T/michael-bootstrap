# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

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
NOTES_LOAD_ALIASES=1 source notes

alias vi=vim

NO_SHELL=1 source set-env

