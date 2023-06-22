FROM golang:1.20-alpine3.18 AS golang
ARG VERSION

ARG LOC=/service
RUN apk add --no-cache git
RUN mkdir -p $LOC
ENV GOPATH /go
COPY go.mod main.go $LOC/
WORKDIR $LOC
ENV CGO_ENABLED 0
RUN go build -ldflags "-X main.build=${VERSION}" -o tilt-gotest main.go

FROM alpine:3.18
ARG LOC=/service
ARG VERSION
WORKDIR /
VOLUME /tmp
RUN apk add --no-cache ca-certificates libcap
RUN update-ca-certificates
RUN mkdir -p /service
RUN addgroup -g 10001 -S app && \
    adduser -u 10001 -G app -S -D -h /service app && \
    chmod 755 /service
COPY --from=golang $LOC/tilt-gotest /service

EXPOSE 9090
RUN chmod +x /service/tilt-gotest
WORKDIR /service    
USER app
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:9090/ || exit 1
CMD ["/service/tilt-gotest"]

LABEL org.opencontainers.image.title="tilt-gotest" \
      org.opencontainers.image.authors="Roberto Scudeller <beto.rvs@gmail.com>" \
      org.opencontainers.image.source="https://github.com/betorvs/tilt-gotest"