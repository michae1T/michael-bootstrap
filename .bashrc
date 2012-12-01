# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

sreplace() {
        echo $1 $2
        perl -pi -e "s/$1/$2/g" `grep -Irs $1 * | awk -F: '{ print $1 }'`
}

esreplace() {
        perl -pi -e "s/$1/$2/g" `egrep -Irs $1 * | awk -F: '{ print $1 }'`
}

