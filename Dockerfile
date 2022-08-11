FROM golang:alpine AS build

RUN go get github.com/jteeuwen/go-bindata/... \
    && go get github.com/tools/godep \
    && apk add --update git make \
    && git clone https://github.com/yudai/gotty \
    && cd gotty \
    && go mod init \
    && go mod tidy \
    && go mod vendor \
    && make \
    && mv gotty /

FROM docker:20.10.8

COPY --from=build /gotty /gotty

ENTRYPOINT [ "/gotty" ]
