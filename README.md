# clickhouse-jdbc-bug

## Steps to reproduce:
1. Start docker compose containers
```shell
docker compose up -d
```
You may need to wait for a while for jdbc initialization (~1-2 min for me).

2. Run script that reproduces the bug
```shell
./reproduce.sh
```

3. Tear down docker compose containers
```shell
docker compose down
```
