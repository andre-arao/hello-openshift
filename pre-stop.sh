#!/bin/bash
pg_ctl -D /var/lib/postgresql/data/pgdata stop -m immediate
ipcrm -M $(ipcs -m | grep postgres | awk '{print $2}')