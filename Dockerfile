FROM golang:1.24-alpine AS builder
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /app/action .

FROM golang:1.24-alpine AS final

COPY --from=builder /app/action /action

ENTRYPOINT ["/action"]
