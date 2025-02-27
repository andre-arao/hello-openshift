#!/bin/bash
# script customizado para copiar o pg_hba.conf

#rm -rf /var/lib/postgresql/data/pgdata/postmaster.pid

chown -R postgres:postgres /var/lib/postgresql/data/pgdata

# Copia o arquivo pg_hba.conf do ConfigMap ou de outro local para o diretório de dados
cp /etc/postgresql/pg_hba.conf /var/lib/postgresql/data/pgdata/pg_hba.conf

sleep 10

# Executa o comando de inicialização padrão do PostgreSQL
#exec docker-entrypoint.sh postgres
