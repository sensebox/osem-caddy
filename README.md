# caddy for OpenSenseMap

```
docker build -t osem-caddy .
```

```
docker run \
  --volume $PWD/certs:/root/.caddy \
  --env WEB_DOMAIN=your.web.domain \
  --env API_DOMAIN=your.api.domain \
  --env INGRESS_DOMAIN=your.ingress.domain \
  --env ISSUER_ADDRESS=your.email@domain \
  --publish 80:80 \
  --publish 443:443 \
  --publish 8000:8000 \
  caddy
```
