# Etapa de construção da aplicação usando a imagem base do Golang com alias 'builder'
FROM golang:alpine AS builder

# Define o diretório de trabalho dentro do contêiner
WORKDIR /go/src/app

# Copia o código-fonte da aplicação para o diretório de trabalho no contêiner
COPY . .

# Compila o código-fonte da aplicação Go para gerar o executável 'main'
RUN go build main.go

# Define uma nova etapa de construção a partir de uma imagem vazia
FROM scratch

# Define o diretório de trabalho dentro do contêiner
WORKDIR /home

# Copia o executável gerado na etapa anterior para o diretório de trabalho no contêiner
COPY --from=builder /go/src/app/main .

# Define o comando padrão a ser executado ao iniciar o contêiner
CMD ["./main"]