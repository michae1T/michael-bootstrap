# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/bin:$HOME/.local/bin:$PATH

export VAULT_CRYPT_DIR=$HOME/Dropbox/Private
export VAULT_OPEN_DIR=$HOME/Private
export VAULT_ENCFS_CONFIG_FILE=$HOME/src/dropbox/encfs6.xml

export NOTES_DIR=$HOME/Dropbox/Michael/notes
export NOTES_VAULT_BUCKET=v


