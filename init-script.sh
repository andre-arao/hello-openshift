#!/bin/bash
# script customizado para copiar o pg_hba.conf

#rm -rf /var/lib/postgresql/data/pgdata/postmaster.pid

chown -R postgres:postgres /var/lib/postgresql/data/pgdata

#chmod 0600 /etc/ssl/server.key
#chmod 0600 /etc/ssl/server.crt

cp /etc/postgresql/postgresql.conf /var/lib/postgresql/data/pgdata/postgresql.conf

# Copia o arquivo pg_hba.conf do ConfigMap ou de outro local para o diretório de dados
cp /etc/postgresql/pg_hba.conf /var/lib/postgresql/data/pgdata/pg_hba.conf

sleep 10

# Executa o comando de inicialização padrão do PostgreSQL
#exec docker-entrypoint.sh postgres
