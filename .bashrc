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
            --ignore-dir=test --ignore-dir=classes \
          "$@"
}

chmox() {
  chmod +x $@
}

export PATH=$HOME/bin:$HOME/.local/bin:$PATH

export VAULT_CRYPT_DIR=$HOME/Dropbox/Private
export VAULT_OPEN_DIR=$HOME/Private
export VAULT_ENCFS_CONFIG_FILE=$HOME/src/dropbox/encfs6.xml

export NOTES_DIR=$HOME/Dropbox/Michael/notes
export NOTES_VAULT_BUCKET=v

LOAD_COMPLETION=1 source vault
LOAD_COMPLETION=1 source notes
LOAD_COMPLETION=1 source set-laptop-mode

alias vi=vim

NO_SHELL=1 source set-env

