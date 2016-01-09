FROM alpine:3.2

RUN apk add --update curl \
  && rm -rf /var/cache/apk/*

# ENV CADDY_VERSION 0.8
ENV CADDY_FEATURES ""
  #^ "cors,git,hugo,ipfilter,jsonp,search"

RUN ARCH=$(if [ $(apk --print-arch) = x86_64 ]; then echo "amd64"; else $(apk --print-arch); fi) \
  && curl -fsSL "http://caddyserver.com/download/build?os=linux&arch=$ARCH&features=$CADDY_FEATURES" \
    | tar -xz -C /usr/bin \
  && chmod u+x /usr/bin/caddy

RUN printf "0.0.0.0\nbrowse /var/www" > /Caddyfile

EXPOSE 80 443 2015
CMD ["caddy"]
