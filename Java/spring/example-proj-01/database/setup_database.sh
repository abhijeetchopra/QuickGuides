
# create database container
docker create --name postgres-demo -e POSTGRES_PASSWORD=ChangeThis! -p 5432:5432 postgres:11.5-alpine

# start database container
docker start postgres-demo

# create database
docker exec -it postgres-demo psql -U postgres -c 'create database conference_app;'

# create tables
docker cp create_tables.sql postgres-demo:/create_tables.sql
docker exec -it postgres-demo psql -d conference_app -f create_tables.sql -U postgres

# insert data
docker cp insert_data.sql postgres-demo:/insert_data.sql
docker exec -it postgres-demo psql -d conference_app -f insert_data.sql -U postgres
