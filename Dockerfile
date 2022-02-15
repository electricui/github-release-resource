FROM golang:1.14 as builder
COPY . /go/src/github.com/electricui/github-release-resource
WORKDIR /go/src/github.com/electricui/github-release-resource
RUN curl -sL https://taskfile.dev/install.sh | sh
RUN ./bin/task build

FROM alpine:3.11 as resource
COPY --from=builder /go/src/github.com/electricui/github-release-resource/build /opt/resource
RUN chmod +x /opt/resource/*

FROM resource
LABEL MAINTAINER=electricui