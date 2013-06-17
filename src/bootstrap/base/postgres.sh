#!/bin/bash

source `dirname $0`/../_environment.sh

echo "configuring postgres"

export PGHOME=/home/postgres
export PGDATA=$PGHOME/data

if [ -d "$PGHOME" ] ; then 
  echo "clearing $PGHOME and starting again..."
  rm -rf $PGHOME
  mkdir $PGHOME
fi;

chown postgres:postgres $PGHOME
rm /etc/passwd.bak
mv /etc/passwd /etc/passwd.bak
sed s/\\/var\\/lib\\/pgsql/\\/home\\/postgres/ /etc/passwd.bak > /etc/passwd 

su - postgres -c "PGDATA=$PGDATA postgresql-setup initdb" \
 || su - postgres -c "PGDATA=$PGDATA initdb"

source $SHARED/_fix_postgres_selinux.sh

sleep 10

systemctl enable postgresql.service
systemctl start postgresql.service

sleep 10

su - postgres -c "createuser --no-superuser --no-createdb --no-createrole admin"
su - postgres -c "createuser --no-superuser --no-createdb --no-createrole michael"

rm -f $PGDATA/pg_hba.conf.bak
cp -f $PGDATA/pg_hba.conf $PGDATA/pg_hba.conf.bak
sed "s/ident\|peer/trust/g" \
    $PGDATA/pg_hba.conf \
    > pg_hba.conf
mv -f pg_hba.conf $PGDATA/pg_hba.conf
restorecon $PGDATA/pg_hba.conf

systemctl restart postgresql.service

