# caddy

```
docker build -t local/caddy .
```

```
docker run \
  --volume $PWD/Caddyfile:/Caddyfile \
  --volume $PWD/certs:/root/.caddy \
  --volume $PWD/www:/var/www \
  --publish 80:80 \
  --publish 443:443 \
  local/caddy
```
