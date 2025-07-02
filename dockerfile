# Estágio de Build
FROM python:3.13.5-alpine3.22 AS builder

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo de dependências
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Estágio Final
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho
WORKDIR /app

# Copia as dependências do estágio de build
COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copia os arquivos da aplicação
COPY . .

# Expõe a porta que a aplicação irá rodar
EXPOSE 8000

# Comando para iniciar a aplicação
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
