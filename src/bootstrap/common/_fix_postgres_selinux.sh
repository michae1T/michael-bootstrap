#!/bin/bash

# http://wiki.postgresql.org/wiki/Move_PGDATA_Fedora_17

# new home directory. create this, change owner to postgres:postgres, and
# change home dir for user "postgres" in /etc/passwd.
PGHOME=/home/postgres

# change PGDATA in systemd service file
PGDATA="$PGHOME""/data"
sed -i "s#^Environment=PGDATA=.*#Environment=PGDATA=$PGDATA#" /usr/lib/systemd/system/postgresql.service

# michael
systemctl --system daemon-reload


# change PGHOME selinux context
semanage fcontext -a -t postgresql_db_t "$PGHOME(/.*)?"
restorecon -R -v $PGHOME


# allow postgres to search /home
cd /root
mkdir selinux.local
cd selinux.local
chcon -R -t usr_t .
ln -s /usr/share/selinux/devel/Makefile .
touch postgresqlhome.fc
touch postgresqlhome.if

cat > postgresqlhome.te <<EOF
module postgresqlhome 0.1;

require {
        class dir search; 
        class lnk_file read;

        type home_root_t;
        type postgresql_t;
        type var_lib_t;
};

# Allow postgresql to search directory /home
allow postgresql_t home_root_t:dir search; 
EOF

make
semodule -i postgresqlhome.pp

