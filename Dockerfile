# stage 1
FROM golang:1.21 as base

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main .

# stage 2

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base ./app/static ./static

EXPOSE 8090

CMD [ "./main" ]



