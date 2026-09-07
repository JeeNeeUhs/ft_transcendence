#building
FROM golang:1.25-alpine AS builder

WORKDIR /app
COPY . .

RUN test -d docs || go run github.com/swaggo/swag/cmd/swag@v1.16.6 init --generalInfo main.go --output docs
RUN CGO_ENABLED=0 GOOS=linux go build -o /server .

#running
FROM alpine:latest

COPY --from=builder /server /server

EXPOSE 8081

CMD ["/server"]
