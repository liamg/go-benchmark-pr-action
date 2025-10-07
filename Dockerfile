FROM golang:1.25-alpine AS builder
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /app/action .

FROM golang:1.25-alpine AS final

RUN apk add --no-cache git

COPY --from=builder /app/action /action

ENTRYPOINT ["/action"]
