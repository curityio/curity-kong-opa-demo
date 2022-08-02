FROM golang:1.18.5-alpine AS GO_BUILD
COPY . /server
WORKDIR /server/server
RUN go mod download github.com/gorilla/mux
RUN go build -o /go/bin/server/server

FROM alpine:latest
WORKDIR app
COPY --from=GO_BUILD /go/bin/server/ ./
EXPOSE 8080
CMD ./server 