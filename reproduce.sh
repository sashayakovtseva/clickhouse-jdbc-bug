#!/bin/sh

echo "CREATE TABLE IF NOT EXISTS test (uuid UUID PRIMARY KEY DEFAULT gen_random_uuid());
INSERT INTO test(uuid) VALUES ('39ec2fe2-ca39-40c5-9988-c7d2599bac09') ON CONFLICT DO NOTHING;" | \
docker compose exec -T postgres psql -U postgres postgres

echo "CREATE TABLE IF NOT EXISTS test (uuid UUID PRIMARY KEY DEFAULT gen_random_uuid());
INSERT INTO test(uuid) VALUES ('39ec2fe2-ca39-40c5-9988-c7d2599bac09') ON CONFLICT DO NOTHING;" | \
docker compose exec -T cockroach cockroach sql --insecure

echo "\n==========TEST POSTGRES UUID TO CLICKHOUSE UUID"
echo "CREATE TABLE IF NOT EXISTS pg_test_uuid_to_uuid (uuid UUID) ENGINE = JDBC('jdbc:postgresql://postgres:5432/postgres?user=postgres&password=root', 'public', 'test');" | \
docker compose exec -T clickhouse clickhouse client
docker compose exec -T clickhouse clickhouse client --query="SELECT * from test.pg_test_uuid_to_uuid"
echo "\r==========FINISH TEST POSTGRES UUID TO CLICKHOUSE UUID"

echo "\n==========TEST POSTGRES UUID TO CLICKHOUSE STRING"
echo "CREATE TABLE IF NOT EXISTS pg_test_uuid_to_string (uuid String) ENGINE = JDBC('jdbc:postgresql://postgres:5432/postgres?user=postgres&password=root', 'public', 'test');" | \
docker compose exec -T clickhouse clickhouse client
docker compose exec -T clickhouse clickhouse client --query="SELECT * from test.pg_test_uuid_to_string"
echo "\r==========FINISH TEST POSTGRES UUID TO CLICKHOUSE STRING"

echo "\n==========TEST COCKROACHDB UUID TO CLICKHOUSE UUID"
echo "CREATE TABLE IF NOT EXISTS cockroach_test_uuid_to_uuid (uuid UUID) ENGINE = JDBC('cockroach', 'public', 'test');" | \
docker compose exec -T clickhouse clickhouse client
docker compose exec -T clickhouse clickhouse client --query="SELECT * from test.cockroach_test_uuid_to_uuid"
echo "\r==========FINISH TEST COCKROACHDB UUID TO CLICKHOUSE UUID"

echo "\n==========TEST COCKROACHDB UUID TO CLICKHOUSE STRING"
echo "CREATE TABLE IF NOT EXISTS cockroach_test_uuid_to_string (uuid String) ENGINE = JDBC('cockroach', 'public', 'test');" | \
docker compose exec -T clickhouse clickhouse client
docker compose exec -T clickhouse clickhouse client --query="SELECT * from test.cockroach_test_uuid_to_string"
echo "\r==========FINISH TEST COCKROACHDB UUID TO CLICKHOUSE STRING"
