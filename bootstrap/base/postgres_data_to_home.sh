#!/bin/bash

source `dirname $0`/../_environment.sh

yum_safe -y install install selinux-policy-devel

echo "configuring postgres"

export PGHOME=/home/postgres
export PGDATA=$PGHOME/data
PGHOME_R=`path_regex $PGHOME`
PGDATA_R=`path_regex $PGDATA`
PGHOME_ORIGINAL_R=`path_regex /var/lib/pgsql`

if [ -d "$PGHOME" ] ; then
  systemctl stop postgresql.service
  if [ -n "$CLEAR_PGHOME" ] ; then
    echo "clearing $PGHOME and starting again..."
    rm -rf $PGHOME
  else
    EXISTING_DB=1
  fi;
fi;

mkdir -p $PGHOME
chown postgres:postgres $PGHOME

# change postgres users home directory
sed -i "s/$PGHOME_ORIGINAL_R/$PGHOME_R/" /etc/passwd 

# change PGDATA in systemd service file
PGDATA="$PGHOME""/data"
sed -i "s/^Environment=PGDATA=.*/Environment=PGDATA=$PGDATA_R/" /usr/lib/systemd/system/postgresql.service

systemctl --system daemon-reload

if [ -z "$EXISTING_DB" ] ; then
  su - postgres -c "PGDATA=$PGDATA postgresql-setup initdb" \
   || su - postgres -c "PGDATA=$PGDATA initdb"
fi;

######### SELINUX ###########

# http://wiki.postgresql.org/wiki/Move_PGDATA_Fedora_17

# change PGHOME selinux context
semanage fcontext -a -t postgresql_db_t "$PGHOME(/.*)?"
restorecon -R -v $PGHOME

# allow postgres to search /home
cd /tmp
rm -rf selinux.local
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

###########################

sleep 10

systemctl enable postgresql.service
systemctl start postgresql.service

sleep 10

if [ -z "$EXISTING_DB" ] ; then
  su - postgres -c "createuser --no-superuser --no-createdb --no-createrole michael"
fi;

sed -i "s/ident\|peer/trust/g" \
    $PGDATA/pg_hba.conf

restorecon $PGDATA/pg_hba.conf

systemctl restart postgresql.service

