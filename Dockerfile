FROM alpine:latest AS builder
MAINTAINER Paul Novarese pvn@novarese.net
LABEL maintainer="pvn@novarese.net"
WORKDIR /src/solunar/
COPY . .
RUN apk update && apk add build-base gcc wget
RUN make clean && make

FROM alpine:latest
MAINTAINER Paul Novarese pvn@novarese.net
LABEL maintainer="pvn@novarese.net"
WORKDIR /opt/bin
COPY --from=builder /src/solunar/solunar .
RUN apk add -U tzdata && cp /usr/share/zoneinfo/America/Chicago /etc/localtime
HEALTHCHECK NONE
ENTRYPOINT ["/opt/bin/solunar"]
