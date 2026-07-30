#building
FROM golang:1.25-alpine AS builder

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o /server .

#running
FROM alpine:latest

COPY --from=builder /server /server

EXPOSE 8081

CMD ["/server"]
